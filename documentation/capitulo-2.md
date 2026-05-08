# 📖 Capítulo 2: El Template — La base para desplegar infraestructura en AWS (sin código… por ahora)

Hay algo que debes tener muy claro desde el inicio:

👉 **El template es la base de todo en IaC**

Especialmente en AWS, donde utilizamos **CloudFormation** como servicio nativo para definir y desplegar infraestructura mediante código.

---

## 📌 ¿Qué es realmente un Template?

Un **template** es un archivo donde definimos nuestra infraestructura.

Es básicamente:

👉 La traducción de lo que harías con clics… pero en código.

---

## 🧾 Formatos disponibles

En CloudFormation existen dos formatos principales:

### 1. YAML (recomendado ✅)

- Más legible
- Basado en indentación
- Muy utilizado en herramientas como Docker (`docker-compose`)

👉 Si ya has usado Docker, este formato te resultará familiar.

---

### 2. JSON

- Más estructurado
- Más verboso
- Muy conocido por desarrolladores

---

### 💡 Recomendación

Para este proyecto:

👉 Usaremos **YAML**

Porque es más limpio, más fácil de leer y más práctico para trabajar.

---

## 🏗️ ¿Cómo estructurar los templates?

Aquí es donde empieza una de las decisiones más importantes.

Podemos trabajar con dos enfoques:

---

### 🔹 1. Templates anidados (todo en uno)

Un solo template con múltiples recursos:

- EC2
- S3
- IAM
- VPC
- etc.

📌 Ventaja:
- Todo centralizado

📌 Desventaja:
- Difícil de mantener cuando crece

---

### 🔹 2. Templates individuales (uno por recurso)

Un template por cada recurso.

📌 Ventaja:
- Muy modular

📌 Desventaja:
- Demasiados archivos
- Difícil de gestionar en conjunto

---

## ⚖️ El enfoque de este proyecto

No vamos a irnos a extremos.

👉 Usaremos un enfoque híbrido:

### 📦 Agrupar por servicio

- Un template para IAM (roles, policies, etc.)
- Un template para S3 (buckets, configuraciones, etc.)

Es decir:

👉 **Agrupamos recursos que pertenecen al mismo servicio**

---

### 🧠 Idea clave

No existe una única forma correcta.

La estructura dependerá de:

- Complejidad del proyecto
- Cantidad de recursos
- Nivel de modularidad que necesites

---

## 📂 Organización del repositorio

Puedes revisar ejemplos en:

- `templates-anidados-servicio/`
- `templates-individuales-recurso/`

Esto te ayudará a entender las diferencias en la práctica.

---

## 🤔 ¿Cómo sé qué escribir en un template?

Aquí viene una de las mejores partes:

👉 **No necesitas memorizar nada**

AWS ya te da todo.

---

## 📚 Documentación oficial (tu mejor aliada)

CloudFormation tiene documentación completa para cada recurso:

👉 https://docs.aws.amazon.com/cloudformation/

---

### 🔍 Cómo buscar un recurso

Solo necesitas buscar en Google algo como:
* aws iam role cloudformation
* aws s3 bucket cloudformation

Y encontrarás:

- Estructura del recurso
- Propiedades disponibles
- Ejemplos

---

## 🧩 ¿Qué hacemos con esa información?

Muy simple:

1. Copiamos la plantilla base del recurso
2. Eliminamos lo que no necesitamos
3. Adaptamos a nuestro caso

👉 Así construimos nuestros templates.

---

## 🧠 Idea clave de este capítulo

> No se trata de memorizar CloudFormation  
> se trata de saber **leer, adaptar y reutilizar** templates.

---

## 🚧 Lo que viene

Ahora que ya entendemos:

- Qué es un template
- Qué formato usar
- Cómo estructurarlo
- De dónde sacar la información

👉 En el siguiente capítulo:

🔥 **Crearemos nuestro primer template real en AWS**

---

## 💬 Nota final

Si sientes que aún no sabes “cómo escribir código de IaC”…

Perfecto.

Aún no toca escribir.  
Primero toca **entender cómo pensar**.