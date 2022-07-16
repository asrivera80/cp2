# definimos la red, subred, ip privada y pública asociada a cada uno de los nodos
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network

# Recurso para crear la red 
resource "azurerm_virtual_network" "myNet" {
  name                = "kubernetesnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg-k8.location
  resource_group_name = azurerm_resource_group.rg-k8.name

  tags = var.tags
}

# Recurso para crear la subred 
resource "azurerm_subnet" "mySubnet" {
  name  = "terraformsubnet"
  resource_group_name = azurerm_resource_group.rg-k8.name
  virtual_network_name = azurerm_virtual_network.myNet.name
  address_prefixes = ["10.0.1.0/24"]
}

# Recurso para crear la ip pública del nodo master
resource "azurerm_public_ip" "pubmaster"{
  name  = "ip_public-master"
  location = azurerm_resource_group.rg-k8.location
  resource_group_name = azurerm_resource_group.rg-k8.name
  allocation_method = "Dynamic"
  sku = "Basic"  
  
  tags = var.tags
}

# Recurso para crear la ip pública del nodo worker y nfs (importante variable vms para el bucle)
resource "azurerm_public_ip" "pubworker"{
  count = length(var.vms)
  name  = "ip_public-${var.vms[count.index]}"
  location = azurerm_resource_group.rg-k8.location
  resource_group_name = azurerm_resource_group.rg-k8.name
  allocation_method = "Dynamic"
  sku = "Basic"  
  
  tags = var.tags
}

# Recurso para crear la ip privada del nodo master
resource "azurerm_network_interface" "NicMaster" {
  name = "nic-master"
  location            = azurerm_resource_group.rg-k8.location
  resource_group_name = azurerm_resource_group.rg-k8.name
  
  ip_configuration {
    name                          = "ipconf-master"
    subnet_id                     = azurerm_subnet.mySubnet.id
    private_ip_address_allocation = "Static"
    private_ip_address = "10.0.1.10"
    public_ip_address_id = azurerm_public_ip.pubmaster.id
  }

  tags = var.tags
}

# Recurso para crear la ip privada del nodo worker y nfs (importante variable vms para el bucle)
resource "azurerm_network_interface" "NicWorker" {
  count = length(var.vms)
  name  = "nic-${var.vms[count.index]}"
  location            = azurerm_resource_group.rg-k8.location
  resource_group_name = azurerm_resource_group.rg-k8.name
  
  ip_configuration {
    name                          = "ipconf-${var.vms[count.index]}"
    subnet_id                     = azurerm_subnet.mySubnet.id
    private_ip_address_allocation = "Static"
    private_ip_address = "10.0.1.${11 + count.index}"
    public_ip_address_id = azurerm_public_ip.pubworker[count.index].id
  }

  tags = var.tags
}
