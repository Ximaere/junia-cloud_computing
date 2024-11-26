# Déploiement d'un serveur PostgreSQL flexible dans Azure
resource "azurerm_postgresql_flexible_server" "postgresql_server" {
  name                = var.name                           # Identifiant unique du serveur
  location            = var.location                       # Région Azure choisie
  resource_group_name = var.resource_group_name            # Groupe de ressources associé au serveur
  administrator_login = var.admin_login                    # Utilisateur principal pour l'administration
  administrator_password = var.admin_password              # Mot de passe de l'utilisateur administrateur
  sku_name            = var.sku_name                       # Type de configuration matérielle (SKU) du serveur (exemple : GP_Standard_D2s_v3)
  storage_mb          = var.storage_mb                     # Espace disque attribué en mégaoctets
  delegated_subnet_id = var.subnet_id                      # Référence au sous-réseau pour la connectivité privée
  private_dns_zone_id = var.private_dns_zone_id            # Zone DNS privée utilisée pour résoudre les noms
  version             = "13"                               # Version spécifique de PostgreSQL à installer

  public_network_access_enabled = false                    # Bloque l'accès au réseau public pour renforcer la sécurité
}

# Ajout d'une base de données PostgreSQL sur le serveur
resource "azurerm_postgresql_flexible_server_database" "postgresql_database" {
  name      = var.database_name                            # Nom attribué à la base
  server_id = azurerm_postgresql_flexible_server.postgresql_server.id # Référence au serveur cible
  charset   = "UTF8"                                       # Codage des caractères utilisé pour la base
  collation = "fr_FR.utf8"                                 # Règles de tri et comparaison en français UTF-8
}
