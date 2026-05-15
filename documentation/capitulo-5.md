## 📖 CAPÍTULO 5: LO QUE NADIE TE EXPLICA DE LOS TEMPLATES UNIFICADOS...

Pues bien, este capítulo abarca muchos puntos importantes sobre la construcción y organización de templates en Infraestructura como Código (IaC).

En capítulos anteriores revisamos cómo construir templates básicos orientados a un único recurso de un servicio en AWS. Sin embargo, ahora toca comprender un enfoque mucho más cercano a escenarios reales: la unificación y organización lógica de templates.

Pero… ¿a qué nos referimos con templates unificados?

---

### 🟦 ¿Por qué no siempre es recomendable tener un template por cada recurso?

En muchos proyectos pequeños o medianos, no suele ser recomendable fragmentar excesivamente los templates creando un archivo independiente para cada recurso individual.

Por ejemplo, en lugar de tener:

- un template para un usuario IAM
- otro template para un rol IAM
- otro template para una política IAM

muchas veces resulta más mantenible agrupar dichos recursos relacionados dentro de un único template orientado al servicio o dominio funcional.

En este proyecto, llamaremos a este enfoque:

> **Templates Unificados**

Es decir, templates que agrupan múltiples recursos relacionados bajo una misma lógica de despliegue.

---

### 🟦 La verdadera ventaja de los templates unificados

La ventaja principal no es simplemente "juntar archivos".

La verdadera ventaja es que:

- reutilizamos lógica previamente validada
- reducimos fragmentación innecesaria
- simplificamos despliegues
- facilitamos mantenimiento
- mejoramos legibilidad arquitectónica
- centralizamos configuraciones relacionadas

Y algo muy importante:

**Primero construimos y validamos recursos individualmente.**

Luego:

- probamos comportamiento
- verificamos permisos
- entendemos dependencias
- analizamos errores

Y recién después unificamos dicha lógica en un template más grande y organizado.

Esto permite comprender realmente cómo interactúan los recursos entre sí.

---

### 🟦 Casos donde sí debemos separar templates

Sin embargo, existen escenarios particulares donde sí conviene separar despliegues o reutilizar templates de forma independiente.

Por ejemplo:

- recursos multi-región
- despliegues multi-cuenta
- stacks independientes
- componentes reutilizables
- equipos diferentes administrando infraestructura distinta

En dichos casos, muchas veces reutilizamos el mismo template parametrizado o dividimos la infraestructura en stacks separados según la arquitectura requerida.

---

### 🟦 Ejemplo práctico del proyecto

En este caso, previamente hemos creado el template correspondiente al rol IAM utilizado para la replicación multirregional de S3.

Dicho template permite crear el rol que será utilizado por el bucket origen para ejecutar correctamente el proceso de replicación entre regiones.

Posteriormente, este recurso será integrado dentro de un template unificado junto a la política IAM personalizada previamente creada.

[Rol-IAM-Replicacion-MultiRegional-S3](https://github.com/BrayanR03/Proyecto-IAC-Replicacion-MultiRegion-S3-AWS/blob/main/code/templates/individuales/template-rol-iam.yml)

---

### 🟦 Recomendaciones importantes al construir templates unificados

---

#### 🔹 1. Comprender correctamente las dependencias entre recursos

Uno de los puntos más importantes al trabajar con templates unificados es comprender qué recursos dependen de otros para poder ser creados correctamente. Por ejemplo:

**Un rol IAM puede requerir previamente una política IAM personalizada.**

Veamos un ejemplo simplificado:

```yaml
Resources:

  NombreRecurso1ServicioAWS:
    Propiedad1Recurso:
    Propiedad2Recurso:

  NombreRecurso2ServicioAWS:
    Propiedad1Recurso:
    Propiedad2Recurso:
    DependsOn: NombreRecurso1ServicioAWS
```
Aquí ya utilizamos:
```yaml
DependsOn
```
La cuál permite definir explícitamente que un recurso debe crearse antes que otro.

* ⚠️ Importante sobre DependsOn: 

    * CloudFormation muchas veces detecta automáticamente dependencias utilizando referencias implícitas como:

        * `!Ref`
        * `!GetAtt`

Por ello, no siempre necesitaremos utilizar `DependsOn`. Sin embargo, en escenarios específicos, sí resulta útil para forzar explícitamente el orden de creación entre recursos.

Conceptualmente, esto es similar a cómo Docker Compose utiliza `depends_on` para coordinar el orden de inicialización entre contenedores.

---

#### 🔹 2. Comprender qué información necesita un recurso de otro

Una vez identificadas las dependencias, debemos preguntarnos:

*¿Qué necesita exactamente mi recurso B de mi recurso A?*

Y aquí dependerá completamente del servicio AWS involucrado. En muchos casos, AWS solicita:

* ARNs
* IDs
* nombres
* atributos específicos
* endpoints
* configuraciones dinámicas

Por ejemplo:

* El rol IAM creado para este proyecto necesita asociarse a una política IAM personalizada previamente definida.

* En otros escenarios, utilizamos parámetros del template para reutilizar configuraciones dinámicas durante el despliegue.

---

#### 🔹 3. Exponer correctamente los Outputs es fundamental

Los Outputs son extremadamente importantes cuando trabajamos con múltiples stacks.

¿Por qué?

Porque permiten exponer información útil generada dinámicamente por un Stack para que posteriormente pueda ser reutilizada por otros despliegues. Veamos un ejemplo simplificado:

* 🟦 TEMPLATE — STACK 1

    ```yml
    Resources:

    NombreRecurso1ServicioAWS:
        Propiedad1Recurso:
        Propiedad2Recurso:

    Outputs:

    NombreValorExponer:
        Value: Valor que será expuesto
        Export:
        Name: NombreStack1
    ```
* 🟦 TEMPLATE — STACK 2

    ```yml
    Resources:

    NombreRecurso2ServicioAWS:
        Propiedad1Recurso:
        Propiedad2Recurso:
        Propiedad3Recurso: !ImportValue NombreStack1
    ```

* 🟦 ¿Qué hace `!ImportValue`?

`!ImportValue` permite importar valores previamente exportados desde otro Stack. Esto facilita muchísimo:

* desacoplamiento
* reutilización
* modularidad
* integración entre stacks

* ⚠️ Limitaciones importantes de `ImportValue`

Es importante tener en cuenta que `!ImportValue` posee ciertas limitaciones:

* funciona dentro de la misma cuenta AWS
* funciona dentro de la misma región
* los nombres exportados deben ser únicos

---
### 🟦 Reflexión final sobre templates unificados

Estas son recomendaciones que personalmente me hubiese gustado conocer al iniciar en Infraestructura como Código. Porque normalmente al comenzar en CloudFormation:

* Nos enfocamos únicamente en crear recursos, pero no en cómo organizarlos correctamente

Y ahí es donde realmente empieza la complejidad arquitectónica de IaC. La dificultad no está únicamente en escribir YAML, la verdadera dificultad aparece cuando debemos:

* mantener infraestructura
* reutilizar componentes
* escalar despliegues
* comprender dependencias
* desacoplar arquitectura
* evitar templates inmantenibles

**Por ello, más allá de aprender sintaxis, es importante comprender la lógica arquitectónica detrás de los templates.**

---

### 🟦 Repositorio del ejemplo completo

Puedes revisar el ejemplo completo del template unificado utilizado en este capítulo en:

🔗 GitHub: [Template-Unificado-Rol-Politica-IAM](https://github.com/BrayanR03/Proyecto-IAC-Replicacion-MultiRegion-S3-AWS/blob/main/code/capitulo-4/template-rol-politica-iam.yml)