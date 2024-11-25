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
  service_plan_name     = var.service_plan_name
  linux_fx_version      = var.linux_fx_version
}

# Call the Blob Storage module
module "blob_storage" {
  source                 = "./modules/blob_storage"
  resource_group_name    = azurerm_resource_group.main.name
  location               = azurerm_resource_group.main.location
  storage_account_name   = var.storage_account_name
  storage_container_name = var.storage_container_name
  container_access_type  = var.container_access_type
  blob_storage_subnet_id = module.vnet.blob_storage_subnet_id
}

module "postgresql_server" {
  source                 = "./modules/postgresql_server"
  resource_group_name    = azurerm_resource_group.example.name
  location               = azurerm_resource_group.example.location
  postgresql_server_name = var.postgresql_server_name
  administrator_login    = var.administrator_login
  administrator_password = var.administrator_password
  sku_name               = "Standard_D2s_v3"
  storage_mb             = 32768
  delegated_subnet_id    = "database-subnet"
  backup_retention_days  = 7
  allowed_ip_ranges      = ["10.0.1.0", "10.0.1.255"]
  tags                   = {
    environment = "dev"
    project     = "example-project"
  }
}

module "vnet" {
  source = "./modules/vnet"

  resource_group_name        = var.resource_group_name
  location                   = var.location
  vnet_name                  = "my-vnet"
  address_space              = ["10.0.0.0/16"]
  app_service_subnet_name    = "app-service-subnet"
  app_service_subnet_prefix  = "10.0.1.0/24"
  blob_storage_subnet_name   = "blob-storage-subnet"
  blob_storage_subnet_prefix = "10.0.2.0/24"
  database_subnet_name       = "database-subnet"
  database_subnet_prefix     = "10.0.3.0/24" 
}