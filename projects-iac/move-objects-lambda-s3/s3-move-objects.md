## 🪣 TEMPLATE S3 — COMPLETANDO LA ARQUITECTURA EVENT-DRIVEN

Pues bien, ya hemos construido los cimientos de nuestro proyecto.

Hasta este punto:

* ✅ Definimos roles y políticas IAM aplicando explícitamente el principio de mínimo privilegio.

* ✅ Creamos la Lambda Function junto con los permisos necesarios para su ejecución.

* ✅ Configuramos el mecanismo que permitirá a S3 invocar la función.

Sin embargo, todavía existe una pieza pendiente. Y curiosamente, es la parte que normalmente parece más sencilla cuando trabajamos desde la consola de AWS.

Pero como ya hemos visto durante este proyecto, Infrastructure as Code tiene una forma muy particular de mostrarnos lo que realmente ocurre detrás de la interfaz gráfica.

---

### 🤔 EL PEQUEÑO ERROR QUE DEJAMOS PENDIENTE

Durante la construcción del template de Lambda apareció una situación interesante:

- *La función estaba correctamente definida.*

- *Y, sus permisos también.*

Incluso el trigger estaba preparado, pero existía un problema:

**El bucket de origen aún no había sido creado.**

Como consecuencia, la asociación completa entre S3 y Lambda no podía resolverse durante ese momento del despliegue. Y, a primera vista podría parecer un error de diseño.

Pero en realidad se trata simplemente de una dependencia aún no satisfecha dentro de la arquitectura. Y es precisamente aquí donde entra en juego nuestro último template:

[`template-s3.yml`](https://github.com/BrayanR03/Proyecto-IAC-Replicacion-MultiRegion-S3-AWS/blob/main/projects-iac/move-objects-lambda-s3/template/template-s3.yml)

---

### 🧩 EL TEMPLATE QUE CIERRA EL CICLO

Este template no solamente crea los buckets del proyecto. También define la configuración necesaria para que **Amazon S3** pueda **generar eventos y comunicarse** correctamente con otros servicios.

En nuestro caso se crean:

* Bucket origen: `origen-bucket-brayan-mover-objetos`
* Bucket destino: `destino-bucket-brayan-mover-objetos`
* Configuración de eventos sobre el bucket origen.

Y gracias a ello desaparece la dependencia pendiente que observábamos anteriormente durante la construcción de la Lambda Function.

---

### ⚡ LOS EVENTOS DE S3: MUCHO MÁS QUE ALMACENAMIENTO

Uno de los aprendizajes más importantes de este proyecto es comprender que Amazon S3 no es únicamente un servicio de almacenamiento. Sino, un servicio que puede actuar como un generador de eventos.

Cada vez que ocurre una acción sobre un objeto, S3 puede reaccionar automáticamente. Por ejemplo:

* Creación de objetos.
* Eliminación de objetos.
* Restauraciones.
* Replicaciones.
* Operaciones específicas sobre versiones.

Y esos eventos pueden desencadenar distintos destinos dentro de AWS.

Entre ellos:

```yml
Evento S3
    ↓
SNS Topic
```

```yml
Evento S3
    ↓
SQS Queue
```

```yml
Evento S3
    ↓
Lambda Function
```

Para este proyecto elegimos **Lambda** porque nos permite ejecutar lógica personalizada para mover objetos entre buckets de forma completamente automática.

---

### 🖥️ UNA DIFERENCIA IMPORTANTE ENTRE UI E IAC

Aquí aparece otra diferencia interesante entre trabajar desde la consola y trabajar mediante CloudFormation.

Cuando utilizamos la consola de AWS, normalmente configuramos la integración desde la propia Lambda Function.

Es decir:

```yml
Lambda
 ↓
Agregar Trigger
 ↓
Seleccionar Bucket
 ↓
Configurar Evento
```

Visualmente resulta sencillo y bastante intuitivo. Sin embargo, **Infrastructure as Code** nos obliga a observar la relación desde ambos lados.

---

### 🔄 LA INTEGRACIÓN SE CONSTRUYE EN DOS DIRECCIONES

Desde IaC no basta únicamente con decirle a Lambda que será invocada por S3. Sino también, debemos indicarle a S3 qué evento debe generar y cuál será su destino. Por ello encontramos configuraciones distribuidas entre ambos templates en: [`template-lambda.yml`](https://github.com/BrayanR03/Proyecto-IAC-Replicacion-MultiRegion-S3-AWS/blob/main/projects-iac/move-objects-lambda-s3/template/template-lambda.yml)

Definimos:

* La Lambda Function.
* Los permisos de invocación.
* La relación de confianza necesaria.


Y en: [`template-s3.yml`](https://github.com/BrayanR03/Proyecto-IAC-Replicacion-MultiRegion-S3-AWS/blob/main/projects-iac/move-objects-lambda-s3/template/template-s3.yml)

Definimos:

* Los buckets.
* Los eventos del bucket origen.
* La notificación que apunta hacia Lambda.

---

### 🎯 ¿POR QUÉ DEJAR EL ERROR EN LAMBDA Y NO EN S3?

Durante el diseño del proyecto tomé una decisión intencional:

`Permitir que la dependencia pendiente apareciera inicialmente en la definición de Lambda.`

¿La razón?

* Porque si intentáramos crear la configuración completa del bucket apuntando hacia una Lambda inexistente, estaríamos introduciendo una dependencia crítica directamente sobre el recurso S3.

En cambio, al construir primero:

```yml
IAM
 ↓
Lambda
 ↓
S3
```

La arquitectura evoluciona de forma más natural:

* Primero existen los permisos.

* Después existe la función que procesará los eventos.

* Y finalmente aparece el servicio que generará dichos eventos.

De esta forma las dependencias quedan mucho más claras y fáciles de comprender.

---

### 🏗️ EL RESULTADO FINAL

Una vez desplegados los tres templates obtenemos la arquitectura completa:

```yml
Bucket Origen
      ↓
Evento PUT (.csv)
      ↓
AWS Lambda
      ↓
Bucket Destino
```

Y todo ello construido mediante:

* IAM personalizado.
* Políticas explícitas.
* Roles controlados.
* Eventos definidos como código.
* Recursos versionables y reproducibles.

---

### 🚀 DESPLIEGUE DEL PROYECTO

Una vez construidos los tres templates del proyecto, el siguiente paso consiste en desplegar la infraestructura en AWS. Para ello continuamos utilizando `AWS CLI` como mecanismo de despliegue desde nuestro entorno local hacia la nube.

Este enfoque nos permite mantener un flujo completamente alineado con los principios de Infrastructure as Code, evitando configuraciones manuales desde la consola y garantizando que toda la infraestructura pueda ser reproducida de manera consistente.

Además, para simplificar el proceso operativo del proyecto, el despliegue de todos los recursos fue automatizado mediante un único script: [`deployment-project.sh`](https://github.com/BrayanR03/Proyecto-IAC-Replicacion-MultiRegion-S3-AWS/blob/main/projects-iac/move-objects-lambda-s3/template/deployment-project.sh). De esta manera, en lugar de ejecutar manualmente cada template por separado, el script se encarga de desplegar secuencialmente:

```yml
template-iam.yml
        ↓
template-lambda.yml
        ↓
template-s3.yml
```

Siguiendo el mismo orden lógico utilizado durante el diseño de la arquitectura. Esto garantiza que las dependencias entre recursos se resuelvan correctamente durante la creación de la infraestructura.

Al finalizar la ejecución del script obtenemos un despliegue completo del proyecto, incluyendo:

* Políticas IAM personalizadas.
* Rol IAM.
* Lambda Function.
* Buckets S3.
* Configuración de eventos.
* Integración completa entre S3 y Lambda.

Y lo más importante: **Toda la arquitectura puede reconstruirse nuevamente en cuestión de minutos utilizando únicamente código y un comando de despliegue.**

---

### 🚀 MÁS ALLÁ DEL PROYECTO

Aunque el objetivo funcional de este laboratorio consiste en mover archivos entre buckets, el verdadero aprendizaje está en comprender cómo interactúan los servicios internamente.

Este proyecto nos permitió descubrir:

* Cómo funcionan los eventos en S3.
* Cómo Lambda recibe permisos para ejecutarse.
* Cómo se construyen las relaciones entre servicios.
* Cómo resolver dependencias entre recursos.
* Cómo trasladar una configuración visual hacia Infrastructure as Code.

Y precisamente ese es el objetivo de esta serie. Y, no se trata únicamente de desplegar recursos.

Se trata de comprender qué ocurre detrás de cada servicio y cómo modelarlo correctamente mediante código.

---

### 🔥 SIGUIENTE DESTINO: NETWORKING

Con este segundo proyecto cerramos una nueva etapa dentro de la serie de Infrastructure as Code.

Hemos pasado por:

* IAM
* Lambda
* S3
* Eventos
* Arquitecturas serverless

Y en los próximos proyectos comenzaremos a explorar uno de los pilares fundamentales de cualquier arquitectura en AWS:

**Networking.**

Porque si los servicios representan los componentes de una arquitectura, la red es el tejido que permite que todos ellos se comuniquen correctamente.
