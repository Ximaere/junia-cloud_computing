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
  service_app_subnet_id = module.vnet.app_service_subnet_id
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
  resource_group_name    = azurerm_resource_group.main.name
  location               = azurerm_resource_group.main.location
  storage_account_id     = azurerm_storage_account.storage_account.id
  postgresql_server_name = var.postgresql_server_name
  administrator_login    = var.administrator_login
  administrator_password = var.administrator_password
  sku_name               = "B_Standard_B2ms"
  storage_mb             = 32768
  virtual_network_id     = module.vnet.vnet_id
  database_subnet_id     = module.vnet.database_subnet_id
  delegated_subnet_id    = "/subscriptions/{subscription-id}/resourceGroups/{resource-group-name}/providers/Microsoft.Network/virtualNetworks/{vnet-name}/subnets/{subnet-name}"
  backup_retention_days  = 7
  allowed_ip_ranges      = ["10.0.1.0", "10.0.1.255"]
  tags                   = {
    environment = "dev"
    project     = "example-project"
  }
}

resource "azurerm_storage_account" "storage_account" {
  name                     = "juniastorageaccountbgm2"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

module "vnet" {
  source = "./modules/vnet"

  resource_group_name        = var.resource_group_name
  location                   = var.location
  vnet_name                  = "juniacloudcomputingvnetbgm2"
  address_space              = ["10.0.0.0/16"]
  app_service_subnet_name    = "app-service-subnet"
  app_service_subnet_prefix  = "10.0.1.0/24"
  blob_storage_subnet_name   = "blob-storage-subnet"
  blob_storage_subnet_prefix = "10.0.2.0/24"
  database_subnet_name       = "database-subnet"
  database_subnet_prefix     = "10.0.3.0/24" 
}