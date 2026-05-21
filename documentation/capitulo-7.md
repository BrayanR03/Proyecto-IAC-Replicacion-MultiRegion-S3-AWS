## 📖 CAPÍTULO 7: DESPLIEGUE FINAL DEL PROYECTO IAC EN AWS

Pues bien, llegamos al capítulo final de este proyecto de Infraestructura como Código (IaC) en AWS.

A lo largo de cada capítulo, hemos ido construyendo progresivamente conocimientos fundamentales sobre:

- CloudFormation
- diseño de templates
- organización de stacks
- dependencias entre recursos
- despliegues multi-región
- automatización de infraestructura

Y sinceramente, este proyecto me permitió comprender muchísimo más a profundidad cómo funciona realmente IaC más allá de simplemente escribir YAML.

---

### 🟦 Antes del despliegue final...

Previo al despliegue de nuestros recursos en CloudFormation, aplicaremos la estrategia que mencionamos en capítulos anteriores:

> unificar templates basándonos en el objetivo del proyecto y la relación entre los recursos.

En este caso, los templates individuales relacionados con:

- políticas IAM
- roles IAM

serán unificados en un único template orientado a toda la lógica de permisos necesaria para el proyecto.

Esto nos permite:

- reducir fragmentación innecesaria
- simplificar despliegues
- centralizar configuraciones
- mantener relaciones lógicas entre recursos

Acceder al template IAM unificado: ➡️ [Templates-IAM-Replicacion-MultiRegional](https://github.com/BrayanR03/Proyecto-IAC-Replicacion-MultiRegion-S3-AWS/blob/main/code/templates/unificados/template-iam.yml)


---

### 🟦 La parte más importante del proyecto: la replicación multi-regional

Por otro lado, como estamos trabajando con una arquitectura de replicación multi-regional en Amazon S3, necesitaremos desplegar buckets en distintas regiones.

En este caso, definimos:

- un template para el bucket origen
- un template para el bucket destino

Sin embargo, aunque ambos pertenecen al servicio S3, cada Stack será desplegado en una región distinta.

Por ejemplo:

- bucket origen → `us-east-2`
- bucket destino → `us-east-1`

Y aquí aparece uno de los conceptos más importantes de CloudFormation:

> Cada Stack individual opera dentro de una única región y una única cuenta AWS.

Acceder a los templates de cada bucket: ➡️ [Templates-Buckets-S3-Replicacion-MultiRegional](https://github.com/BrayanR03/Proyecto-IAC-Replicacion-MultiRegion-S3-AWS/blob/main/code/capitulo-6/)


---

### 🟦 Automatizando el despliegue de infraestructura

Ahora bien…

Existen muchas maneras modernas de automatizar despliegues de infraestructura, por ejemplo:

- GitHub Actions
- pipelines CI/CD
- StackSets
- herramientas DevOps
- automatizaciones empresariales

Sin embargo, para este proyecto utilizaremos inicialmente un enfoque mucho más simple y pedagógico:

> automatización de despliegues mediante scripts ejecutados desde nuestra máquina local utilizando AWS CLI.

Configuración previa `AWS CLI`: [Configuracion-AWS-CLI](https://github.com/BrayanR03/Proyecto-IAC-Replicacion-MultiRegion-S3-AWS/blob/main/code/capitulo-7/configuracion-aws-cli.md)


Y sinceramente…

Este suele ser uno de los primeros acercamientos reales que muchos tenemos hacia automatización de infraestructura en AWS.

---

### 🟦 ¿Qué hará nuestro script?

El script será el encargado de desplegar progresivamente:

- el template unificado de IAM
- el Stack del bucket origen
- el Stack del bucket destino

Cada despliegue será ejecutado utilizando la región correspondiente mediante AWS CLI.

Esto nos permitirá comprender claramente:

- cómo desplegar infraestructura desde código
- cómo automatizar CloudFormation
- cómo trabajar con múltiples regiones
- cómo coordinar despliegues entre stacks

Acceder al script 💻: [Script-Despliegue-Replicacion-MultiRegional](https://github.com/BrayanR03/Proyecto-IAC-Replicacion-MultiRegion-S3-AWS/blob/main/code/capitulo-7/deployment.sh)


---

### 🟦 Más allá del YAML

Y aquí quiero comentar algo importante…

Muchas veces cuando iniciamos en IaC pensamos que todo se trata únicamente de aprender sintaxis YAML o JSON.

Pero realmente:

> la dificultad no está únicamente en escribir templates.

La verdadera complejidad aparece cuando debemos:

- organizar infraestructura
- modularizar templates
- comprender dependencias
- automatizar despliegues
- trabajar con múltiples regiones
- mantener infraestructura escalable

Y sinceramente, este proyecto fue justamente el primer acercamiento práctico a todos esos conceptos.

---

### 🟦 No hay que tenerle miedo a IaC

Algo que sí quiero transmitirles es esto:

> no hay que tenerle miedo a Infraestructura como Código.

Aunque inicialmente parezca complejo, realmente gran parte del aprendizaje consiste en comprender:

- cómo funcionan los servicios AWS
- cómo se relacionan entre sí
- cómo traducir arquitectura a código

Además, AWS brinda muchísima documentación oficial, ejemplos y estructuras que pueden servirnos como punto de partida para construir nuestras propias soluciones.

---

### 🟦 Esto recién empieza...

Y ojo…

Este no será el último proyecto de IaC.

Será únicamente uno de muchos proyectos futuros donde seguiremos integrando:

- más servicios AWS
- automatización
- observabilidad
- arquitectura cloud
- data engineering
- cloud engineering

Porque mientras más avanzamos en cloud, más entendemos que IaC termina convirtiéndose prácticamente en una habilidad obligatoria dentro de entornos modernos.

---

### 🟦 Repositorio completo del proyecto

Todo el detalle técnico, templates, scripts y despliegues están documentados completamente dentro de este repositorio.

Aquí encontrarán:

- templates utilizados
- script de despliegue
- configuración multi-región
- automatización
- documentación técnica completa



---

### 🟦 Próximo paso

Con esto, finalizamos la construcción y despliegue de este proyecto de replicación multi-regional utilizando CloudFormation.

A partir de aquí, el siguiente paso será continuar evolucionando la automatización y comenzar a integrar arquitecturas mucho más complejas dentro del ecosistema AWS.

Sigamos avanzando en Data y Cloud Engineering 🚀