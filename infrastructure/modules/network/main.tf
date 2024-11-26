# Création d'un réseau virtuel (VNet) pour l'infrastructure Azure
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name                      # Identifiant du réseau virtuel
  resource_group_name = var.resource_group_name            # Groupe de ressources Azure cible
  location            = var.location                       # Région géographique où sera créé le VNet
  address_space       = var.address_space                  # Plage d'adresses IP attribuées au VNet (exemple : "10.0.0.0/16")
}

# Configuration d'un sous-réseau réservé pour les App Services
resource "azurerm_subnet" "app_service_subnet" {
  name                 = "subnet-app-service"              # Nom donné au sous-réseau
  resource_group_name  = var.resource_group_name           # Groupe de ressources associé au sous-réseau
  virtual_network_name = azurerm_virtual_network.vnet.name # Référence au réseau virtuel parent
  address_prefixes     = ["10.0.2.0/24"]                   # Plage d'adresses IP allouée au sous-réseau

  # Délégation pour autoriser les App Services à utiliser ce sous-réseau
  delegation {
    name = "delegation"                                    # Identifiant de la délégation
    service_delegation {
      name = "Microsoft.Web/serverFarms"                  # Type de service ciblé (App Service Plan)
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/action" # Opérations autorisées
      ]
    }
  }
}

# Création d'un sous-réseau pour les bases de données PostgreSQL flexibles
resource "azurerm_subnet" "postgresql_subnet" {
  name                 = "subnet-postgresql"               # Identifiant pour le sous-réseau
  resource_group_name  = var.resource_group_name           # Groupe de ressources contenant ce sous-réseau
  virtual_network_name = azurerm_virtual_network.vnet.name # Référence au réseau virtuel parent
  address_prefixes     = ["10.0.3.0/24"]                   # Plage d'adresses IP réservée

  # Configuration pour permettre l'intégration PostgreSQL flexible
  delegation {
    name = "delegation"                                    # Nom attribué à la délégation
    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"   # Service configuré pour utiliser ce sous-réseau
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/action" # Liste des actions permises
      ]
    }
  }
}

# Définition d'une zone DNS privée dédiée à PostgreSQL
resource "azurerm_private_dns_zone" "postgresql_dns_zone" {
  name                = "privatelink.postgres.database.azure.com" # Adresse DNS privée pour PostgreSQL
  resource_group_name = var.resource_group_name            # Référence au groupe de ressources cible
}

# Lien entre le réseau virtuel et la zone DNS privée
resource "azurerm_private_dns_zone_virtual_network_link" "postgresql_dns_link" {
  name                  = "vnet-link"                      # Nom de la connexion
  resource_group_name   = var.resource_group_name          # Groupe de ressources pour la liaison
  private_dns_zone_name = azurerm_private_dns_zone.postgresql_dns_zone.name # Zone DNS à relier
  virtual_network_id    = azurerm_virtual_network.vnet.id  # Référence au réseau virtuel à connecter
}
