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
	default = "Standard_DS2_v2" #modificar y poner de 4Gb y 2vcpu
}
