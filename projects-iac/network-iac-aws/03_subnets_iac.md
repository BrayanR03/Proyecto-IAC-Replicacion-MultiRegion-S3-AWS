## 🌐 Subnets mediante Infraestructura como Código (IaC)

Pues bien, una vez comprendido qué es una **Amazon VPC** y cómo definirla mediante **AWS CloudFormation**, es momento de avanzar hacia otro de los componentes fundamentales del Networking en AWS: **las Subnets (Subredes)**.

Aunque una VPC define el espacio de direcciones IP de toda nuestra red, por sí sola no resulta suficiente para organizar correctamente una arquitectura. Si todos los recursos compartieran un único espacio sin ningún tipo de segmentación, administrar la infraestructura, aplicar políticas de seguridad o controlar el acceso entre recursos sería una tarea extremadamente compleja.

Podemos imaginar la VPC como una casa completamente vacía.

La casa define el espacio disponible, pero si no construimos habitaciones para separar cada ambiente, todo terminaría mezclado y sería muy difícil mantener el orden.

Precisamente ese es el propósito de las **Subnets**.

---

### 🏗️ ¿Qué es una Subnet?

Una Subnet es una subdivisión lógica del bloque CIDR definido para una VPC.

Su principal objetivo es segmentar la red en espacios más pequeños donde podremos organizar nuestros recursos según las necesidades de la arquitectura.

Gracias a esta segmentación podremos:

- distribuir correctamente las direcciones IP disponibles
- aislar diferentes tipos de recursos
- controlar la conectividad entre componentes
- implementar arquitecturas más seguras y escalables

En otras palabras, las Subnets permiten convertir una única red grande en múltiples redes más pequeñas y especializadas.

---

### 🌍 Subnets públicas y privadas

Una de las decisiones más importantes al diseñar una arquitectura consiste en determinar qué recursos podrán comunicarse directamente con Internet y cuáles permanecerán completamente aislados.

Por ello, normalmente encontraremos dos tipos de Subnets:

#### 🌐 Subnets Públicas

Son aquellas donde desplegamos recursos que necesitan recibir tráfico directamente desde Internet.

Algunos ejemplos son:

- Load Balancers públicos
- Bastion Hosts
- Servidores Web
- NAT Gateway

Estas Subnets podrán enrutar tráfico hacia un **Internet Gateway**, permitiendo que los recursos sean accesibles desde Internet cuando la arquitectura así lo requiera.

---

#### 🔒 Subnets Privadas

Las Subnets privadas alojan recursos que no deben exponerse directamente a Internet.

Por ejemplo:

- Bases de datos
- Aplicaciones internas
- Microservicios
- Servidores de procesamiento

Estos recursos permanecen protegidos dentro de la red privada y únicamente pueden comunicarse con otros componentes autorizados de la arquitectura.

> **Importante:** una Subnet privada no significa necesariamente que no tenga salida a Internet. Mediante un **NAT Gateway**, los recursos pueden iniciar conexiones hacia Internet sin quedar expuestos a conexiones entrantes.

---

### 🏢 Una buena práctica: utilizar todas las Zonas de Disponibilidad

Cuando diseñamos una arquitectura altamente disponible, una buena práctica consiste en distribuir las Subnets entre todas las **Availability Zones (AZ)** de la región.

Por ejemplo:

| Availability Zone | Subnet Pública | Subnet Privada |
|-------------------|----------------|----------------|
| us-east-1a | ✅ | ✅ |
| us-east-1b | ✅ | ✅ |
| us-east-1c | ✅ | ✅ |

Este enfoque permite:

- aumentar la disponibilidad
- distribuir la carga entre distintas zonas físicas
- reducir el impacto ante la caída de una Availability Zone
- facilitar el despliegue de servicios altamente disponibles

Aunque no todas las arquitecturas requieren utilizar todas las AZ, sí es una práctica muy común en entornos productivos.

---

## 💻 La definición de una Subnet en CloudFormation

Al igual que la VPC, las Subnets pertenecen al namespace de infraestructura de red administrado por CloudFormation.

Por ello, el recurso se define mediante:

```yaml
Type: AWS::EC2::Subnet
```

Esto no significa que la Subnet dependa de Amazon EC2, sino que CloudFormation agrupa bajo el namespace **AWS::EC2** todos los recursos relacionados con la infraestructura de red utilizada por dicho servicio.

---

### 📍 AvailabilityZone

Una de las propiedades más importantes de una Subnet es:

```yaml
AvailabilityZone: us-east-1a
```

* Esta propiedad indica en qué **Availability Zone** será creada la Subnet.
* Todos los recursos desplegados posteriormente dentro de dicha Subnet residirán físicamente en esa zona de disponibilidad.
* Por ello, una correcta distribución de Subnets entre varias AZ resulta fundamental para construir arquitecturas altamente disponibles.

---

### 📌 El CIDR de una Subnet

Así como la VPC posee un bloque CIDR, cada Subnet también debe disponer de su propio rango de direcciones IP.

Este nuevo CIDR debe estar completamente contenido dentro del CIDR definido para la VPC. Por ejemplo:

| Recurso | CIDR |
|---------|------|
| VPC | 10.0.0.0/16 |
| Subnet Pública A | 10.0.1.0/24 |
| Subnet Privada A | 10.0.2.0/24 |
| Subnet Pública B | 10.0.3.0/24 |
| Subnet Privada B | 10.0.4.0/24 |

De esta forma, vamos subdividiendo progresivamente el espacio de direcciones disponible.

---

### 📊 ¿Cuántas direcciones IP tiene una Subnet?

Una máscara muy utilizada para las Subnets es **/24**.

Un bloque **/24** contiene:

- **256 direcciones IPv4**

Sin embargo, dentro de AWS únicamente tendremos **251 direcciones utilizables**, debido que AWS reserva automáticamente cinco direcciones IP dentro de cada Subnet.

Estas direcciones son utilizadas internamente por la plataforma:

| Dirección | Uso |
|-----------|-----|
| Primera IP | Dirección de red |
| Segunda IP | Router de la VPC |
| Tercera IP | Amazon DNS |
| Cuarta IP | Reservada por AWS |
| Última IP | Broadcast |

Por ello, al planificar el direccionamiento IP de nuestra arquitectura debemos considerar estas reservas automáticas.

---

## 🌐 MapPublicIpOnLaunch

Otra propiedad muy importante es:

```yaml
MapPublicIpOnLaunch: true
```

Esta propiedad determina si las instancias **EC2** lanzadas dentro de la Subnet recibirán automáticamente una dirección IPv4 pública.

Normalmente:

- **true** → Subnets públicas
- **false** → Subnets privadas

Es importante aclarar que esta propiedad **no convierte automáticamente una Subnet en pública o privada**.

Para que una Subnet sea realmente pública también debe existir una **Route Table** con una ruta hacia un **Internet Gateway**.

Por el contrario, una Subnet privada carece de dicha ruta directa hacia Internet.

---

## 🔗 Asociando la Subnet con la VPC

Toda Subnet debe pertenecer obligatoriamente a una VPC.

Para ello utilizamos la propiedad:

```yaml
VpcId:
```

Cuando trabajamos con varios Stacks, normalmente obtenemos este valor de dos maneras:

- mediante la exportación del **Output** del Stack donde fue creada la VPC utilizando `!ImportValue`
- mediante referencias directas (`!Ref`) cuando todos los recursos pertenecen al mismo template

De esta forma evitamos escribir valores estáticos y conseguimos que nuestra infraestructura sea mucho más reutilizable y fácil de mantener.

---

## 🎯 Conclusión

* Las Subnets representan uno de los componentes más importantes dentro del diseño de una arquitectura de red en AWS.

* Gracias a ellas podemos dividir una VPC en segmentos más pequeños, organizar los recursos según su nivel de exposición, distribuir la carga entre distintas Availability Zones y planificar adecuadamente el direccionamiento IP de nuestra infraestructura.

* Una correcta planificación de las Subnets facilitará enormemente el crecimiento futuro de la arquitectura y evitará costosos procesos de reorganización de la red.

En el siguiente capítulo continuaremos incorporando nuevos componentes del Networking para seguir construyendo nuestra infraestructura completamente mediante Infraestructura como Código.

---

## 📂 Template del capítulo

Puedes revisar el template completo utilizado en este capítulo en:

**[template-subnets.yml](https://github.com/BrayanR03/Proyecto-IAC-Replicacion-MultiRegion-S3-AWS/blob/main/projects-iac/network-iac-aws/template/template-subnets.yml)**