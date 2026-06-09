import boto3
import urllib.parse

# Inicializamos el cliente de S3
s3 = boto3.client('s3')

def lambda_handler(event, context):
    # 1. Extraer información del evento de origen (El bucket de origen)
    ## El nombre del bucket proviene de un JSON al cuál accedemos como un diccionario
    source_bucket = event['Records'][0]['s3']['bucket']['name'] ## Nombre bucket
    key = urllib.parse.unquote_plus(event['Records'][0]['s3']['object']['key']) ## Objeto
    
    # 2. Apuntamos el bucket de destino
    target_bucket = 'destino-bucket-brayan-mover-objetos' ## Nombre del bucket destino
    copy_source = {'Bucket': source_bucket, 'Key': key} ## Dirección del bucket origen
    
    ## Encapsulamos lógica y manejamos excepciones
    try:
        ## Print para revisar en CloudWatch
        print(f"Iniciando copia de {key} desde {source_bucket} hacia {target_bucket}")
        
        # 3. Realizamos la copia del objeto
        s3.copy_object(Bucket=target_bucket, Key=key, CopySource=copy_source)
        
        # 4. Eliminamos el original (Opcional)
        # s3.delete_object(Bucket=source_bucket, Key=key)
        
        print(f"Objeto {key} movido exitosamente.")
        
        return {
            'statusCode': 200,
            'body': f"Archivo {key} procesado."
        }
        
    except Exception as e:
        print(f"Error procesando el objeto: {e}")
        raise e
