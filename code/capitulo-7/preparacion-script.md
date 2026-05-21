
# 💻Preparación para ejecutar script `.sh`

A partir de este punto ya podremos comenzar a automatizar despliegues utilizando scripts.

Sin embargo, como trabajaremos con scripts `.sh`, utilizaremos:

- Git Bash

---

## 🟦 ¿Por qué utilizaremos Git Bash?

Aunque este proyecto fue desarrollado sobre Windows 11, Git Bash proporciona un entorno compatible con múltiples comandos Linux.

Y esto resulta extremadamente útil para ejecutar scripts Bash dentro de Windows.

Además, en la mayoría de escenarios relacionados con Git y GitHub, muchos desarrolladores ya poseen Git instalado previamente.

---

## 🟦 Permisos de ejecución del script

Una vez creado nuestro script, debemos otorgarle permisos de ejecución:

```bash
chmod +x nombre_script.sh
```

---

## 🟦 Organización recomendada del proyecto

Es recomendable mantener:

- scripts,
- templates,
- configuraciones relacionadas,

dentro de una estructura organizada de carpetas.

Esto facilita muchísimo:

- despliegues,
- mantenimiento,
- automatización,
- y administración del proyecto.

---

## 🟦 Ejecutando el script

Desde Git Bash accederemos a la carpeta donde se encuentra nuestro script:

```bash
cd ruta/proyecto
```

Y posteriormente ejecutaremos:

```bash
./nombre_script.sh
```

Durante la ejecución podremos visualizar en terminal los mensajes definidos mediante:

```bash
echo
```

lo cual nos permitirá monitorear progresivamente el despliegue de infraestructura.

---