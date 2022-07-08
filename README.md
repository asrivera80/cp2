# Caso práctico 2. Automatización de despliegues en entornos Cloud

El objetivo es desplegar un clúster de Kubernetes en Azure y un servidor NFS. 
Para el despliegue de la infraestructura se utilizará Terraform y para la automatización de instalación y configuración de software se utilizará Ansible.

Una vez esté el clúster operativo se realizará la instalación de un aplicativo que haga uso de un volumen del NFS. En nuestro caso se desplegará nginx, con el DocumentRoot compartido por nfs.




