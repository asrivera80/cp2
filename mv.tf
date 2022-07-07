# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine
resource "azurerm_linux_virtual_machine" "master" {
    name = "vmmaster"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    size                = var.vm_size
    admin_username      = "azureuser"
    network_interface_ids = [ 
      azurerm_network_interface.myNic1.id 
      ]
    
    admin_ssh_key {
      username   = "azureuser"
      public_key = file("~/.ssh/id_rsa.pub")
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

    #boot_diagnostics {
     # storage_account_uri = azurerm_storage_account.stAccount.primary_blob_enpoint  
    #}
  
    tags = {
      environment = "CP2"
    }
}