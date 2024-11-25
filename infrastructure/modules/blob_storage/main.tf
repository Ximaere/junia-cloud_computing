# Create the Storage Account
resource "azurerm_storage_account" "storage_account" {
  name                     = var.storage_account_name
  location                 = var.location
  resource_group_name      = var.resource_group_name
  account_tier             = "Standard"
  account_replication_type = "LRS" # Local Redundancy
}

# Create a Blob Storage Container
resource "azurerm_storage_container" "storage_container" {
  name                  = "api"
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = var.container_access_type
}

# Upload the JSON file to the Blob Container
resource "azurerm_storage_blob" "quotes_blob" {
  name                   = "quotes.json"
  source                 = "${path.module}/quotes.json"
  storage_account_name   = azurerm_storage_account.storage_account.name
  storage_container_name = azurerm_storage_container.storage_container.name
  type                   = "Block"
}

resource "azurerm_private_endpoint" "blob_endpoint" {
  name                = "blob-private-endpoint"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = module.vnet.blob_storage_subnet_id

  private_service_connection {
    name                           = "blob-connection"
    private_connection_resource_id = azurerm_storage_account.storage_account.id
    subresource_names              = ["blob"]
    is_manual_connection = false
  }
}
