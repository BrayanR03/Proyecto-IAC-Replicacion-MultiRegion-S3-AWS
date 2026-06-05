## ⚡ TEMPLATE LAMBDA — CUANDO IAC NOS OBLIGA A PENSAR EN DEPENDENCIAS

Pues bien, ya tenemos construidas las bases de IAM para nuestro proyecto.

Ahora llega el momento de pasar a los componentes que realmente ejecutarán la lógica del flujo:

* AWS Lambda
* Amazon S3

Y aquí aparecen preguntas interesantes:

`¿Qué deberíamos crear primero mediante IaC?`

`¿La Lambda Function o los buckets de S3?`

A simple vista parecen preguntas sencillas.

Sin embargo, cuando comenzamos a trabajar con Infrastructure as Code, descubrimos que detrás de esta decisión existen dependencias entre servicios que normalmente pasan desapercibidas cuando utilizamos la consola de AWS.

---

### 🖥️ ¿CÓMO SE CONSTRUYE DESDE LA CONSOLA?

Si observamos el proyecto desde la perspectiva de la consola de administración, normalmente el flujo sería el siguiente:

#### Paso A

Crear los buckets de S3.

* Bucket origen.
* Bucket destino.

---

#### Paso B

Crear la Lambda Function.

Durante este proceso AWS realiza automáticamente varias tareas:

* Crea los permisos para CloudWatch Logs.
* Crea un rol IAM.
* Asocia dicho rol a la función Lambda.

Todo esto ocurre detrás de la interfaz gráfica.

---

#### Paso C

Configurar el trigger que activará la Lambda.

Recordemos que una Lambda normalmente posee tres componentes principales:

```yml
Trigger
    ↓
Lambda Function
    ↓
Destino (Opcional)
```

En nuestro caso:

```yml
Evento S3
    ↓
Lambda Function
    ↓
Bucket Destino
```

Para configurar este trigger desde la consola debemos indicar:

* Qué servicio activará la Lambda.
* Qué bucket utilizará el evento.
* Qué acciones activarán la ejecución.
* Prefijos opcionales.
* Sufijos opcionales.
* Confirmar que el bucket de destino no genere ejecuciones recursivas.

Y aquí aparece una primera dependencia importante:

Si los buckets aún no existen, no podremos seleccionarlos como origen del trigger.

---

#### Paso D

Crear una política adicional para permitir que Lambda acceda a los buckets S3.

Posteriormente debemos asociarla al rol generado automáticamente por AWS.

Y es aquí donde comienzan a aparecer algunos problemas:

* Dependemos de recursos creados automáticamente.
* Debemos localizar el rol correcto.
* Podemos asociar permisos al rol equivocado.
* Parte de la arquitectura queda oculta detrás de la UI.

---

### 🧩 LA PERSPECTIVA DE IAC

Cuando trasladamos el proyecto a Infrastructure as Code, la situación cambia completamente.

En lugar de construir todo de manera visual, comenzamos a dividir la arquitectura en componentes independientes.

Cada servicio pasa a tener una responsabilidad claramente definida.

Y cada template representa una pieza específica del proyecto.

Por ello, después de finalizar el template de IAM, el siguiente paso es construir:

[`template-lambda.yml`](#)

---

### 🚀 MÁS DE UN RECURSO: LA LAMBDA NO ES SOLO LA LAMBDA

Una de las primeras sorpresas al revisar CloudFormation es descubrir que la Lambda no está representada por un único recurso.

En este template realmente definimos dos componentes distintos.

---

#### 🔹 Recurso N.º 1 — Lambda Function

Este recurso representa la función propiamente dicha.

Aquí definimos aspectos como:

* Runtime.
* Arquitectura.
* Handler.
* Timeout.
* Memoria.
* Rol IAM.
* Ubicación del código fuente.

Es decir, toda la configuración necesaria para ejecutar la lógica del proyecto.

---

#### 🔹 El Código Fuente No Vive Dentro Del Template

Otro detalle importante es que el código de la Lambda no debe almacenarse directamente dentro del template.

Aunque técnicamente existen mecanismos para incorporar código embebido, esta práctica deja de ser sostenible rápidamente cuando los proyectos comienzan a crecer.

Por ello, una estrategia mucho más adecuada consiste en disponer de un bucket dedicado para almacenar artefactos de despliegue.

Por ejemplo:

```yml
Bucket de Artefactos
        ↓
lambda-move-object.zip
        ↓
CloudFormation
        ↓
Lambda Function
```

De esta manera:

* El template mantiene únicamente la infraestructura.
* El código se administra de forma independiente.
* Podemos reutilizar el mismo bucket para futuras Lambdas.
* El despliegue resulta mucho más mantenible.

Y nuevamente aparece una de las ventajas de IaC:

No solo pensamos en recursos.

Pensamos también en cómo gestionar correctamente el ciclo de vida del código.

---

#### 🔹 Recurso N.º 2 — Permiso Del Trigger

El segundo recurso suele pasar desapercibido cuando trabajamos desde la consola.

El trigger que configuramos visualmente también debe representarse mediante infraestructura.

Y para ello CloudFormation necesita definir explícitamente el permiso que permitirá a S3 invocar la Lambda.

En otras palabras:

```yml
S3
 ↓
Permiso de Invocación
 ↓
Lambda
```

Lo que en la consola parece una simple casilla de configuración, en realidad se convierte en un recurso independiente dentro de IaC.

---

### ⚠️ ¿Y QUÉ PASA SI LOS BUCKETS TODAVÍA NO EXISTEN?

Aquí aparece una situación bastante interesante.

Nuestro trigger necesita referenciar buckets S3.

Pero esos buckets aún no han sido creados.

Si intentamos validar completamente la integración en este punto, observaremos errores relacionados con recursos inexistentes.

Sin embargo, esto no significa que la arquitectura esté mal diseñada.

Simplemente estamos construyendo el proyecto por capas.

Primero:

```yml
IAM
 ↓
Lambda
```

Y posteriormente:

```yml
S3
 ↓
Eventos
 ↓
Integración completa
```

Una vez que los buckets sean desplegados, las referencias quedarán resueltas y el flujo terminará de completarse correctamente.

---

### 🎯 LO QUE REALMENTE APRENDEMOS AQUÍ

Más allá de crear una Lambda Function, este template nos enseña algo mucho más importante.

Nos muestra que muchos elementos que parecen simples configuraciones dentro de la consola son, en realidad, recursos independientes que forman parte de la arquitectura.

Lo que desde la UI parece:

```yml
Agregar Trigger
```

En Infrastructure as Code se traduce en:

```yml
Definir permisos
↓
Crear recursos
↓
Gestionar dependencias
↓
Establecer relaciones entre servicios
```

Y es precisamente en este punto donde comenzamos a comprender cómo AWS construye realmente sus servicios detrás de la interfaz gráfica.
