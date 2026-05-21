#!/bin/bash

set -e

echo "======================================"
echo "Desplegando infraestructura AWS"
echo "======================================"


##==========================================
## PROPIEDADES EN EL DESPLIEGUE

## --template-file: NOMBRE Y UBICACION DEL TEMPLATE A DESPLEGAR
## --stack-name: NOMBRE DEL STACK PARA CLOUDFORMATION 
## --region: REGION DONDE DESPLEGAREMOS LOS RECURSOS DEL TEMPLATE EN CLOUDFORMATION
## --capabilities CAPABILITY_NAMED_IAM: LE INDICA A AWS QUE NOSOTROS DEFINIMOS NOMBRES A RECURSOS IAM
##==========================================

## PARA FACILITAR EL DESPLIEGUE, MOVIMOS LOS TEMPLATES A ESTA CARPETA DONDE SE ENCUENTRA EL SCRIPT

## DESPLIEGUE DE BUCKET DESTINO EN LA REGION: N. Virginia (us-eats-1)
echo "1. Desplegando bucket destino..."

aws cloudformation deploy \
  --template-file template-bucket-s3-destino.yml \
  --stack-name stack-s3-bucket-destino-replicacion-cf \
  --region us-east-1

echo "Bucket destino desplegado"


## DESPLIEGUE DE RECURSOS IAM Y BUCKET ORIGEN EN LA REGION: Ohio (us-eats-2)

### DESPLIEGUE DE RECURSOS IAM
echo "2. Desplegando IAM..."

aws cloudformation deploy \
  --template-file template-iam.yml \
  --stack-name stack-iam-replicacion-cf \
  --region us-east-2 \
  --capabilities CAPABILITY_NAMED_IAM

echo "IAM desplegado"


### DESPLIEGUE DE RECURSO DE S3 (BUCKET ORIGEN)
echo "3. Desplegando bucket origen..."

aws cloudformation deploy \
  --template-file template-bucket-s3-origen.yml \
  --stack-name stack-s3-bucket-origen-replicacion-cf \
  --region us-east-2

echo "Bucket origen desplegado"

echo "======================================"
echo "DEPLOY FINALIZADO"
echo "======================================"