#!/bin/bash
set -e

echo "======================================"
echo "Desplegando infraestructura AWS en región N.Virginia (us-east-1)"
echo "======================================"

## ============ IAM =====================
echo "1. Desplegando Stack IAM..."

aws cloudformation deploy \
  --template-file template-iam.yml \
  --stack-name STACK-IAM-MOVER-OBJETOS-LAMBDA-S3-CF \
  --region us-east-1 \
  --capabilities CAPABILITY_NAMED_IAM

echo "Recursos IAM desplegados mediante el Stack"

## ============ LAMBDA FUNCTIONS =====================
echo "2. Desplegando Stack Lambda Function y Trigger-S3..."

aws cloudformation deploy \
  --template-file template-lambda.yml \
  --stack-name STACK-LAMBDA-FUNCTION-MOVER-OBJETOS-LAMBDA-S3-CF \
  --region us-east-1 \

echo "Recursos Lambda desplegados mediante el Stack"


## ============ S3 =====================
echo "3. Desplegando Stack Buckets-S3 (Origen y Destino)..."

aws cloudformation deploy \
  --template-file template-s3.yml \
  --stack-name STACK-BUCKETS-MOVER-OBJETOS-LAMBDA-S3-CF \
  --region us-east-1

echo "Buckets S3 (Origen y Destino) desplegados mediante el Stack"

echo "======================================"
echo "DEPLOY FINALIZADO"
echo "======================================"