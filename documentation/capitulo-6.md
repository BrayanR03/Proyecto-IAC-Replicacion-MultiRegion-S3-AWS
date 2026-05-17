# 📖 CAPÍTULO 6: LA IMPORTANCIA DEL OBJETIVO DE UN PROYECTO EN IAC Y SU DESPLIEGUE EN MÚLTIPLES REGIONES

Pues bien, en este capítulo abarcaremos la construcción del core principal de este proyecto: la replicación multi-regional en Amazon S3.

Y sí…

Para quienes aún no comprenden completamente este concepto, lo resumiré de una forma sencilla:

---

## 🟦 ¿Por qué replicar información entre regiones?

Alguna vez se han preguntado:

> ¿Cómo puedo replicar automáticamente mi información almacenada en S3 sin necesidad de subir archivo por archivo manualmente a múltiples regiones?

Pues bien, Amazon S3 brinda justamente esa posibilidad mediante mecanismos de replicación entre buckets.

Esto permite que la información almacenada en un bucket principal pueda replicarse automáticamente hacia otros buckets ubicados en diferentes regiones de AWS.

Y aquí es donde aparece uno de los conceptos más importantes dentro de arquitectura cloud:

- resiliencia
- recuperación ante desastres
- redundancia geográfica
- continuidad operativa

---

## 🟦 El verdadero valor de una arquitectura multi-región

Uno de los escenarios donde una arquitectura multi-región cobra muchísimo valor ocurre durante incidentes regionales o eventos de disaster recovery.

Recordemos que en 2025, incidentes importantes en regiones críticas de AWS, como:

- `us-east-1`

han llegado a afectar múltiples plataformas y servicios ampliamente utilizados en internet.

Ahora imaginemos el siguiente escenario:

- nuestros backups
- nuestros archivos críticos
- nuestros datos empresariales

dependen únicamente de una sola región.

Si dicha región presenta problemas operativos importantes, nuestra capacidad de recuperación puede verse seriamente afectada.

Por ello, una arquitectura multi-región correctamente diseñada puede aumentar significativamente:

- la resiliencia
- la tolerancia a fallos
- la disponibilidad operativa

al distribuir los datos entre múltiples regiones independientes.

---

## 🟦 Amazon S3 y la replicación multi-regional

Amazon S3 posee capacidades nativas para realizar replicación entre regiones mediante funcionalidades como:

- Cross-Region Replication (CRR)
- Same-Region Replication (SRR)

Gracias a ello, S3 permite automatizar gran parte del proceso de replicación sin necesidad de construir mecanismos complejos personalizados desde cero.

Sin embargo, es importante entender algo:

**La replicación no funciona únicamente "activando una opción".**

Internamente, AWS requiere varios componentes importantes:

- versioning habilitado
- permisos entre buckets
- reglas de replicación
- roles IAM específicos
- políticas adecuadas

Y justamente este proyecto tiene muchísimo valor porque nos permite comprender cómo toda esa arquitectura puede desplegarse utilizando Infraestructura como Código.

---

## 🟦 El verdadero objetivo de este proyecto de IaC

El objetivo de este proyecto no es únicamente crear buckets S3.

El verdadero objetivo es comprender:

- cómo desplegar recursos en distintas regiones
- cómo automatizar infraestructura distribuida
- cómo gestionar dependencias multi-región
- cómo organizar despliegues regionales
- cómo diseñar arquitecturas resilientes mediante IaC

Y aquí aparece una pregunta muy importante:

> ¿Cómo desplegamos múltiples recursos en diferentes regiones utilizando CloudFormation?

---

## 🟦 ¿Cómo desplegar recursos en múltiples regiones?

Existen múltiples formas de realizar despliegues multi-región en AWS, por ejemplo:

- pipelines CI/CD
- StackSets
- automatizaciones
- scripts de orquestación
- herramientas DevOps

Sin embargo, para este proyecto utilizaremos inicialmente un enfoque más simple y pedagógico:

> automatizar despliegues regionales mediante scripts de ejecución.

Esto permitirá comprender primero el comportamiento regional de CloudFormation antes de introducir mecanismos más avanzados de automatización.

Más adelante profundizaremos esta automatización en capítulos posteriores.

---

## 🟦 ¿Por qué utilizamos dos templates distintos?

Aquí aparece una pregunta bastante interesante:

> ¿Por qué utilizar dos templates distintos si ambos recursos pertenecen al servicio S3?

La respuesta está directamente relacionada con el comportamiento regional de CloudFormation.

---

## 🟦 El comportamiento regional de CloudFormation

Cada Stack individual de CloudFormation opera dentro de:

- una única cuenta AWS
- una única región

Por ejemplo:

- un Stack desplegado en `us-east-1`
- no despliega automáticamente recursos en `us-west-2`

Y aquí es donde muchas veces aparecen confusiones cuando recién comenzamos con IaC.

El template puede reutilizarse múltiples veces.

Sin embargo:

> el despliegue del Stack siempre ocurre sobre una región específica.

Por ello, para este proyecto:

- desplegaremos un Stack para el bucket origen
- desplegaremos otro Stack para el bucket destino
- cada uno dentro de su región correspondiente

---

## 🟦 Sobre las regiones y los templates

Es importante aclarar algo muy importante:

Los templates sí pueden contener:

- parámetros
- mappings
- condiciones
- pseudo parámetros regionales

Sin embargo, el template por sí solo no controla automáticamente despliegues multi-región.

La región final depende de:

- dónde desplegamos el Stack
- automatizaciones utilizadas
- StackSets
- pipelines CI/CD
- scripts de despliegue

---

## 🟦 Enfoque utilizado en este proyecto

Para este capítulo, utilizaremos inicialmente el enfoque más simple:

1. Cambiar manualmente de región en AWS
2. Desplegar el Stack correspondiente
3. Repetir el proceso en otra región

Esto nos permitirá comprender claramente cómo CloudFormation administra recursos regionales antes de automatizar completamente el proceso.

Posteriormente automatizaremos estos despliegues multi-región utilizando scripts y mecanismos más avanzados.

---

## 🟦 Templates utilizados en este capítulo

Aquí encontrarás los templates correspondientes a los buckets origen y destino utilizados para la replicación multi-regional:


🔗 GitHub: [Templates-Buckets-S3-Replicacion-MultiRegional](https://github.com/BrayanR03/Proyecto-IAC-Replicacion-MultiRegion-S3-AWS/blob/main/code/capitulo-6/)

---

## 🟦 Próximo paso del proyecto

Con esto, terminamos ya de construir los templates necesarios para nuestra arquitectura de replicación multi-regional.

A continuación, pasaremos a automatizar el despliegue de cada Stack para comenzar a trabajar con infraestructura distribuida de manera más eficiente.