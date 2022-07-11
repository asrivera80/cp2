#!/bin/bash

# Despliegue del cluster de Kubernetes
ansible-playbook -i hosts despliegue-kubernetes.yml

# Despliegue de la aplicación
ansible-playbook -i hosts despliegue-aplicacion.yml