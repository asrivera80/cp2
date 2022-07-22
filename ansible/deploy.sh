#!/bin/bash

# Despliegue del cluster de Kubernetes
ansible-playbook -i hosts playbook.yml

# Despliegue de la aplicación
#ansible-playbook -i hosts despliegue-aplicacion.yml