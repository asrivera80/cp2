# ver localizaciones disponibles
# az account list-locations -o table
# ver tamaños disponibles:
# az vm list-sizes --location westeurope
variable "location" {
	type = string
	description = "region de azure para crear la infra"
	default = "ukwest"
}
variable "vm_size" {
	type = string
	description = "tamaño de la máquina virtual"
	default = "Standard_D1_v2" #tamaño worker y nfs tb puede ser Standard_A2_v2
}
variable "size_master" {
	type = string
	description = "tamaño de la máquina virtual master"
	default = "Standard_DS2_v2" #DS1_v2tamaño para el master tb puede ser Standard_A4_v2
}
variable "vms" {
	description = "Maquinas virtuales a crear"
	type = list (string)
	default = ["worker1", "nfs"]  
}

variable "tags"{
   description = "Etiqueta de recursos"
   type        = map(string)
   default = {
      environment = "CP2"
   }
}

variable "storage_account" {
  type = string
  description = "Nombre para la storage account"
  default = "staccountcp2"
}

variable "public_key_path" {
  type = string
  description = "Ruta para la clave pública de acceso a las instancias"
  default = "~/.ssh/id_rsa.pub" # o la ruta correspondiente
}

variable "ssh_user" {
  type = string
  description = "Usuario para hacer ssh"
  default = "azureuser"
}