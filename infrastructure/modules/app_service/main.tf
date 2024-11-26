# Création du plan App Service nécessaire à l'application
resource "azurerm_service_plan" "app_service_plan" {
  name                = var.app_service_plan_name        # Identifiant unique du plan
  resource_group_name = var.resource_group_name          # Groupe de ressources dans Azure
  location            = var.location                     # Emplacement géographique
  os_type             = "Linux"                          # Système d'exploitation requis
  sku_name            = "B1"                             # Niveau tarifaire (Basic, petite taille)
}

# Déploiement d'une application web Linux liée au plan App Service
resource "azurerm_linux_web_app" "app_service" {
  name                = var.app_service_name             # Nom unique pour l'application
  location            = var.location                     # Région dans Azure
  resource_group_name = var.resource_group_name          # Ressources associées
  service_plan_id     = azurerm_service_plan.app_service_plan.id # Référence au plan App Service

  # Spécification de la configuration applicative
  site_config {
    application_stack {
      docker_registry_url      = var.docker_registry_url       # Registre contenant l'image
      docker_image_name        = var.docker_image             # Nom de l'image à utiliser
      docker_registry_password = var.docker_registry_password # Authentification du registre
      docker_registry_username = var.docker_registry_username # Nom d'utilisateur du registre
    }
  }

  # Définition des variables d'environnement nécessaires à l'application
  app_settings = {
    # Informations relatives à la base de données
    DATABASE_NAME     = var.database_name                   # Nom de la base utilisée
    DATABASE_HOST     = var.database_host                   # Adresse de l'hôte
    DATABASE_USER     = var.database_user                   # Utilisateur autorisé
    DATABASE_PASSWORD = var.database_password               # Mot de passe correspondant
    DATABASE_PORT     = var.database_port                   # Port d'accès

    /*# Intégration avec New Relic pour le monitoring
    NEW_RELIC_LICENSE_KEY = var.new_relic_license_key       # Licence New Relic
    NEW_RELIC_APP_NAME    = var.new_relic_app_name          # Nom pour le suivi*/

    # Lien avec le service de stockage Azure
    STORAGE_ACCOUNT_URL = var.storage_url                   # URL vers le stockage Azure
  }

  # Activation de l'identité assignée par le système pour gérer les accès
  identity {
    type = "SystemAssigned"                                # Type d'identité activée
  }
}

# Association de l'application à un sous-réseau via l'intégration VNet
resource "azurerm_app_service_virtual_network_swift_connection" "vnet_connection" {
  app_service_id = azurerm_linux_web_app.app_service.id    # Référence à l'application déployée
  subnet_id      = var.subnet_id                          # Identifiant du sous-réseau cible
}

# Gestion des permissions pour permettre l'accès au stockage Azure
resource "azurerm_role_assignment" "app_service_storage_access" {
  principal_id         = azurerm_linux_web_app.app_service.identity[0].principal_id # ID de l'identité gérée
  role_definition_name = "Storage Blob Data Contributor"  # Rôle assigné
  scope                = var.storage_account_id           # Cible du rôle
}
