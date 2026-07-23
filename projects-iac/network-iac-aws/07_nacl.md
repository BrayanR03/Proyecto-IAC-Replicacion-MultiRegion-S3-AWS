## 🌐 NACLs mediante Infraestructura como Código (IaC)

Pues bien, una vez definidos los componentes necesarios para que nuestros recursos puedan comunicarse correctamente dentro y fuera de la VPC, es momento de comenzar con uno de los temas más importantes de toda arquitectura de Networking: **la seguridad de la red**.

Hasta ahora hemos construido la infraestructura que permite el flujo del tráfico. Sin embargo, todavía no hemos definido quién puede comunicarse con nuestros recursos y bajo qué condiciones.

Aquí es donde aparecen los **Network Access Control Lists (NACLs)**.

---

### 🔒 La primera capa de seguridad de la VPC

Los NACLs permiten controlar el tráfico de red **a nivel de Subnet**.

Es decir, mediante este componente podremos establecer qué tráfico podrá ingresar o salir de una determinada Subnet, independientemente de los recursos que existan dentro de ella.

En otras palabras:

- Las **Route Tables** indican **por dónde viajará el tráfico**.
- Los **NACLs** indican **qué tráfico está permitido o denegado**.

Aunque ambos componentes trabajan sobre las Subnets, cumplen responsabilidades completamente diferentes.

---

### 🏠 La analogía de la casa

Continuando con la analogía utilizada durante toda la serie:

- La **VPC** representa la casa.
- Las **Subnets** representan las habitaciones.
- Las **Route Tables** indican los caminos internos.
- El **Internet Gateway** representa la puerta principal.
- El **NAT Gateway** permite que ciertas habitaciones puedan salir sin ser vistas.

Ahora imaginemos que la casa cuenta con un puesto de seguridad antes de ingresar a cada habitación:

* Ese puesto revisa quién puede entrar y quién puede salir.
* Ese puesto de control representa perfectamente un **Network ACL**.
* Cada vez que alguien intenta ingresar o abandonar una Subnet, primero deberá cumplir las reglas definidas en dicho NACL.

---

### ⚠️ Stateless: la característica más importante

Existe una característica que diferencia completamente a los NACLs de los Security Groups:

* Los **NACLs son Stateless**, esto significa que AWS evalúa independientemente el tráfico de entrada y el tráfico de salida.

* Por ejemplo, si permitimos tráfico HTTP de entrada mediante una regla, eso **no significa** que automáticamente se permitirá la respuesta de salida.

* Si queremos permitir ambos sentidos de la comunicación, debemos crear reglas tanto para el tráfico entrante como para el tráfico saliente.

* Siguiendo la analogía de la casa:
    * Es como presentar una credencial para ingresar al edificio.
    * El hecho de haber ingresado no implica que automáticamente puedas salir.
    * Cuando quieras abandonar el edificio, nuevamente deberás mostrar tu credencial para que el sistema vuelva a autorizar tu salida.

Ese comportamiento representa perfectamente el funcionamiento **Stateless** de los NACLs.

---

###  💻 NACLs en CloudFormation

La definición del recurso continúa perteneciendo al namespace de Amazon EC2.

```yaml
Type: AWS::EC2::NetworkAcl
```

Una de sus propiedades principales es:

```yaml
VpcId
```

La cual indica a qué VPC pertenecerá el Network ACL.

---

#### 📌 Una NACL por tipo de Subnet

Aunque AWS crea automáticamente un Network ACL predeterminado para cada VPC, una práctica muy común consiste en crear NACLs personalizadas según el objetivo de la arquitectura.

En la mayoría de proyectos encontraremos:

- NACL Pública
- NACL Privada

Esta clasificación no corresponde a un tipo especial de recurso en AWS, sino al propósito que tendrá cada NACL según las Subnets con las que será asociada.

---

#### 🔗 Asociación entre NACLs y Subnets

Una vez creada la NACL, debemos indicar sobre qué Subnets actuará.
En CloudFormation esta relación se realiza mediante el recurso:

```yaml
Type: AWS::EC2::SubnetNetworkAclAssociation
```

Las propiedades principales son:

```yaml
NetworkAclId
SubnetId
```

donde:

- **NetworkAclId** identifica el NACL creado previamente.
- **SubnetId** indica la Subnet que utilizará dicho Network ACL.

Cada asociación debe definirse como un recurso independiente dentro del template. Si una NACL protege dos Subnets públicas, necesitaremos crear dos recursos `SubnetNetworkAclAssociation`.

---

#### 📋 Reglas del Network ACL

Hasta ahora únicamente hemos creado el contenedor del NACL. Sin embargo, aún no hemos definido qué tráfico será permitido o denegado.
Para ello utilizaremos:

```yaml
Type: AWS::EC2::NetworkAclEntry
```

Este recurso representa una regla individual del Network ACL.

Normalmente primero debe existir el recurso `NetworkAcl`, por lo que CloudFormation podrá establecer automáticamente la dependencia cuando referenciemos el identificador del NACL.

---

#### ⚙️ Propiedades principales de una regla

* `CidrBlock`: Especifica desde qué rango de direcciones IP aplica la regla. 
Puede representar desde una única dirección IP hasta Internet completo (`0.0.0.0/0`).

* `Egress`: Determina si la regla corresponde al tráfico:
    - `false` → Entrada (Inbound)
    - `true` → Salida (Outbound)

* `NetworkAclId`: Indica sobre qué Network ACL será creada la regla.
* `Protocol`: Define el protocolo sobre el cual aplicará la regla. Por ejemplo:

    - TCP
    - UDP
    - ICMP

    CloudFormation utiliza el número del protocolo IP (por ejemplo, **6** para TCP, **17** para UDP y **1** para ICMP), o **-1** para todos los protocolos.

Los puertos se configuran mediante la propiedad `PortRange`, no en `Protocol`.

* `RuleAction`: Define la acción que realizará la regla.
Puede ser:

    - allow
    - deny

* `RuleNumber`: Establece la prioridad de evaluación. AWS procesa primero los números más pequeños.

>>> La primera regla que coincida con el tráfico será la que determine si dicho tráfico será permitido o denegado.

---

### 🎯 Conclusión

* Con los Network ACLs incorporamos la primera capa de seguridad de nuestra arquitectura de Networking.

* Mientras que las Route Tables determinan el camino que seguirá el tráfico, los NACLs establecen qué tráfico podrá atravesar las Subnets.

En el siguiente capítulo estudiaremos el último componente fundamental del Networking en AWS: los **Security Groups**, responsables de proteger directamente a cada recurso desplegado dentro de nuestra infraestructura.

---

### 📂 Template del capítulo

Puedes revisar el template completo utilizado en este capítulo en el siguiente enlace:

**[template-nacl.yml](https://github.com/BrayanR03/Proyecto-IAC-Replicacion-MultiRegion-S3-AWS/blob/main/projects-iac/network-iac-aws/template/template-nacl.yml)**