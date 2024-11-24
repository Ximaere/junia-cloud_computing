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
  source              = "./modules/app_service"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  app_service_name    = var.app_service_name
  service_plan_name   = var.service_plan_name
  linux_fx_version    = var.linux_fx_version
}

# Call the Blob Storage module
module "blob_storage" {
  source                 = "./modules/blob_storage"
  resource_group_name    = azurerm_resource_group.main.name
  location               = azurerm_resource_group.main.location
  storage_account_name   = var.storage_account_name
  storage_container_name = var.storage_container_name
  container_access_type  = var.container_access_type
}