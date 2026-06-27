## 🌐 IaC + Networking en AWS

Pues bien, después de haber revisado algunos de los servicios fundamentales de AWS, como **IAM**, **Amazon S3** y **AWS Lambda**, es momento de adentrarnos en uno de los pilares más importantes de cualquier arquitectura cloud: **Amazon VPC**.

Sin embargo, aprender Networking en AWS no consiste únicamente en crear una VPC y comenzar a desplegar recursos sobre ella. Detrás de una red existen múltiples componentes que trabajan conjuntamente para controlar la conectividad, el enrutamiento, la seguridad y el acceso a los recursos desplegados en la nube.

Y precisamente esa será la finalidad de esta nueva etapa del proyecto: comprender cómo definir toda esa infraestructura de red utilizando **Infraestructura como Código (IaC)** mediante **AWS CloudFormation**.

---

### 🏗️ Los principales componentes del Networking en AWS

A lo largo de esta sección iremos desarrollando los principales componentes de Networking que normalmente encontramos en una arquitectura sobre AWS.

Entre ellos se encuentran:

- 🌐 Virtual Private Cloud (VPC)
- 🏠 Subnets
- 🌍 Internet Gateway
- 🔄 NAT Gateway
- 🛣️ Route Tables
- 🛡️ Network Access Control Lists (NACLs)
- 🔐 Security Groups

Estos componentes constituyen la base sobre la cual posteriormente desplegaremos otros servicios de AWS.

Cada uno cumple una responsabilidad distinta dentro de la red y comprender cómo interactúan entre sí será fundamental para diseñar arquitecturas seguras, escalables y correctamente segmentadas.

> **Nota:** AWS dispone de muchos otros servicios relacionados con Networking, como Transit Gateway, VPC Peering, Direct Connect o VPN. Sin embargo, para este proyecto nos centraremos en los componentes fundamentales que todo profesional que trabaje con AWS debería comprender.

---

### 💻 Networking desde la perspectiva de IaC

Uno de los aspectos más interesantes de Infraestructura como Código es que los conceptos de Networking no cambian.

* Una VPC sigue siendo una VPC.
* Una Subnet sigue siendo una Subnet.
* Un Security Group sigue siendo un Security Group.
* Lo que cambia es la forma en la que definimos toda esa infraestructura.

Mientras que desde la consola de AWS configuramos estos componentes mediante una interfaz gráfica, con CloudFormation los describimos mediante código dentro de un template, permitiendo automatizar completamente su creación, modificación y eliminación.

Esto no solo facilita la reproducibilidad de la infraestructura, sino que también permite versionarla, reutilizarla y mantenerla bajo las mismas prácticas que cualquier proyecto de desarrollo de software.

---

### 🧩 ¿Debemos desplegar cada componente por separado o unificar todo?

Esta es una pregunta que suele surgir cuando comenzamos a trabajar con IaC.

La respuesta es:

> **Depende del nivel de control, reutilización y organización que necesitemos dentro del proyecto.**

Durante el proceso de aprendizaje resulta muy útil construir un Stack independiente para cada componente de Networking.

Por ejemplo:

- un Stack para la VPC
- un Stack para las Subnets
- un Stack para las Route Tables
- un Stack para los Security Groups

Este enfoque permite comprender de manera aislada cómo funciona cada recurso, cuáles son sus propiedades y cómo se relaciona con los demás componentes.

Posteriormente, cuando ya entendamos el funcionamiento individual de cada uno de ellos, podremos evaluar cuándo resulta conveniente agrupar varios recursos relacionados dentro de un mismo Stack para simplificar el despliegue y la administración de la infraestructura.

En otras palabras:

**Primero comprenderemos cada pieza de la arquitectura por separado.**

**Después aprenderemos a integrarlas dentro de una solución completa.**

---

### 🚀 Lo que veremos en esta nueva sección

En los próximos capítulos construiremos progresivamente la infraestructura de red necesaria para nuestros proyectos utilizando AWS CloudFormation.

Cada capítulo estará dedicado a uno de los componentes principales del Networking en AWS, analizando:

- su propósito dentro de la arquitectura
- cómo funciona en AWS
- cómo definirlo mediante CloudFormation
- buenas prácticas de diseño
- recomendaciones al trabajar con Infraestructura como Código

Al finalizar esta sección, no solo comprenderemos cómo funciona el Networking en AWS, sino también cómo automatizar completamente su despliegue utilizando IaC.

Comencemos, entonces, a descubrir cómo Infraestructura como Código transforma la manera en que diseñamos y administramos redes dentro de AWS.