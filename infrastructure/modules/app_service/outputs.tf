output "default_site_hostname" {
  description = "The default URL of the App Service"
  value       = azurerm_app_service.app_service.default_site_hostname
}
