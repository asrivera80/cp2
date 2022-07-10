# definimos la red, subred y creamos la NIC asociada 
resource "azurerm_virtual_network" "myNet" {
  name                = "kubernetesnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  tags = {
    environment = "CP2"
  }
}

resource "azurerm_subnet" "mySubnet" {
  name  = "terraformsubnet"
  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.myNet.name
  address_prefixes = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "pubmaster"{
  name  = "ip_public-master"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method = "Dynamic"
  sku = "Basic"  
  
  tags = {
    environment = "CP2"
  }
}

resource "azurerm_public_ip" "pubworker"{
  name  = "ip_public-worker${count.index}"
  count = var.contador 
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method = "Dynamic"
  sku = "Basic"  
  
  tags = {
    environment = "CP2"
  }
}

resource "azurerm_network_interface" "NicMaster" {
  name = "nic-master"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  
  ip_configuration {
    name                          = "ipconf-master"
    subnet_id                     = azurerm_subnet.mySubnet.id
    private_ip_address_allocation = "Static"
    private_ip_address = "10.0.1.10"
    public_ip_address_id = azurerm_public_ip.pubmaster.id
  }

  tags = {
    environment = "CP2"
  }
}

resource "azurerm_network_interface" "NicWorker" {
  name = "nicworker-${count.index}"
  count = var.contador
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  
  ip_configuration {
    name                          = "ipconf-worker${count.index}"
    subnet_id                     = azurerm_subnet.mySubnet.id
    private_ip_address_allocation = "Static"
    private_ip_address = "10.0.1.${11 + count.index}"
    public_ip_address_id = azurerm_public_ip.pubworker[count.index].id
  }

  tags = {
    environment = "CP2"
  }
}