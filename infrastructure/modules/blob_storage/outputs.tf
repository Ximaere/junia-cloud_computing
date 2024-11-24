output "storage_account_name" {
  description = "The name of the Storage Account"
  value       = azurerm_storage_account.storage_account.name
}

output "storage_container_name" {
  description = "The name of the Storage Container"
  value       = azurerm_storage_container.storage_container.name
}

output "storage_url" {
  description = "The URL of the blob storage"
  value       = azurerm_storage_account.storage_account.primary_blob_endpoint
}