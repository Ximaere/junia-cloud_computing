resource "azurerm_postgresql_flexible_server" "postgresql_server" {
  name                   = var.postgresql_server_name
  location               = var.location
  resource_group_name    = var.resource_group_name
  administrator_login    = var.administrator_login
  administrator_password = var.administrator_password
  version                = "16"
  private_dns_zone_id = azurerm_private_dns_zone.postgresql_dns_zone.id

  public_network_access_enabled = false

  sku_name = var.sku_name

  storage_mb            = var.storage_mb
  delegated_subnet_id   = var.delegated_subnet_id
  backup_retention_days = var.backup_retention_days

  tags = var.tags
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "postgresql_firewall" {
  count                    = length(var.allowed_ip_ranges)
  name                     = "allow-ip-${count.index}"
  server_id                = azurerm_postgresql_flexible_server.postgresql_server.id
  start_ip_address         = var.allowed_ip_ranges[count.index]
  end_ip_address           = var.allowed_ip_ranges[count.index]
}

resource "azurerm_private_dns_zone" "postgresql_dns_zone" {
  name                = "privatelink.postgres.database.azure.com"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "vnet_link" {
  name                  = "postgresql-vnet-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.postgresql_dns_zone.name
  virtual_network_id    = var.virtual_network_id
}

resource "azurerm_private_endpoint" "database_endpoint" {
  name                = "database-private-endpoint"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.database_subnet_id

  private_service_connection {
    name                           = "database-connection"
    private_connection_resource_id = var.storage_account_id
    subresource_names              = ["database"]
    is_manual_connection = false
  }
}