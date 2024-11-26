output "default_site_hostname" {
  description = "The default URL of the App Service"
  value       = azurerm_linux_web_app.app_service.default_hostname
}
