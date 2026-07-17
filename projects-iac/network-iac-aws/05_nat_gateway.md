## 🌐 NAT Gateway mediante Infraestructura como Código (IaC)

Pues bien, hasta este punto ya hemos construido gran parte de los componentes principales de nuestra infraestructura de red:

- Virtual Private Cloud (VPC)
- Subnets
- Internet Gateway

Sin embargo, algo que he aprendido durante este proceso es que los componentes de Networking en AWS no funcionan de manera aislada. Cada uno complementa al anterior y, en muchos casos, algunos recursos deben existir antes que otros para que la arquitectura funcione correctamente.

Esto suele generar muchas dudas, tanto cuando trabajamos con Infraestructura como Código (IaC) como cuando configuramos la infraestructura directamente desde la consola de AWS.

Personalmente, la forma más sencilla de entenderlo ha sido imaginar el Networking como un rompecabezas.

Cada componente representa una pieza distinta. A medida que vamos colocando una pieza sobre el tablero, aparecen nuevos espacios que solo podrán completarse con los siguientes componentes. Eso es precisamente lo que está ocurriendo en esta primera etapa del Networking en AWS.

---

## 🧩 El complemento del Internet Gateway

Antes de estudiar las Route Tables, existe otro componente fundamental que debemos comprender: el **NAT Gateway**.

Si el **Internet Gateway** permite que los recursos públicos puedan comunicarse con Internet, el NAT Gateway resuelve un problema completamente distinto.

Permite que los recursos ubicados dentro de **Subnets privadas** puedan iniciar conexiones hacia Internet sin quedar expuestos públicamente.

Y sí...

A primera vista puede parecer contradictorio.

> ¿Por qué una Subnet privada necesitaría acceso a Internet?

La respuesta es bastante sencilla.

Muchos recursos privados necesitan conectarse temporalmente a Internet para realizar tareas como:

- descargar actualizaciones del sistema operativo
- instalar paquetes y dependencias
- consumir APIs externas
- acceder a repositorios de software
- obtener parches de seguridad

Sin embargo, ninguno de estos recursos debería aceptar conexiones iniciadas desde Internet. Y, precisamente ese es el objetivo del NAT Gateway: *Permitir únicamente conexiones salientes, manteniendo completamente protegidos los recursos privados frente a conexiones entrantes.*

---

## 🏗️ NAT Gateway en CloudFormation

Como hemos visto en capítulos anteriores, todos los componentes relacionados con la infraestructura de red pertenecen al namespace **AWS::EC2** dentro de CloudFormation.

Por ello, el NAT Gateway se define mediante:

```yaml
Type: AWS::EC2::NatGateway
```

Sin embargo, antes de crear este recurso debemos construir otro componente indispensable:
**🌍 La Elastic IP**

Todo NAT Gateway necesita disponer de una dirección IP pública fija. En AWS, esta dirección recibe el nombre de **Elastic IP (EIP)**. Mientras que desde la consola de AWS basta con aprovisionarla mediante unos pocos clics, en CloudFormation debemos crearla explícitamente utilizando el recurso:

```yaml
Type: AWS::EC2::EIP
```

Y, una de sus propiedades más importantes es:

```yaml
Domain: vpc
```

* Esta propiedad indica que la Elastic IP será utilizada dentro del modelo de redes basado en **Amazon VPC**.
* Actualmente esta es la configuración habitual, debido que el antiguo modelo **EC2-Classic** fue retirado por AWS hace varios años.

---

## 🔗 Relación entre la Elastic IP y el NAT Gateway

Una vez creada la Elastic IP, podremos asociarla al NAT Gateway.

En CloudFormation normalmente utilizaremos la propiedad:

```yaml
AllocationId
```

* La cual permite indicar qué Elastic IP será utilizada por el NAT Gateway para representar el tráfico saliente hacia Internet.
* De esta manera, cuando varias instancias privadas accedan a Internet, AWS utilizará esa única dirección pública para realizar la traducción de direcciones (NAT).
* Es importante entender que las instancias continúan utilizando sus direcciones IP privadas dentro de la VPC. El NAT Gateway es quien representa dicho tráfico hacia Internet mediante la Elastic IP asociada.

---

## 🔄 Dependencias entre recursos

Como ya hemos visto en capítulos anteriores, algunos recursos únicamente pueden crearse cuando otros ya existen. En este caso, el NAT Gateway necesita que previamente se haya creado la Elastic IP.

Por ello, podemos utilizar:

```yaml
DependsOn
```

para hacer explícita esta dependencia dentro del template.

Aunque CloudFormation suele detectar automáticamente estas relaciones cuando un recurso referencia a otro, indicar la dependencia de forma explícita puede facilitar la comprensión y el mantenimiento del código.

---

## ⚙️ Propiedades importantes del NAT Gateway

Una vez creada la Elastic IP, podemos configurar el NAT Gateway mediante varias propiedades importantes.

* **AllocationId**: 
    * Indica qué Elastic IP será asociada al NAT Gateway.

* **ConnectivityType**:
    * En este proyecto utilizaremos el modo **public**, ya que el NAT Gateway necesitará comunicarse con Internet a través del Internet Gateway. AWS también permite NAT Gateway privados para escenarios muy específicos, aunque no serán abordados en esta serie.

* **SubnetId**: 
    * Esta propiedad indica en qué Subnet será desplegado el NAT Gateway. Y aquí aparece uno de los conceptos más importantes del capítulo.

    * Aunque el NAT Gateway proporciona conectividad a las **Subnets privadas**, él mismo debe desplegarse dentro de una **Subnet pública**. ¿Por qué?: Porque únicamente una Subnet pública dispone de conectividad hacia Internet mediante el Internet Gateway.

    * Posteriormente, las Route Tables redirigirán el tráfico de las Subnets privadas hacia dicho NAT Gateway.

* **AvailabilityMode**:

    * Esta propiedad define el modo de disponibilidad que utilizará el NAT Gateway.
    * Para este proyecto utilizaremos el modo **zonal**, suficiente para comprender el funcionamiento del servicio y construir nuestra arquitectura.

* **MaxDrainDurationSeconds**:

    * Esta propiedad controla cuánto tiempo AWS permitirá que las conexiones activas finalicen antes de cerrar el NAT Gateway durante procesos de actualización, reemplazo o eliminación del recurso.

    * En la mayoría de proyectos no suele modificarse, pero resulta interesante conocer su propósito dentro de CloudFormation.

---

## 🧩 Ya casi completamos el rompecabezas

Hasta este momento ya hemos construido los principales componentes que permitirán la conectividad de nuestra infraestructura:

- VPC
- Subnets
- Internet Gateway
- NAT Gateway

* Hasta ahora sabemos **qué componentes permiten la comunicación**, pero aún no hemos definido **qué caminos recorrerá el tráfico** para llegar hasta ellos.

* Esa responsabilidad recaerá sobre las **Route Tables**, el siguiente componente que estudiaremos.

* Siguiendo con la analogía del rompecabezas, ya tenemos casi todas las piezas sobre el tablero. Ahora solo falta conectarlas correctamente para que toda la arquitectura cobre sentido.

---

## 📂 Template del capítulo

Puedes revisar el template completo utilizado en este capítulo en el siguiente enlace:

**[template-nat-gateway.yml](https://github.com/BrayanR03/Proyecto-IAC-Replicacion-MultiRegion-S3-AWS/blob/main/projects-iac/network-iac-aws/template/template-nat-gateway.yml)**