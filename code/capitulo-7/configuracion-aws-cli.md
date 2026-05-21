# ⚙️ Configuración de AWS CLI para automatizar despliegues en CloudFormation

En esta sección del Proyecto Final de IaC, realizaremos toda la configuración necesaria para poder automatizar despliegues de infraestructura utilizando:

- AWS CLI
- CloudFormation
- scripts `.sh`

Y sí…

Aunque muchas veces comenzamos desplegando recursos manualmente desde la consola de AWS, tarde o temprano terminamos necesitando automatizar procesos.

Justamente aquí es donde AWS CLI se vuelve una herramienta extremadamente importante dentro de proyectos de Infraestructura como Código (IaC).

---

## 🟦 ¿Qué es AWS CLI?

AWS CLI (Command Line Interface) es la interfaz de línea de comandos oficial de AWS.

Esta herramienta nos permite conectarnos a nuestra cuenta AWS directamente desde nuestra máquina local sin necesidad de ingresar constantemente a la consola web de administración.

Gracias a AWS CLI podemos:

- desplegar infraestructura,
- ejecutar comandos sobre servicios AWS,
- automatizar tareas,
- integrar scripts,
- trabajar con CloudFormation,
- y construir flujos DevOps mucho más automatizados.

En otras palabras:

> AWS CLI funciona como un intermediario entre nuestra máquina local y los servicios AWS.

---

## 🟦 Instalación de AWS CLI

En este proyecto utilizo:

- Windows 11

Por ello, descargaremos AWS CLI mediante el instalador oficial `.msi` proporcionado por AWS.

🔗 Descarga oficial:

https://awscli.amazonaws.com/AWSCLIV2.msi

---

## 🟦 Verificando la instalación

Una vez instalado AWS CLI, abrimos un `CMD` o terminal y ejecutamos:

```bash
aws --version
```

Si la instalación fue correcta, obtendremos algo similar a:

```bash
aws-cli/2.x.x Python/3.x Windows/10 exe/AMD64
```

Esto confirma que AWS CLI fue instalado correctamente en nuestra máquina.

---

## 🟦 Antes de configurar AWS CLI

Instalar AWS CLI no significa automáticamente que ya podamos desplegar infraestructura.

Primero necesitaremos:

👉 credenciales válidas de AWS.

Y para ello crearemos un **usuario IAM** que será utilizado específicamente por AWS CLI.

---

## 🟦 Creación del usuario IAM

Dentro de AWS debemos dirigirnos a:

```yml
AWS Management Console → IAM → Access Management
→ Users → Create User
```

Y el nombre del usuario, en mi caso será:

```yml
User name: user-brayan-cli
```

---

### 🧠 Sobre el acceso a la consola

Durante la creación del usuario, AWS preguntará si deseamos permitir acceso a la consola web.

En este caso:

👉 NO será necesario habilitar acceso a consola.

¿Por qué?

Porque el usuario será utilizado únicamente desde AWS CLI.

---

## 🟦 Configuración de permisos

Posteriormente asignaremos permisos al usuario.

Para este proyecto, y únicamente con fines educativos/laboratorio, utilizaremos permisos amplios para evitar restricciones durante los despliegues iniciales.

```yml
Attach policies directly → AdministratorAccess
```

---

### ⚠️ Importante sobre seguridad

En entornos reales, lo recomendable es aplicar el principio de mínimo privilegio (*Least Privilege*), otorgando únicamente los permisos estrictamente necesarios.

Evitar permisos administrativos globales ayuda muchísimo a reducir riesgos de seguridad.

---

## 🟦 Creación del Access Key

Una vez creado el usuario IAM, podremos generar las credenciales necesarias para AWS CLI.

Nos dirigimos al usuario creado y luego:

```yml
Security credentials → Access keys → Create access key
```

Seleccionaremos el caso de uso:

```yml
Command Line Interface (CLI)
```

Y marcamos (☑️) en:

```yml
I understand the above recommendation and want to proceed to create an access key
```

---

## 🟦 Credenciales generadas

AWS nos entregará:

- Access Key ID
- Secret Access Key

Por ejemplo:

```yml
AWS Access Key ID:
<ACCESS_KEY>

AWS Secret Access Key:
<SECRET_ACCESS_KEY>
```

⚠️ Es muy importante almacenar estas credenciales en un lugar seguro.

---

### 🔐 Recomendación importante de seguridad

Nunca compartas públicamente tus Access Keys o Secret Access Keys.

Si una clave es expuesta accidentalmente:

- elimínala inmediatamente desde IAM,
- y genera nuevas credenciales.

---

## 🟦 Configuración de AWS CLI

Ahora sí, procederemos a configurar AWS CLI.

En nuestra terminal (`CMD`) ejecutamos:

```bash
aws configure
```

Este comando almacenará localmente las credenciales necesarias para autenticarnos automáticamente contra AWS desde nuestra máquina.

AWS CLI comenzará a solicitar distintos campos:

---

### 🔹 Campo 1

```yml
AWS Access Key ID:
<ACCESS_KEY>
```

---

### 🔹 Campo 2

```yml
AWS Secret Access Key:
<SECRET_ACCESS_KEY>
```

---

### 🔹 Campo 3

```yml
Default region name:
us-east-2
```

En este caso utilizaremos la región:

```yml
us-east-2
```

como región por defecto para los despliegues iniciales.

---

### 🔹 Campo 4

```yml
Default output format:
json
```

---

## 🟦 Validando la conexión con AWS

Una vez configurado AWS CLI, podemos validar la conexión ejecutando:

```bash
aws sts get-caller-identity
```

Si todo fue configurado correctamente, obtendremos algo similar a:

```json
{
  "UserId": "...",
  "Account": "...",
  "Arn": "..."
}
```

---

### 🧠 ¿Qué hace este comando?

Este comando permite verificar que AWS CLI logró autenticarse correctamente contra nuestra cuenta AWS.

En otras palabras:

**👉 confirma que ya podemos interactuar con AWS desde nuestra máquina local.
**

---

## 🟦 Reflexión importante

Muchas veces pensamos que Infraestructura como Código consiste únicamente en escribir YAML.

Pero realmente:

> IaC también implica comprender automatización, autenticación, despliegues y herramientas que conectan nuestra infraestructura con el código.

Y justamente AWS CLI representa uno de los primeros pasos reales hacia automatización de infraestructura dentro del ecosistema AWS.