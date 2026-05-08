# 📖 Capítulo 1: Cómo empezar en IaC (AWS) sin odiar IaC y AWS

Este es el primer proyecto que elaboro sobre **Infraestructura como Código (IaC)**,  
donde me he topado con diferentes terminologías, tecnologías y puntos críticos al momento de migrar de una UI con clics en cantidad…  
a elaborar **código puro y duro sobre la infraestructura de AWS**.

---

## 🤯 El choque inicial

Pasar de:

👉 Crear recursos haciendo clic en la consola  
a  
👉 Definir todo mediante código  

no es trivial.

Aquí es donde empiezan a aparecer dudas como:

- ¿Qué es realmente IaC?
- ¿Por dónde empiezo?
- ¿Qué herramienta debo usar?
- ¿Por qué esto parece más complicado que hacer clics?

Y sí… al inicio puede ser frustrante.

---

## 📌 ¿Qué es IaC?

IaC es, más que una herramienta, una **disciplina**.

Nos permite crear infraestructura en la nube (en cualquier cloud provider) de forma:

- ⚡ Más rápida  
- 🧾 Versionada  
- ♻️ Reutilizable  

Pero el problema no es entender qué es…  
👉 el problema es **por dónde empezar**.

---

## ☁️ ¿CloudFormation o Terraform?

Dependiendo del cloud provider, las opciones cambian:

- Si trabajas solo con AWS → **CloudFormation**
- Si quieres multi-cloud → **Terraform**

En este proyecto, vamos a trabajar con:

👉 **AWS CloudFormation**

---

## 🏗️ Conceptos clave (sin complicarnos la vida)

Antes de escribir código, necesitamos entender dos conceptos fundamentales:

### 📄 Template (Plantilla)

Es un archivo en:

- YAML
- JSON

Aquí defines **qué infraestructura quieres crear**.

---

### 📦 Stack

Es la herramienta que:

- Toma el template
- Lo ejecuta
- Crea y gestiona los recursos en AWS

---

## 🏠 Analogía simple (la que realmente me ayudó)

Imagina que quieres construir una casa:

| Elemento real | En IaC |
|--------------|--------|
| Plano arquitectónico | Template |
| Constructor | Stack |
| Casa construida | Infraestructura en AWS |

El template **no hace nada por sí solo**.  
Necesita del stack para convertirse en algo real.

---

## ⚙️ ¿Cómo empezar realmente?

El flujo básico es:

1. Crear un template (YAML o JSON)
2. Definir recursos según documentación de AWS
3. Subir el template a CloudFormation
4. Crear un Stack
5. Asignar un nombre
6. Desplegar 🚀

---

## 🧠 Idea clave de este capítulo

Si tuviera que resumir todo en una sola idea:

> IaC no es solo escribir código…  
> es aprender a pensar la infraestructura como código.

---

## 🚧 Lo que viene

Hasta ahora, todo ha sido teoría y base conceptual.

En los siguientes capítulos:

- Empezaremos a crear recursos reales
- Dejaremos los clics de lado
- Y comenzaremos con nuestro caso práctico:
  
👉 **Buckets en S3 y replicación usando CloudFormation**

---

## 💬 Nota personal

Si esto te parece confuso, vas bien.  
Es parte del proceso.

Este proyecto no busca ser perfecto,  
busca ser **entendible y realista**.