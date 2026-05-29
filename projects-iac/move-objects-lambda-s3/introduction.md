## 🟦 EVENTOS EN S3 — UN PROYECTO DE CONSOLIDACIÓN EN IAC

Pues bien… este proyecto nace a partir de una idea que inicialmente compartí en LinkedIn sobre los eventos en Amazon S3 y cómo estos pueden integrarse con arquitecturas serverless para automatizar procesos en AWS ⚡

Uno de los principales objetivos de este proyecto no fue únicamente comprender cómo funcionan los eventos en S3, sino también llevar toda esa configuración visual desde la consola de AWS hacia un enfoque completamente basado en Infrastructure as Code (IaC).

---

### ☁️ ¿POR QUÉ LOS EVENTOS EN S3 SON TAN IMPORTANTES?

Cuando muchas personas comienzan con Amazon S3, suelen verlo únicamente como un servicio de almacenamiento.

Pero en realidad, S3 puede actuar como un servicio orientado a eventos.

Cada vez que ocurre una acción sobre un objeto —como una subida, eliminación o restauración— S3 puede generar eventos que se integran con otros servicios AWS como:

* AWS Lambda
* Amazon SNS
* Amazon SQS
* Amazon EventBridge

Y aquí es donde comienzan a aparecer arquitecturas mucho más desacopladas, automáticas y orientadas a eventos.

---

### 🚀 OBJETIVO DEL PROYECTO

Para este proyecto decidí trabajar con una integración entre:

* Amazon S3
* AWS Lambda
* IAM

El objetivo es simple, pero extremadamente útil para entender arquitecturas event-driven:

📌 Cada vez que se suba un archivo a un bucket de origen, automáticamente se ejecutará una Lambda Function encargada de copiar el archivo hacia un bucket destino.

---

### 🧩 ARQUITECTURA DEL PROYECTO

La arquitectura implementada se compone de:

✔️ Un bucket de origen
✔️ Un bucket de destino
✔️ Una Lambda Function
✔️ Un rol IAM con permisos sobre ambos buckets
✔️ Eventos configurados desde S3 hacia Lambda

---

### ⚙️ FLUJO DEL PROYECTO

El flujo implementado funciona de la siguiente manera:

1. Un archivo es cargado al bucket de origen.
2. El evento `PUT` en S3 detecta la carga del archivo.
3. S3 ejecuta automáticamente la Lambda Function.
4. La función Lambda utiliza `boto3` para copiar el archivo hacia el bucket destino.
5. Opcionalmente, el archivo puede eliminarse del bucket origen para simular un movimiento completo.

---

###  🧠 DE LA CONSOLA AWS HACIA IAC

Uno de los enfoques principales de este proyecto fue abstraer toda la configuración visual de AWS hacia Infrastructure as Code.

Porque algo importante que muchas veces ocurre al aprender AWS es esto:

```text
Creamos recursos desde la consola…
Pero no comprendemos realmente cómo se relacionan internamente.
```

Por ello, antes de construir los templates, primero analicé:

* Relaciones entre servicios
* Dependencias
* Policies IAM necesarias
* Permisos para triggers
* Integraciones entre S3 y Lambda
* Recursos que AWS crea implícitamente
* Configuraciones obligatorias

Una vez comprendida toda la arquitectura, comenzó la transición hacia CloudFormation.

---

### 📘 ORGANIZACIÓN DE LOS TEMPLATES

Para este proyecto decidí utilizar una estructura unificada por servicio, algo que ya había recomendado anteriormente cuando se pasa de templates individuales hacia proyectos más organizados y mantenibles.

La estructura quedó organizada de la siguiente manera:

#### 🔹 IAM

Archivo:
`template-iam.yml`

Encargado de:

* Roles
* Policies
* Permisos necesarios para Lambda y S3

---

#### 🔹 AWS Lambda

Archivo:
`template-lambda.yml`

Encargado de:

* Definición de la Lambda Function
* Runtime
* Variables necesarias
* Configuración de ejecución
* Asociación con el rol IAM

---

#### 🔹 Amazon S3

Archivo:
`template-s3.yml`

Encargado de:

* Bucket origen
* Bucket destino
* Configuración de eventos
* Notificaciones hacia Lambda

---

### 🔥 MÁS QUE MOVER ARCHIVOS…

Aunque el proyecto parece simple visualmente, realmente introduce conceptos extremadamente importantes dentro de AWS:

* Arquitecturas serverless
* Event-driven architectures
* Automatización basada en eventos
* Integraciones desacopladas
* Permisos IAM entre servicios
* Infraestructura reproducible mediante IaC

Al final, no solo movemos archivos…

Estamos construyendo sistemas que reaccionan automáticamente a eventos en tiempo real ⚙️

---

