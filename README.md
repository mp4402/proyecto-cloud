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
Recuerda que para poder seguir estos pasos debes contar con una cuenta en Amazon Console
### Grupos de seguridad 
*Este apartado será de utilidad para la base de datos*

* Ve a la sección servicios y busca EC2:
![image](https://github.com/mp4402/proyecto-cloud/assets/69279232/2f05266c-56ff-41c9-aa7f-4122033bb558)
* En la barra lateral de la izquiera busca el apartado *Red y seguridad* y selecciona *Security Groups*
* Selecciona *Crear grupo de seguridad*
* Ingresa el nombre deseado para el grupo de seguridad (por ejemplo 'acceso_db') y agrega una descripción del grupo de seguridad
* Agrega una nueva regla de entrada de la siguiente forma:
  ![image](https://github.com/mp4402/proyecto-cloud/assets/69279232/f3f5e0f3-ef95-4d9c-b114-08a6c73f1c3e)
* Finalmente, crea el grupo de seguridad

### S3
* Ve a la sección servicios y busca S3:
![image](https://github.com/mp4402/proyecto-cloud/assets/61555440/3c28d446-b9df-448d-9b3d-e2642959c4cc)
* Ve a create bucket
* Nombra tu bucket como: [tu-nombre]-proyecto-conectados-demo
* Deselecciona la sección Block public access:
![image](https://github.com/mp4402/proyecto-cloud/assets/61555440/209977fe-0abf-4c50-8b44-4ba8a095c805)
* Deja todo lo demás como te sale y crea el bucket.

* Al tener el bucket levantado, entra y ve a la sección de Permissions -> Bucket policy:
![image](https://github.com/mp4402/proyecto-cloud/assets/61555440/bf0f1d1c-4357-45d1-b47e-85940e92c7a3)
* Entra a editar, copia y pega lo siguiente:
```
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
```

* Ve a la sección de Permissions -> Cross-origin resource sharing (CORS):
![image](https://github.com/mp4402/proyecto-cloud/assets/61555440/6335f43f-a163-4de8-a7bb-a79301d0540f)
* Entra a editar, copia y pega lo siguiente:
```
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
```

* Listo con esta configuración ya podrás acceder a la información de tu bucket, regresa a Objects del bucket y crea dos carpetas
1. Carpeta para las imágenes de usuario
2. Carpeta para imágenes de las portadas de los eventos
### RDS
## Google
Recuerda que para poder seguir estos pasos debes contar con una cuenta en Google Cloud Plattform

### Kubernetes
* Busca *kubernetes* y selecciona *Kubernetes engine*
![image](https://github.com/mp4402/proyecto-cloud/assets/69279232/62936ea9-7733-4109-a60b-c24066c98b73)
* Selecciona *Crear*
* Ingresa un nombre para el clúster (por ejemplo conectados-app) y click en *Crear*
![image](https://github.com/mp4402/proyecto-cloud/assets/69279232/f933060e-1e8b-47db-8d61-2153ad1bbbdf)
* Mientras el clúster se crea, puede tomar un tiempo, instalaremos software necesario
* Descarga Gcloud utilizando los siguientes comandos
  * Windows  
  ```
  (New-Object Net.WebClient).DownloadFile("https://dl.google.com/dl/cloudsdk/channels/rapid/GoogleCloudSDKInstaller.exe", "$env:Temp\GoogleCloudSDKInstaller.exe")

  & $env:Temp\GoogleCloudSDKInstaller.exe
    
  ```
  
* Inicia Gcloud, te pedirá que inicies sesión y crear un proyecto
* En la terminal normal de la PC se instalará gke-gcloud-auth-plugin y kubectl. Ejecuta los siguientes comandos:
  * gke-gcloud-auth-plugin
    ```
    gcloud components install gke-gcloud-auth-plugin
    ```
    Espera a que termine la instalación, esto puede tomar un tiempo, al acabar deberás ver esta pantalla:
    ![image](https://github.com/mp4402/proyecto-cloud/assets/69279232/f846f5bd-839e-4597-973d-57857e018b38)

  *  kubectl
    ```
    gcloud components install kubectl
    ```
    
*   En la consola de Gcloud dirigete a la carpeta del proyecto utilizando *cd*
*   Ejecuta el comando para conectarte al clúster. Lo obtienes al clickear *Conectar* el clúster creado
![image](https://github.com/mp4402/proyecto-cloud/assets/69279232/3cb66780-51dd-4f31-98c9-d217969f1203)
*   Ejecuta los siguientes comandos:
  ```
  kubectl apply -f app-deployment.yaml
  ```
  ```
  kubectl get pods
  ```
  *Espera a que READY esté en 1/1*
  ```
  kubectl apply -f app-service.yaml
  ```

  ```
  kubectl get services
  ```
  *De la IP generada podrás acceder a la app en el puerto 3000*
