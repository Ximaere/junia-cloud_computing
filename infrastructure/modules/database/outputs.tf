output "postgresql_server_id" {
  description = "ID of the PostgreSQL flexible server"
  value       = azurerm_postgresql_flexible_server.postgresql_server.id
}

output "postgresql_server_fqdn" {
  description = "Fully qualified domain name (FQDN) of the PostgreSQL server"
  value       = azurerm_postgresql_flexible_server.postgresql_server.fqdn
}

output "postgresql_server_administrator_login" {
  description = "Administrator login name of the PostgreSQL server"
  value       = azurerm_postgresql_flexible_server.postgresql_server.administrator_login
}
