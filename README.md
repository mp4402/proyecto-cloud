# Conectados
Conectados es una plataforma destinada a proveer y encontrar tu actividad ideal, aprovecha y conecta con el mundo.
Proyecto Final del curso Automation Testing
Prueba para el CI

## Involucrados

## Servicios a utilizar
* Amazon S3
* Amazon RDS
* Kubernetes Engine Google Cloud
# Prerequisitos

# Configuración de la nube
## Amazon
### S3
Recuerda que para poder seguir estos pasos debes contar con una cuena en Amazon Console
* Ve a la sección servicios y busca S3:
![image](https://github.com/mp4402/proyecto-cloud/assets/61555440/3c28d446-b9df-448d-9b3d-e2642959c4cc)
* Ve a create bucket
* Nombra tu bucket como: [tu-nombre]-proyecto-conectados-demo
* Deselecciona la sección Block public access:
![image](https://github.com/mp4402/proyecto-cloud/assets/61555440/209977fe-0abf-4c50-8b44-4ba8a095c805)
* Deja todo lo demás como te sale y crea el bucket.

* Al tener el bucket levantado, entra y ve a la sección de Permissions -> Bucket Policy:
![image](https://github.com/mp4402/proyecto-cloud/assets/61555440/bf0f1d1c-4357-45d1-b47e-85940e92c7a3)
* En ella copia esto:
'''
{
    "Version": "2012-10-17",
    "Id": "Policy1698024307293",
    "Statement": [
        {
            "Sid": "Stmt1698024303518",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::conectadosfiles/*"
        }
    ]
}
'''
### RDS
## Google
### Kubernetes
