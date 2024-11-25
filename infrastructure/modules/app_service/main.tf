# Create the App Service Plan
resource "azurerm_service_plan" "service_plan" {
  name                = var.service_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "B1"
  os_type             = "Linux"  # Explicitly specify Linux
}


# Create the App Service
resource "azurerm_app_service" "app_service" {
  name                = var.app_service_name
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_service_plan.service_plan.id

  site_config {
    always_on       = true
    linux_fx_version = var.linux_fx_version
  }

  app_settings = {
    WEBSITE_RUN_FROM_PACKAGE = "1"
    WEBSITE_VNET_ROUTE_ALL   = "1" # Enable vNet integration
  }
}

# Intégration de l'App Service avec le VNet
resource "azurerm_app_service_virtual_network_swift_connection" "example" {
  app_service_id = azurerm_app_service.app_service.id
  subnet_id      = module.vnet.app_service_subnet_id
}