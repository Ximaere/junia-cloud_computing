output "vnet_id" {
  description = "The ID of the Virtual Network"
  value       = azurerm_virtual_network.vnet.id
}

output "app_service_subnet_id" {
  description = "The ID of the subnet for the App Service"
  value       = azurerm_subnet.app_service_subnet.id
}

output "blob_storage_subnet_id" {
  description = "The ID of the subnet for the Blob Storage"
  value       = azurerm_subnet.blob_storage_subnet.id
}
