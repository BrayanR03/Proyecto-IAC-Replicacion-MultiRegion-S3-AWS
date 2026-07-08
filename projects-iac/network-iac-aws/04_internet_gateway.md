## 🌐 Internet Gateway mediante Infraestructura como Código (IaC)

Una vez que hemos definido correctamente nuestra **VPC**, segmentado el espacio de direcciones mediante **Subnets** y planificado adecuadamente los bloques **CIDR**, es momento de incorporar el componente que permitirá que parte de nuestra infraestructura pueda comunicarse con Internet: el **Internet Gateway (IGW)**.

Aunque muchas veces se piensa que basta con crear una Subnet pública para que nuestros recursos sean accesibles desde Internet, la realidad es que una Subnet, por sí sola, no proporciona conectividad hacia el exterior.

Para que un recurso pueda enviar y recibir tráfico desde Internet es necesario incorporar un Internet Gateway y, además, definir correctamente las rutas que utilizarán nuestras Subnets. Ambos componentes trabajan conjuntamente y ninguno reemplaza al otro.

---

### 🏗️ ¿Qué es un Internet Gateway?

* Un **Internet Gateway (IGW)** es un componente administrado por AWS que permite la comunicación entre una **VPC** e Internet.

* Su función principal consiste en actuar como el punto de entrada y salida del tráfico hacia Internet para aquellos recursos que deban ser accesibles desde el exterior.

* Sin embargo, es importante entender que el Internet Gateway **no expone automáticamente todos los recursos de una VPC**.

* Para que exista conectividad hacia Internet también es necesario configurar correctamente las **Route Tables**, las cuales indicarán qué tráfico debe dirigirse hacia el Internet Gateway.

En otras palabras:

> **El Internet Gateway proporciona la puerta de salida, mientras que las Route Tables indican qué recursos utilizarán esa puerta.**

---

### 🏠 Una analogía para entender el Internet Gateway

Continuemos utilizando la analogía de la casa que hemos empleado en capítulos anteriores.
Hasta este momento tenemos:

- 🏠 La **VPC**, que representa toda la casa.
- 🚪 Las **Subnets**, que representan las habitaciones donde organizamos nuestros recursos.
- 🔒 Algunas habitaciones contienen recursos privados.
- 🌐 Otras habitaciones contendrán recursos que eventualmente deberán ser visibles desde el exterior.

Sin embargo, existe un problema: **Nuestra casa sigue completamente cerrada.**
No existe ninguna puerta que permita salir hacia la calle o que permita a las personas ingresar.

Precisamente esa puerta representa el **Internet Gateway**. 

Ahora bien... ¿Basta únicamente con tener una puerta?

No. También necesitamos un camino que conduzca hasta ella.

Ese camino son las **Route Tables**, las cuales estudiaremos en el siguiente capítulo.
Por ello:

- El **Internet Gateway** representa la puerta hacia Internet.
- Las **Route Tables** indican qué habitaciones pueden utilizar esa puerta.

Solo cuando ambos componentes trabajan juntos los recursos podrán comunicarse correctamente con Internet.

---

### 🌐 ¿Qué ocurre realmente cuando una instancia accede a Internet?

Aquí aparece uno de los conceptos que suele generar más confusión.

Aunque una instancia EC2 se encuentre dentro de una **Public Subnet**, internamente AWS siempre le asigna una **dirección IP privada** para que pueda comunicarse dentro de la VPC.

El hecho de que una Subnet sea denominada "pública" no significa que sus recursos nazcan automáticamente expuestos a Internet.

Para que una instancia pueda comunicarse con Internet normalmente se requiere que:

- pertenezca a una Subnet cuya Route Table tenga una ruta hacia el Internet Gateway.
- disponga de una dirección IPv4 pública o una Elastic IP (cuando se utiliza IPv4).
- las reglas de Security Groups y Network ACLs permitan dicho tráfico.

Solo cuando se cumplen todas estas condiciones el tráfico podrá entrar y salir correctamente de la VPC.

---

### 🔄 El papel del Internet Gateway en la traducción de direcciones

Otro aspecto interesante del Internet Gateway es que participa en la comunicación entre las direcciones privadas utilizadas dentro de la VPC y las direcciones públicas utilizadas para acceder desde Internet.

Cuando una instancia EC2 dispone de una dirección IPv4 pública, AWS realiza una traducción **uno a uno (1:1)** entre la dirección pública y la dirección privada de dicha instancia.

Gracias a este mecanismo:

- internamente la instancia continúa utilizando su dirección IP privada.
- externamente puede ser alcanzada mediante su dirección IP pública.

Este comportamiento es completamente administrado por AWS y forma parte del funcionamiento del Internet Gateway.

---

### 💻 Internet Gateway en CloudFormation

Dentro de AWS CloudFormation, el Internet Gateway se define mediante el siguiente recurso:

```yaml
Type: AWS::EC2::InternetGateway
```

Posteriormente, este recurso debe asociarse explícitamente a una VPC utilizando otro recurso de CloudFormation:

```yaml
Type: AWS::EC2::VPCGatewayAttachment
```

Esta asociación es obligatoria, debido que un Internet Gateway no puede operar de manera independiente; siempre debe estar conectado a una única VPC.

Una vez realizada esta asociación, el siguiente paso consistirá en crear las **Route Tables** que dirigirán el tráfico de las Subnets públicas hacia dicho Internet Gateway.

---

### 🎯 Conclusión

Aunque el Internet Gateway suele parecer uno de los componentes más sencillos del Networking en AWS, realmente forma parte de un conjunto de elementos que trabajan coordinadamente para proporcionar conectividad hacia Internet.

Por sí solo no expone recursos ni convierte automáticamente una Subnet en pública.

Su verdadera función consiste en proporcionar el punto de conexión entre la VPC e Internet, mientras que las Route Tables, las direcciones IP públicas y las reglas de seguridad determinarán finalmente qué recursos podrán utilizar esa conectividad.

Comprender esta relación desde el inicio facilitará enormemente el entendimiento de los siguientes componentes de la arquitectura de red.

---

### 📂 Template del capítulo

Puedes revisar el template completo utilizado en este capítulo en el siguiente enlace:

**[template-igw.yml](https://github.com/BrayanR03/Proyecto-IAC-Replicacion-MultiRegion-S3-AWS/blob/main/projects-iac/network-iac-aws/template/template-igw.yml)**