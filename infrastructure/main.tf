provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

# Create the Resource Group
resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

# Call the App Service module
module "app_service" {
  source                = "./modules/app_service"
  resource_group_name   = azurerm_resource_group.main.name
  location              = azurerm_resource_group.main.location
  app_service_name      = var.app_service_name
  service_plan_name = var.service_plan_name
  linux_fx_version      = var.linux_fx_version
}
