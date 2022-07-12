# crear el grupo de recursos
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group
resource "azurerm_resource_group" "rg-k8" {
  name = "rg-k8"
  location = var.location
  
  tags = var.tags
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.12.0"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

#storage account
resource "azurerm_storage_account" "stAccount"{
  name = var.storage_account
  resource_group_name = azurerm_resource_group.rg-k8.name
  location = azurerm_resource_group.rg-k8.location
  account_tier = "Standard"
  account_replication_type = "LRS"
  
  tags = var.tags
}