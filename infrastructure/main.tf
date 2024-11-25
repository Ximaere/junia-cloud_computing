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
}
module "postgresql" { # TODO MOVE THE VARS IN VARIABLES.TF AND HIDE THE IMPORTANT STUFF IN TERRAFORM.TFVARS => UPDATE TERRAFOMR.TFVARS.TMP
  source = "./modules/database"
  resource_group_name    = azurerm_resource_group.example.name
  location               = azurerm_resource_group.example.location
  postgresql_server_name = "example-postgresql"
  administrator_login    = "adminuser"
  administrator_password = "securepassword123!"
  sku_name               = "Standard_D2s_v3"
  storage_mb             = 32768
  version                = "13"
  delegated_subnet_id    = "subnet-id"
  backup_retention_days  = 7
  allowed_ip_ranges      = ["0.0.0.0", "192.168.1.1"]
  tags                   = {
    environment = "dev"
    project     = "example-project"
  }
}
