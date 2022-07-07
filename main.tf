# crear el grupo de recursos
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group
resource "azurerm_resource_group" "rg" {
  name = "rg_kubernete"
  location = var.location

  tags = {
    environment = "CP2"
  }
}

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.12.0"
    }
  }
  required_version = ">=1.1.0"
}
  
provider "azurerm" {
    features {}
}

#storage account
resource "azurerm_storage_account" "stAccount"{
  name = "staccountcp2"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  account_tier = "Standard"
  account_replication_type = "LRS"
  
  tags = {
   environment = "CP2"
  }
}