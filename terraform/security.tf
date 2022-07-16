
# Creamos el security group:
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group
# Desde este recursos permitimos el acceso al puerto 22 de las máquinas desplegadas
resource "azurerm_network_security_group" "mySecGroup" {
  name                = "sshtraffic"
  location            = azurerm_resource_group.rg-k8.location
  resource_group_name = azurerm_resource_group.rg-k8.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = var.tags
}

# Vincular con la interfaz de red 
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association

# Recurso para vincular la seguridad con la NIC del nodo master
resource "azurerm_network_interface_security_group_association" "mySecGroupAssociation1" {
    network_interface_id      = azurerm_network_interface.NicMaster.id
    network_security_group_id = azurerm_network_security_group.mySecGroup.id
}

# Recurso para vincular la seguridad con las NIC de los nodos worker y nfs (importante variable vms para el bucle)
resource "azurerm_network_interface_security_group_association" "mySecGroupAssociation2" {
  count = length(var.vms)
  network_interface_id      = azurerm_network_interface.NicWorker[count.index].id
  network_security_group_id = azurerm_network_security_group.mySecGroup.id
}