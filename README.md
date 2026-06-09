# 🚀 IaC en AWS: Replicación Multi-Regional en S3 sin odiar CloudFormation

Este repositorio documenta mi proceso de aprendizaje en **Infraestructura como Código (IaC)** utilizando AWS, enfocado en un caso práctico:  

👉 **Replicación Multi-Regional en S3 usando CloudFormation**

Más que solo implementar la solución, este proyecto está organizado como una serie de **capítulos**, donde cada uno introduce una nueva idea, concepto o reto dentro del mundo de IaC.

---

## 📌 Objetivo del proyecto

Construir paso a paso una arquitectura en AWS que permita:

- Automatizar todo usando CloudFormation:
    - Gestionar permisos con IAM
    - Crear buckets en S3
    - Configurar versionado
    - Implementar replicación entre buckets

Todo esto aplicando buenas prácticas de **Infraestructura como Código**.

---

## 🧠 ¿Por qué este proyecto?

Cuando empiezas en IaC, lo más difícil no es escribir código…  
es **entender cómo pensar la infraestructura como código**.

Este proyecto busca:

- Pasar de clics en consola → a código reutilizable
- Entender conceptos clave de AWS desde la práctica
- Perder el miedo a CloudFormation

---

## 🏗️ Stack tecnológico

- **AWS CloudFormation** → Definición de infraestructura
- **Amazon S3** → Almacenamiento y replicación
- **IAM** → Gestión de permisos
- YAML → Definición de templates

---

## 📚 Estructura del aprendizaje (Capítulos)

Cada capítulo introduce una nueva idea dentro de IaC:

---

## 🧭 Tabla de Contenido

| Capítulo | Tema | Estado | Publicación |
|-----------|------|--------|--------------|
| 01 | Cómo empezar en IaC (AWS) sin odiar IaC y AWS | ✅ Completado | [Leer en Wix](https://bryanneciosup626.wixsite.com/brayandataanalitics/post/cap%C3%ADtulo-1-c%C3%B3mo-empezar-en-iac-aws-sin-odiar-iac-y-aws) · [LinkedIn](https://www.linkedin.com/feed/update/urn:li:activity:7456492199430492160/) |
| 02 | El template, la base para desplegar infraestructura en AWS (sin escribir código aún) | ✅ Completado | [Leer en Wix](https://bryanneciosup626.wixsite.com/brayandataanalitics/post/cap%C3%ADtulo-2-el-template-la-base-para-desplegar-infraestructura-en-aws-sin-escribir-c%C3%B3digo-a%C3%BAn) · [LinkedIn](https://www.linkedin.com/feed/update/urn:li:activity:7457599609209716737/) |
| 03 | Escribiendo el Primer Template (IAM Policy) | ✅ Completado | [Leer en Wix](https://bryanneciosup626.wixsite.com/brayandataanalitics/post/cap%C3%ADtulo-3-escribiendo-el-primer-template-iam-policy) · [LinkedIn](https://www.linkedin.com/posts/brayan-rafael-neciosup-bola%C3%B1os-407a59246_cap%C3%ADtulo-3-escribiendo-el-primer-template-activity-7458521183920062465-O0AZ?utm_source=share&utm_medium=member_desktop&rcm=ACoAAD0GLAcBWgj1gDgGQecSyD8Ue9xrnAoNcp8) |
| 04 | El Despliegue del Template en CloudFormation | ✅ Completado | [Leer en Wix](https://bryanneciosup626.wixsite.com/brayandataanalitics/post/cap%C3%ADtulo-4-el-despliegue-del-template-en-cloudformation) · [LinkedIn](https://www.linkedin.com/posts/brayan-rafael-neciosup-bola%C3%B1os-407a59246_aws-cloudformation-iam-ugcPost-7459247745258827776-qKBP?utm_source=share&utm_medium=member_desktop&rcm=ACoAAD0GLAcBWgj1gDgGQecSyD8Ue9xrnAoNcp8) |
| 05 | Lo que nadie te explica de los Templates Unificados | ✅ Completado | [Leer en Wix](https://bryanneciosup626.wixsite.com/brayandataanalitics/post/cap%C3%ADtulo-5-lo-que-nadie-te-explica-de-los-templates-unificados) · [LinkedIn](https://www.linkedin.com/feed/update/urn:li:share:7460861995236515840/) |
| 06 | La importancia del objetivo en un Proyecto IaC y su despliegue en mútliples regiones | ✅ Completado | [Leer en Wix](https://bryanneciosup626.wixsite.com/brayandataanalitics/post/cap%C3%ADtulo-6-la-importancia-del-objetivo-de-un-proyecto-en-iac-y-su-despliegue-en-m%C3%BAltiples-region) · [LinkedIn](https://www.linkedin.com/posts/brayan-rafael-neciosup-bola%C3%B1os-407a59246_cap%C3%ADtulo-6-la-importancia-del-objetivo-activity-7461586591086604288-HFI5?utm_source=share&utm_medium=member_desktop&rcm=ACoAAD0GLAcBWgj1gDgGQecSyD8Ue9xrnAoNcp8) |
| 07 | Despliegue final del proyecto IaC en AWS | ✅ Completado | [Leer en Wix](https://bryanneciosup626.wixsite.com/brayandataanalitics/post/cap%C3%ADtulo-7-despliegue-final-del-proyecto-iac-en-aws) · [LinkedIn](https://www.linkedin.com/posts/brayan-rafael-neciosup-bola%C3%B1os-407a59246_cap%C3%ADtulo-7-despliegue-final-del-proyecto-activity-7463230895987032064-Tdw5?utm_source=share&utm_medium=member_desktop&rcm=ACoAAD0GLAcBWgj1gDgGQecSyD8Ue9xrnAoNcp8) |
| 08 | Lambda + S3 : Mover objetos-Parte 1 | ✅ Completado | [Leer en Wix](https://bryanneciosup626.wixsite.com/brayandataanalitics/post/cap%C3%ADtulo-8-lambda-s3-mover-objetos-parte-1) · [LinkedIn](https://www.linkedin.com/posts/brayan-rafael-neciosup-bola%C3%B1os-407a59246_cuando-comenc%C3%A9-a-aprender-amazon-s3-lo-ve%C3%ADa-share-7466130352886022144-ekLd/?utm_source=share&utm_medium=member_desktop&rcm=ACoAAD0GLAcBWgj1gDgGQecSyD8Ue9xrnAoNcp8) |
| 09 | Lambda + S3 : Mover objetos-Parte 2 | ✅ Completado | [Leer en Wix](https://bryanneciosup626.wixsite.com/brayandataanalitics/post/cap%C3%ADtulo-9-lambda-s3-mover-objetos-parte-2) · [LinkedIn](https://www.linkedin.com/feed/update/urn:li:activity:7467378774263717888/) |
| 10 | Lambda + S3 : Mover objetos-Parte 3 | ✅ Completado | [Leer en Wix](https://bryanneciosup626.wixsite.com/brayandataanalitics/post/cap%C3%ADtulo-10-lambda-s3-mover-objetos-parte-3) · [LinkedIn](https://www.linkedin.com/posts/brayan-rafael-neciosup-bola%C3%B1os-407a59246_cap%C3%ADtulo-10-lambda-s3-mover-objetos-parte-activity-7468470897906020352-BcVI?utm_source=share&utm_medium=member_desktop&rcm=ACoAAD0GLAcBWgj1gDgGQecSyD8Ue9xrnAoNcp8) |
| 11 | Lambda + S3 : Mover objetos-Parte 4 | ✅ Completado | [Leer en Wix](https://bryanneciosup626.wixsite.com/brayandataanalitics/post/cap%C3%ADtulo-11-lambda-s3-mover-objetos-parte-4) · [LinkedIn](https://www.linkedin.com/posts/brayan-rafael-neciosup-bola%C3%B1os-407a59246_aws-amazons3-awslambda-share-7469956195047436288-w6Pi/?utm_source=share&utm_medium=member_desktop&rcm=ACoAAD0GLAcBWgj1gDgGQecSyD8Ue9xrnAoNcp8) |

---


## 📂 Estructura del repositorio (ejemplo)

```CSS
PROYECTO-IAC-REPLICACION-S3/
│
├── 📷 assets/
├── 💻 code/
│ ├── template.md
│ └── ...
│
├── 💻 documentation/
│ ├── capitulo-1.md/
│ └── ...
│
└── 📘 README.md
```
---

## 🧑‍💻 Sobre Mí

Brayan Neciosup Bolaños - Data & Cloud Engineer Jr.

Actualmente explorando **Infraestructura como Código** y su potencial para el despliegue de recursos en AWS.

📫 **Contacto**  
- 🌐 Portafolio: [Portafolio_WIX](https://bryanneciosup626.wixsite.com/brayandataanalitics)  
- 💼 LinkedIn: [linkedin.com/in/brayanneciosup](https://www.linkedin.com/in/brayan-rafael-neciosup-bola%C3%B1os-407a59246/)  
- 🧠 GitHub: [github.com/brayanneciosup](https://github.com/BrayanR03)  
- ✉️ Email: [bryanneciosup626@gmail.com](bryanneciosup626@gmail.com)

---

## 📌 Notas Finales
Este repositorio forma parte de mi **iniciativa personal de documentación técnica**, donde registro mi aprendizaje en distintas tecnologías mediante publicaciones teóricas, ejemplos prácticos y reflexiones profesionales.

> 🎯 *Objetivo final:* consolidar conocimientos, compartir aprendizajes, fortalecer mi presencia técnica y docente en la comunidad.

---
