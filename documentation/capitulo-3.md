# 📖 Capítulo 3: Escribiendo el Primer Template (IAM Policy)

En este capítulo, vamos a dar el siguiente paso:

👉 **Escribir nuestro primer template real**

Trabajaremos con un componente del servicio de **IAM**, específicamente
para el desarrollo del proyecto:

🔥 **Una política (IAM Policy)**

---

## 🧱 Estructura de un Template

Para definir un template, debemos conocer que existen:

- Secciones opcionales
- Secciones obligatorias

---

## 🧾 Secciones opcionales (pero recomendadas ✅)

Estas secciones no son obligatorias, pero ayudan muchísimo a documentar.

```yaml
AWSTemplateFormatVersion: '2010-09-09'
Description: Descripción del template
Metadata:
  Author: Tu nombre
  Proyecto: Nombre del proyecto
```

## 📌 ¿Por qué usarlas?

Porque te permiten:

* Documentar el propósito del template
* Saber quién lo creó
* Relacionarlo con un proyecto

👉 Recomendación: úsalas siempre

---

## ⚙️ Secciones obligatorias (las importantes)

Ahora sí, lo que realmente hace funcionar el template.

En este proyecto trabajaremos con 3 secciones clave:

* Parameters
* Resources
* Outputs
---
### 🔹 1. Parameters

Aquí definimos valores dinámicos.
```yml
Parameters:
  NombreParametroParameter:
    Type: String | Number | List | Mayormente se utiliza String
    Description: Descripción del parámetro
    Default: Valor por defecto del parámetro
```
#### 💡 Buenas prácticas
* Usar sufijo Parameter
* Definir siempre Description
* Usar Default para el despliegue automatizado de los templates

Puedes revisar la siguiente imagen: [Parametros (Template y CloudFormation)](https://github.com/BrayanR03/Proyecto-IAC-Replicacion-MultiRegion-S3-AWS/tree/main/assets/Parametros-TemplateCloudFormation.png)

---
#### 🧠 ¿Qué hace esto?

Cuando cargas el template en CloudFormation:

👉 Se genera un input donde puedes modificar ese valor

Esto es clave para reutilizar templates.

---

### 🔹 2. Resources (el corazón del template)

Aquí definimos los recursos de AWS.
```yaml
Resources:
  NombreRecursoServicioAWS:
    Propiedad1Recurso:
    Propiedad2Recurso:
    ....
```
---
#### 📌 Importante
* No necesitas memorizar esto
* AWS ya te da plantillas base

* 👉 Solo debes buscar "aws <recurso_servicio> cloudformation" en tu navegador preferido y luego:

    * Copiar
    * Adaptar
    * Simplificar
---

### 🔹 3. Outputs

Permiten exponer valores del template.
```yml
Outputs:
  NombreValorExponer:
    Value: Valor que será expuesto en el outputs
    Export:
      Name: Nombre de "variable" que expondrá el valor anterior
```
---
#### 🧠 ¿Para qué sirven?
* Compartir datos entre templates
* Obtener valores como:
    * ARN
    * Nombre del recurso
    * IDs

👉 Esto será clave más adelante.

---

## 🧠 Idea clave de este capítulo

* No necesitas saber todo de memoria
necesitas saber cómo leer la documentación y adaptarla

## 🧪 Recomendación

Practica creando templates simples:

* IAM Policy
* IAM Role
* S3 Bucket

👉 Esto te dará soltura con la sintaxis.

---
## 💻 Template del Proyecto

En este caso, el primer template desarrollado corresponde a una **política IAM**, la cual será clave para definir los permisos que utilizará el rol (que veremos más adelante) para ejecutar correctamente la **replicación multi-regional en S3**.

Este template representa el primer paso dentro de la construcción de nuestra infraestructura como código, debido que en AWS **todo acceso entre servicios se basa en permisos bien definidos**.

🔗 GitHub: [Template-PoliticaIAM-Replicacion](https://github.com/BrayanR03/Proyecto-IAC-Replicacion-MultiRegion-S3-AWS/blob/main/code/capitulo-3/template-politica-iam.yml)

---

## 🔍 Contexto del proyecto

Para entender mejor el objetivo de este template, puedes revisar el enfoque completo del proyecto aquí:

📘 [Post-Replicacion-MultiRegional-S3](https://www.linkedin.com/posts/brayan-rafael-neciosup-bola%C3%B1os-407a59246_aws-amazons3-cloudcomputing-activity-7443107772272934912-VBaR?utm_source=share&utm_medium=member_desktop&rcm=ACoAAD0GLAcBWgj1gDgGQecSyD8Ue9xrnAoNcp8)

---

## 🔁 Enfoque de este proyecto

Este desarrollo está basado en una implementación previa que realicé:

👉 Replicación en S3 usando la consola de AWS (modo manual)

Sin embargo, en este proyecto:

🔥 **Estoy migrando ese enfoque a Infraestructura como Código (IaC)**

Es decir:

- Pasar de configuraciones manuales  
- A templates reutilizables y versionados  

---

## 🧠 Idea clave

> Antes de replicar datos en S3, necesitas definir correctamente  
> quién tiene permisos para hacerlo.

Y eso empieza aquí:  
👉 con una **política IAM bien definida**