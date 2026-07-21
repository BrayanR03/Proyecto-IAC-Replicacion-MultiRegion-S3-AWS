## 🌐 Route Tables mediante Infraestructura como Código (IaC)

Pues bien, después de haber definido correctamente nuestras **Subnets** (públicas y privadas), junto con el **Internet Gateway** y el **NAT Gateway**, es momento de incorporar uno de los componentes más importantes del Networking en AWS: las **Route Tables**.

Hasta este punto, hemos construido todos los componentes necesarios para que nuestra infraestructura pueda comunicarse con Internet. Sin embargo, todavía existe una pregunta por responder:

> ¿Cómo saben nuestros recursos por dónde debe viajar el tráfico?

La respuesta está en las **Route Tables**.

Estas son las encargadas de definir el camino que seguirá el tráfico generado por los recursos dentro de las diferentes Subnets. Es un concepto que suele generar bastante confusión, debido que muchas veces pensamos que una Subnet pública o privada ya determina automáticamente cómo se comunicará con Internet, pero realmente no es así.

---

### 🏠 La analogía de la casa

Continuando con la analogía utilizada en capítulos anteriores:

- La **VPC** representa la casa.
- Las **Subnets** representan las habitaciones.
- El **Internet Gateway** representa la puerta principal de la casa.
- El **NAT Gateway** representa una salida controlada para las habitaciones privadas.

Sin embargo, todavía falta algo muy importante.

Imaginemos que ya tenemos la puerta de la casa instalada, pero dentro de ella no existen pasillos ni señalizaciones que indiquen cómo llegar hasta esa puerta.

Eso es precisamente lo que hacen las **Route Tables**.

Las Route Tables definen las rutas que seguirán nuestros recursos para llegar hasta Internet.

Dependiendo del tipo de Route Table, el tráfico podrá:

- dirigirse hacia un **Internet Gateway**, permitiendo tráfico de entrada y salida para los recursos públicos.
- dirigirse hacia un **NAT Gateway**, permitiendo únicamente tráfico saliente para los recursos privados.

Es importante mencionar que, por defecto, toda VPC posee una tabla de rutas inicial donde únicamente existe comunicación local dentro de la propia VPC. Es decir, mientras no agreguemos nuevas rutas, nuestros recursos únicamente podrán comunicarse entre sí dentro de la red privada.

---

### 🌍 Route Tables públicas y privadas

Al igual que las Subnets, normalmente trabajaremos con dos tipos de Route Tables:

- **Route Table Pública**
- **Route Table Privada**

Cada una se asociará con el tipo de Subnet correspondiente.

De esta manera:

- Las **Subnets públicas** utilizarán una **Route Table pública**.
- Las **Subnets privadas** utilizarán una **Route Table privada**.

Esta separación permite mantener una arquitectura organizada y aplicar distintas rutas según el nivel de exposición que tendrán nuestros recursos.

---

### 💻 Route Tables en CloudFormation

Como todos los componentes de Networking vistos hasta el momento, las Route Tables pertenecen al namespace de Amazon EC2 dentro de CloudFormation.

Su definición se realiza mediante:

```yaml
Type: AWS::EC2::RouteTable
```

Una de sus propiedades principales es:

```yaml
VpcId
```

Esta propiedad indica a qué VPC pertenecerá la Route Table.

Esto es importante porque una Route Table únicamente puede administrar el tráfico de las Subnets pertenecientes a la misma VPC.

Cabe mencionar que AWS crea automáticamente una Route Table predeterminada cuando se crea una VPC. Sin embargo, en la mayoría de proyectos es recomendable crear Route Tables personalizadas, debido que ofrecen un mayor control sobre la arquitectura de red.

---

### 🔗 Asociación entre Route Tables y Subnets

Definir una Route Table no significa que automáticamente comience a administrar las Subnets.
Para ello debemos crear asociaciones explícitas entre ambas.
En CloudFormation esta asociación se define mediante el recurso:

```yaml
Type: AWS::EC2::SubnetRouteTableAssociation
```

Este recurso debe crearse una vez que la Route Table ya exista, por lo que normalmente estableceremos una dependencia con dicho recurso.

Las propiedades principales son:

- **RouteTableId**, que indica la tabla de rutas que utilizaremos.
- **SubnetId**, que indica la Subnet que quedará asociada.

Es importante entender que cada asociación se define como un recurso independiente dentro del template.

Por ejemplo, si una Route Table debe asociarse con dos Subnets públicas, necesitaremos crear dos recursos `SubnetRouteTableAssociation`.

Aunque desde la consola de AWS esto parece una simple selección, en Infraestructura como Código cada asociación forma parte explícita de nuestra infraestructura.

---

### 🛣️ Definiendo las rutas

Una vez creada la Route Table y realizadas sus asociaciones, llega el momento de definir las rutas que utilizará el tráfico.
En CloudFormation las rutas se crean mediante:

```yaml
Type: AWS::EC2::Route
```

Al igual que otros recursos, primero debe existir la Route Table sobre la cual trabajará la ruta.
Las propiedades más importantes son las siguientes:

* `DestinationCidrBlock`: Define el destino hacia donde se enviará el tráfico. En la mayoría de casos utilizaremos:
  ```yml
  0.0.0.0/0
  ```
  Lo que representa cualquier destino en Internet para tráfico IPv4.


* `GatewayId o NatGatewayId`: Aquí indicaremos qué componente será utilizado para que el tráfico salga de la VPC.
Si trabajamos con una **Route Table pública**, la ruta apuntará hacia el **Internet Gateway** utilizando la propiedad:
  ```yaml
  GatewayId
  ```

  Si trabajamos con una **Route Table privada**, la ruta apuntará hacia el **NAT Gateway** utilizando la propiedad:

  ```yaml
  NatGatewayId
  ```

  Esta diferencia es muy importante, ya que ambos recursos utilizan propiedades distintas dentro de CloudFormation.

* `RouteTableId`: Finalmente, esta propiedad indica sobre qué Route Table será creada la ruta.

Aunque desde la consola de AWS esta relación se configura de forma transparente, en IaC debemos especificarla explícitamente para que CloudFormation conozca dónde debe aplicar dicha configuración.

---

### 🎯 Conclusión

* Las Route Tables representan el componente que finalmente da sentido a todos los recursos de Networking que hemos construido hasta este punto.

* Gracias a ellas podemos definir el camino que seguirá el tráfico generado por nuestros recursos y decidir si una Subnet tendrá comunicación con Internet mediante un **Internet Gateway** o únicamente salida controlada mediante un **NAT Gateway**.

* En otras palabras, las Route Tables son quienes conectan todas las piezas del rompecabezas que hemos venido construyendo desde la creación de la VPC.

---

### 📂 Template del capítulo

Puedes revisar el template completo utilizado en este capítulo en el siguiente enlace:
**[template-route-table.yml](https://github.com/BrayanR03/Proyecto-IAC-Replicacion-MultiRegion-S3-AWS/blob/main/projects-iac/network-iac-aws/template/template-route-table.yml)**