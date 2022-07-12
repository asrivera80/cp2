output "resource_group_id" {
  value = azurerm_resource_group.rg-k8.id
}

output "public_ip_address_master" {
  description = "Public IP Master"
  value = azurerm_public_ip.pubmaster.ip_address
}
output "network_interface_master" {
  description = "Private ip Master"
  value       = azurerm_network_interface.NicMaster.private_ip_address
}

