# Caso práctico 2. Automatización de despliegues en entornos Cloud

El objetivo de este caso práctico es desplegar un clúster de Kubernetes en Azure y un servidor NFS. 
Para el despliegue de la infraestructura trabajaremos con Terraform y para la instalación y configuración con Ansible.


Una vez esté el clúster operativo se realizará el despliegue de un aplicativo en kubernete, es requisito que se haga uso de un volumen compartido por NFS.


**Requisitos**

Es necesario tener un entorno local con el siguiente software:
 - Terraform
 - azure cli 
 - ansible
 - python3

Además para poder acceder al entorno generado en Azure debemos crear una clave pública de acceso ya que la forma de trabajar de Ansible es a través de conexiones ssh a los servidores remotos.
