## 🌐 VPC mediante Infraestructura como Código (IaC)

Pues bien, como primer componente de Networking en AWS, comenzaremos estudiando el recurso que sirve como base para la mayoría de arquitecturas desplegadas en la nube: **Amazon Virtual Private Cloud (VPC)**.

La VPC es una red virtual aislada lógicamente dentro de AWS que nos permite definir el espacio de direcciones IP donde vivirán nuestros recursos, controlar su conectividad y establecer las bases sobre las cuales construiremos el resto de la infraestructura.

Aunque a simple vista pueda parecer únicamente una "red virtual", realmente representa el punto de partida para el diseño de cualquier arquitectura que requiera aislamiento, control del tráfico y segmentación de recursos.

---

## 🏗️ La VPC: el punto de partida de nuestra arquitectura

Una VPC define el espacio de direcciones IP privadas que podrán utilizar los recursos desplegados dentro de ella.

Para ello, AWS permite asociarle:

- Direccionamiento **IPv4** (obligatorio)
- Direccionamiento **IPv6** (opcional)

A partir de este espacio de direcciones construiremos posteriormente:

- Subnets
- Route Tables
- Internet Gateway
- NAT Gateway
- Security Groups
- Network ACLs

Es decir, la VPC será el componente principal sobre el cual construiremos toda la infraestructura de red de este proyecto.

---

## 🌎 La VPC predeterminada en AWS

Cuando creamos una cuenta de AWS, el servicio genera automáticamente una **Default VPC** en cada región disponible para que podamos comenzar a desplegar recursos sin realizar configuraciones iniciales.

Sin embargo, en proyectos reales normalmente evitamos utilizar estas VPC predeterminadas.

¿Por qué?

Porque al diseñar una arquitectura desde cero buscamos tener control absoluto sobre:

- el direccionamiento IP
- la segmentación de la red
- las reglas de seguridad
- el crecimiento futuro de la infraestructura

Además, AWS permite crear varias VPC por región. De forma predeterminada, el límite suele ser de **5 VPC por región**, aunque esta cuota puede incrementarse solicitándolo a AWS cuando el proyecto lo requiera.

---

## 📌 El CIDR: la decisión más importante al crear una VPC

Uno de los aspectos más importantes al definir una VPC es elegir correctamente su bloque **CIDR (Classless Inter-Domain Routing)**.

El CIDR representa el rango de direcciones IP privadas que tendrá disponible nuestra VPC para distribuir posteriormente entre sus diferentes subredes.

Esta decisión debe tomarse considerando:

- el tamaño del proyecto
- la cantidad de recursos
- el crecimiento esperado
- futuras conexiones con otras redes

Una mala planificación del CIDR puede generar conflictos de direccionamiento difíciles de solucionar posteriormente.

---

### 📊 Tamaños comunes de bloques CIDR

La siguiente tabla resume algunos de los tamaños más utilizados:

| CIDR | Cantidad aproximada de IPs | Tamaño | Uso recomendado |
|------|----------------------------:|---------|----------------|
| /8 | 16,777,216 | Muy grande | Redes corporativas muy extensas |
| /16 | 65,536 | Grande | VPC completas (muy utilizado en proyectos) |
| /20 | 4,096 | Mediano | Subredes de tamaño medio |
| /24 | 256 | Pequeño | Subredes pequeñas |
| /28 | 16 | Muy pequeño | Laboratorios y ambientes de prueba |

> **Nota:** cuando posteriormente creemos las Subnets, AWS reservará automáticamente cinco direcciones IP dentro de cada una de ellas para uso interno del servicio.

---

## 🌐 ¿Qué rango de direcciones privadas debo utilizar?

Actualmente trabajamos con los rangos privados definidos por el estándar **RFC 1918**:

- **10.0.0.0/16**
- **172.16.0.0/12**
- **192.168.0.0/16**

En muchos proyectos es común utilizar el rango **10.0.0.0/16**, ya que ofrece una gran flexibilidad para dividir la red en múltiples subredes.

Sin embargo, la elección del rango dependerá de la arquitectura existente y de evitar conflictos con otras redes corporativas, VPNs o conexiones híbridas.

Por ello, antes de definir el CIDR de una VPC siempre debemos analizar cómo crecerá la infraestructura en el futuro.

---

## 💻 La VPC en CloudFormation

Una de las primeras diferencias que encontramos al trabajar con Infraestructura como Código es la forma en que AWS organiza sus recursos.

Por ejemplo:

- Amazon S3 utiliza:

```yaml
Type: AWS::S3::Bucket
```

- AWS Lambda utiliza:

```yaml
Type: AWS::Lambda::Function
```

- Mientras que Amazon VPC se define mediante:

```yaml
Type: AWS::EC2::VPC
```

A simple vista puede parecer extraño que una VPC pertenezca al espacio de nombres **AWS::EC2**.

Sin embargo, esto se debe a que CloudFormation agrupa bajo dicho namespace todos los recursos relacionados con la infraestructura de red y cómputo utilizada por Amazon EC2, incluyendo:

- VPC
- Subnets
- Route Tables
- Internet Gateway
- NAT Gateway
- Security Groups

No significa que la VPC dependa de EC2, sino que ambos forman parte del mismo conjunto de recursos administrados por CloudFormation.

---

## ⚙️ Propiedades importantes de una VPC

Cuando creamos una VPC mediante la consola de AWS muchas configuraciones pasan prácticamente desapercibidas.

Sin embargo, en CloudFormation debemos definir explícitamente varias propiedades importantes.

*  `EnableDnsHostnames: true`

Cuando esta propiedad está habilitada, las instancias EC2 que dispongan de una dirección IP pública podrán recibir automáticamente un nombre DNS público proporcionado por AWS.

Esto facilita acceder a los recursos utilizando nombres DNS en lugar de direcciones IP.

---

* `EnableDnsSupport: true`

Esta propiedad habilita el resolvedor DNS administrado por AWS dentro de la VPC. Gracias a ello, los recursos desplegados podrán resolver nombres de dominio correctamente, tanto internos como servicios propios de AWS.

---

* `InstanceTenancy: default`

Esta propiedad define el tipo de hardware donde podrán ejecutarse las instancias EC2 creadas dentro de la VPC.

Por ejemplo:

- **default:** utiliza infraestructura física compartida con otros clientes de AWS.
- **dedicated:** utiliza hardware dedicado exclusivamente para una sola cuenta de AWS.

En la mayoría de proyectos utilizaremos el valor **default**, ya que reduce costos y resulta suficiente para la mayoría de escenarios.

---

## 🎯 Conclusión

Aunque inicialmente una VPC pueda parecer simplemente una red virtual, en realidad representa uno de los componentes más importantes dentro de cualquier arquitectura desplegada en AWS.

Una correcta planificación de aspectos como:

- el bloque CIDR
- el direccionamiento IP
- la resolución DNS
- la segmentación de la red

permitirá evitar futuros problemas relacionados con crecimiento, conectividad o conflictos de direccionamiento.

En los siguientes capítulos iremos incorporando progresivamente el resto de componentes del Networking para construir una arquitectura completa utilizando Infraestructura como Código.

---

### 📂 Template del capítulo

Puedes revisar el template completo utilizado para este capítulo en el siguiente enlace:

**[template-vpc.yml](https://github.com/BrayanR03/Proyecto-IAC-Replicacion-MultiRegion-S3-AWS/tree/main/projects-iac/network-iac-aws/template/template-vpc.yml)**