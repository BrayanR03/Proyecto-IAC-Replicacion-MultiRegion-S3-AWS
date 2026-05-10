## 📖 CAPÍTULO 4: EL DESPLIEGUE DEL TEMPLATE EN CLOUDFORMATION

Pues bien, luego de haber definido correctamente nuestro template, ahora toca utilizar como tal el servicio de AWS CloudFormation.

Sin embargo, CloudFormation posee diversas características que debemos comprender para poder utilizar adecuadamente cada una de ellas según el objetivo, alcance y facilidad de administración de nuestra infraestructura.

---

### 🟦 El componente core: el Stack

El componente principal de CloudFormation es el **Stack**, el cuál permite gestionar todo el ciclo de vida de los recursos desplegados dentro de AWS.

En este caso, si el template representa el plano de construcción y los recursos desplegados representan la casa construida, entonces el Stack sería todo el proceso encargado de construir, supervisar y administrar dicha infraestructura de inicio a fin.

Además, el Stack también será el encargado de:

- Informar errores durante el despliegue
- Gestionar actualizaciones de infraestructura
- Coordinar dependencias entre recursos
- Eliminar recursos administrados por el template
- Mantener el estado general de la infraestructura desplegada

---

### 🟦 Características importantes de los Stacks

Existen diversas características fundamentales que debemos tener en cuenta:

---

#### 🔹 1. Un Stack pertenece a una región y a una cuenta específica

Cada Stack se crea dentro de:

- una única cuenta AWS
- una única región

Por ejemplo:

- `us-east-1`
- `us-west-2`
- `sa-east-1`

Esto significa que el alcance operativo de un Stack es regional.

Sin embargo, dentro de una misma región y cuenta podemos crear múltiples Stacks independientes.

---

#### 🔹 2. CloudFormation posee un comportamiento transaccional mediante rollback

CloudFormation trabaja bajo un enfoque transaccional.

Esto significa que, si ocurre un error durante el despliegue de los recursos, el servicio intentará revertir automáticamente los cambios realizados para evitar que la infraestructura quede en un estado inconsistente.

Por ejemplo:

- si se crean correctamente algunos recursos
- pero uno posterior falla

CloudFormation ejecutará un proceso denominado **rollback**, intentando eliminar los recursos previamente creados durante esa ejecución.

Esto ayuda a mantener consistencia en la infraestructura desplegada.

---

#### 🔹 3. El Stack administra directamente los recursos definidos en el template

El Stack mantiene una relación directa con todos los recursos desplegados mediante el template.

Por defecto, si el Stack es eliminado, CloudFormation también eliminará los recursos administrados por dicho Stack.

Sin embargo, existen excepciones importantes, por ejemplo:

- políticas `DeletionPolicy: Retain`
- snapshots automáticos
- recursos importados
- buckets S3 con objetos almacenados
- configuraciones de protección específicas

Por ello, no todos los recursos necesariamente serán eliminados en todos los escenarios.

---

#### 🔹 4. Los templates pueden almacenarse en S3 dependiendo del método de despliegue

Dependiendo del tamaño del template y del mecanismo utilizado para el despliegue, CloudFormation puede utilizar Amazon S3 para almacenar temporalmente los templates.

Esto ocurre frecuentemente cuando utilizamos:

- nested stacks
- StackSets
- AWS SAM
- AWS CDK
- despliegues mediante AWS CLI
- templates grandes o empaquetados

Por ello, es común encontrar templates almacenados en buckets S3 durante distintos procesos de despliegue.

---

### 🟦 StackSets: despliegues multi-región y multi-cuenta

CloudFormation también posee el componente denominado **StackSets**.

StackSets hereda el mismo principio de funcionamiento de los Stacks tradicionales, pero elimina parte de sus limitaciones operativas.

Mientras un Stack tradicional opera únicamente:

- en una región
- y en una cuenta específica

StackSets permite desplegar infraestructura:

- en múltiples cuentas AWS
- en múltiples regiones
- utilizando un único template centralizado

Esto facilita enormemente arquitecturas empresariales y despliegues organizacionales a gran escala.

---

### 🟦 Stack Refactoring

CloudFormation también incorpora capacidades de **Stack Refactoring**.

Este componente permite reorganizar recursos existentes entre diferentes Stacks sin necesidad de recrear completamente la infraestructura.

En otras palabras, permite:

- separar responsabilidades
- dividir templates monolíticos
- reorganizar arquitectura IaC
- desacoplar recursos
- mejorar mantenibilidad

Todo ello manteniendo los recursos existentes administrados por CloudFormation.

Conceptualmente, es bastante similar a una refactorización en ingeniería de software.

---

### 🟦 IaC Generator e Infrastructure Composer

CloudFormation también incorpora herramientas modernas orientadas a acelerar la creación de infraestructura como código.

---

#### 🔹 IaC Generator

Permite generar templates de CloudFormation basándose en infraestructura previamente creada manualmente desde la consola de AWS.

Es decir, transforma infraestructura existente en definición IaC reutilizable.

---

#### 🔹 Infrastructure Composer

Infrastructure Composer es una herramienta visual que permite diseñar arquitecturas y generar templates de infraestructura como código de forma gráfica.

En lugar de escribir directamente YAML o JSON desde cero, podemos construir visualmente distintos componentes de infraestructura y luego generar el template correspondiente.

---

### 🟦 Reflexión importante sobre estas herramientas

Aunque estas herramientas aceleran muchísimo el desarrollo inicial, existe una limitación importante:

Muchas veces generan templates:

- excesivamente extensos
- difíciles de leer
- con configuraciones redundantes
- con dependencias innecesarias
- poco mantenibles

Por ello, si no comprendemos correctamente las bases de Infraestructura como Código (IaC), terminaremos invirtiendo tiempo adicional refactorizando templates generados automáticamente.

En cierta forma, es similar a programar utilizando IA sin comprender realmente los fundamentos de programación.

Las herramientas aceleran el trabajo, pero el criterio arquitectónico sigue siendo responsabilidad del ingeniero.

---

### 🟦 Enfoque utilizado en este proyecto

Sin embargo, para este proyecto utilizaremos únicamente Stacks tradicionales, debido que nuestro objetivo será desplegar progresivamente cada componente de nuestra arquitectura de replicación multirregional en S3 de manera controlada y entendiendo completamente cada recurso definido.

Veamos a continuación el despliegue de nuestra política IAM creada anteriormente.

🔗 GitHub: [Despliegue-Template-PoliticaIAM](https://github.com/BrayanR03/Proyecto-IAC-Replicacion-MultiRegion-S3-AWS/blob/main/assets/PoliticaIAM-IAC.mp4)

📝 Template desplegada: [Template-IAM](https://github.com/BrayanR03/Proyecto-IAC-Replicacion-MultiRegion-S3-AWS/blob/main/code/templates/individuales/template-politica-iam.yml)
