# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine
resource "azurerm_linux_virtual_machine" "vm" {
    count = length(var.vms)
    name  = var.vms[count.index]
    
    location            = azurerm_resource_group.rg-k8.location
    resource_group_name = azurerm_resource_group.rg-k8.name
    size                = var.vm_size
    admin_username      = var.ssh_user
    network_interface_ids = [ 
      azurerm_network_interface.NicWorker[count.index].id 
      ]
     disable_password_authentication = true
    
    admin_ssh_key {
      username   = var.ssh_user
      public_key = file(var.public_key_path)
    }

    os_disk {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }

    plan {
      name      = "centos-8-stream-free"
      product   = "centos-8-stream-free"
      publisher = "cognosys"
    }

    source_image_reference {
      publisher = "cognosys"
      offer     = "centos-8-stream-free"
      sku       = "centos-8-stream-free"
      version   = "22.03.28"
    }

    tags = var.tags
}
resource "azurerm_linux_virtual_machine" "master" {
  name = "master"
  location            = azurerm_resource_group.rg-k8.location
  resource_group_name = azurerm_resource_group.rg-k8.name
  size                = var.size_master
  admin_username      = var.ssh_user
  network_interface_ids = [ 
    azurerm_network_interface.NicMaster.id,
  ]
  disable_password_authentication = true
    
  admin_ssh_key {
    username   = var.ssh_user
    public_key = file(var.public_key_path)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  plan {
    name      = "centos-8-stream-free"
    product   = "centos-8-stream-free"
    publisher = "cognosys"
  }

  source_image_reference {
    publisher = "cognosys"
    offer     = "centos-8-stream-free"
    sku       = "centos-8-stream-free"
    version   = "22.03.28"
  }
  
  tags = var.tags
}