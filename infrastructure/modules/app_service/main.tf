# Create the App Service Plan
resource "azurerm_service_plan" "service_plan" {
  name                = var.service_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "B1"
  os_type             = "Linux"  # Explicitly specify Linux
}


# Create the App Service
resource "azurerm_linux_web_app" "app_service" {
  name                = var.app_service_name
  service_plan_id     = azurerm_service_plan.service_plan.id
  location            = var.location
  resource_group_name = var.resource_group_name

  site_config {
    always_on       = true
  }

  app_settings = {
    WEBSITE_RUN_FROM_PACKAGE = "1"
  }
}

# Intégration de l'App Service avec le VNet
resource "azurerm_app_service_virtual_network_swift_connection" "example" {
  app_service_id = azurerm_linux_web_app.app_service.id
  subnet_id      = var.service_app_subnet_id
}