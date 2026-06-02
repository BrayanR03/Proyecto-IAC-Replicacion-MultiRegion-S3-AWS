## 🔐 TEMPLATE IAM — COMPRENDIENDO LO QUE LA CONSOLA OCULTA

Comencemos con el primer template del proyecto:

[`template-iam.yml`](https://github.com/BrayanR03/Proyecto-IAC-Replicacion-MultiRegion-S3-AWS/tree/main/projects-iac/move-objects-lambda-s3/template/template-iam.yml)

Este template tiene una responsabilidad fundamental dentro de toda la arquitectura: definir explícitamente los permisos que permitirán la interacción entre AWS Lambda, Amazon S3 y CloudWatch.

Esta parte del proyecto, el template crea:

* 2 políticas IAM personalizadas.
* 1 rol IAM.
* Las relaciones necesarias entre estos componentes.

Y es precisamente aquí donde empezamos a notar una de las mayores diferencias entre trabajar desde la consola de AWS y trabajar con Infrastructure as Code.

---

### 🧠 LO QUE LA CONSOLA HACE POR NOSOTROS

Si recuerdas el flujo mostrado inicialmente en el post de LinkedIn, el primer paso consistía en crear directamente una Lambda Function.

Visualmente parece sencillo:

```yml
Crear Lambda
↓
Cargar código
↓
Configurar trigger S3
↓
Probar funcionamiento
```

Sin embargo, internamente AWS realiza muchas acciones que normalmente no vemos.

Entre ellas:

* Crear un rol IAM.
* Crear permisos para CloudWatch Logs.
* Asociar esos permisos al rol.
* Configurar la relación de confianza necesaria para Lambda.

Todo esto ocurre automáticamente detrás de la interfaz gráfica.

Y precisamente por eso IaC resulta tan valioso: nos obliga a comprender qué recursos realmente intervienen en la arquitectura.

---

### 📋 POLÍTICA N.° 1 — CLOUDWATCH LOGS

La primera política personalizada definida en este template es:

`PoliticaPersonalizada-LambdaExecution-CloudWatchLogs`

Su objetivo es permitir que la función Lambda pueda escribir registros en CloudWatch Logs.

Gracias a esta política podremos:

* Registrar ejecuciones.
* Analizar errores.
* Verificar eventos recibidos desde S3.
* Validar si la automatización funciona correctamente.
* Realizar tareas de debugging y monitoreo.

Sin esta política, Lambda podría ejecutarse, pero no tendríamos visibilidad sobre lo que está ocurriendo internamente.

---

### 🔄 DE JSON A YAML: PENSANDO EN IAC

Aquí aparece una situación interesante.

Las políticas IAM suelen encontrarse documentadas en formato JSON.

Sin embargo, nuestros templates CloudFormation están escritos en YAML.

Por ello, una práctica útil consiste en transformar la definición JSON de la política hacia una estructura compatible con YAML para incorporarla directamente al template.

Más allá de la conversión de formato, el verdadero aprendizaje consiste en comprender qué permisos estamos otorgando y por qué son necesarios.

Eso es pensar en Infrastructure as Code desde una perspectiva arquitectónica y no simplemente copiar y pegar configuraciones.

---

### 🪣 POLÍTICA N.° 2 — ACCESO DE LAMBDA A S3

La segunda política personalizada definida en este template es:

`PoliticaPersonalizada-LambdaExecution-S3`

Esta política permitirá que la función Lambda pueda interactuar con los buckets definidos en el proyecto.

Recordemos que el flujo de negocio requiere:

```yml
Bucket Origen
↓
Evento S3
↓
Lambda
↓
Bucket Destino
```

Para que esto funcione, Lambda necesita permisos explícitos para realizar acciones sobre ambos buckets.

Por ejemplo:

* Leer objetos.
* Copiar archivos.
* Obtener información de objetos.
* Eliminar archivos (si decidimos implementar un movimiento completo).

---

### 🔒 SEGURIDAD: CONTROLANDO LOS PERMISOS DESDE EL INICIO

Cuando utilizamos la consola de AWS, normalmente dejamos que AWS cree automáticamente el rol asociado a Lambda.

Esto funciona.

Pero no necesariamente representa el mejor nivel de control.

En cambio, al trabajar con IaC podemos definir explícitamente:

* Qué permisos existen.
* Qué políticas se crean.
* Qué servicios las utilizarán.
* Qué alcance tendrá cada permiso.

De esta manera aplicamos de forma más clara el principio de mínimo privilegio.

Es decir:

> Otorgar únicamente los permisos estrictamente necesarios para realizar una tarea.

---

### 👤 CREACIÓN DEL ROL IAM

Una vez definidas ambas políticas, podemos crear el componente final de este template:

**El rol IAM.**

Este rol será asumido por AWS Lambda y tendrá asociadas las políticas creadas previamente.

En otras palabras:

```yml
Política CloudWatch Logs
          +
Política Acceso S3
          ↓
        Rol IAM
          ↓
      AWS Lambda
```

Este enfoque nos permite construir una arquitectura mucho más controlada, auditable y mantenible.

---

### ⚖️ UI VS IAC — LA DIFERENCIA REAL

Si utilizáramos únicamente la consola de AWS:

#### Desde la UI

* **Paso 1**: Crear la Lambda Function.

* **Paso 2**: 

    AWS crea automáticamente:
    
    * El rol IAM.
    
    * Los permisos para CloudWatch.
    
    * La asociación entre ambos.

* **Paso 3**
Agregar manualmente permisos adicionales para que Lambda pueda acceder a S3.

Esto implica trabajar sobre recursos que AWS nombró y configuró automáticamente.

---

#### Desde IaC

* **Paso 1**: 
    Definir las políticas necesarias.

    * CloudWatch Logs.
    * Acceso a S3.

* **Paso 2**: Crear explícitamente el rol IAM.

* **Paso 3**: Asociar las políticas al rol.

* **Paso 4**: Utilizar posteriormente ese rol en la Lambda Function.

---

### 🚀 CONCLUSIÓN

Este template demuestra perfectamente una de las principales ventajas de Infrastructure as Code.

Mientras que la consola abstrae gran parte de la complejidad, IaC nos obliga a comprender los componentes reales que hacen posible la arquitectura.

Al finalizar este template obtenemos:

✅ Políticas personalizadas.

✅ Un rol completamente controlado.

✅ Aplicación explícita del principio de mínimo privilegio.

✅ Mayor trazabilidad y gobernanza.

Y, sobre todo, una comprensión mucho más profunda de cómo AWS construye realmente sus servicios detrás de la interfaz gráfica.
