# Définition d'un compte de stockage Azure
resource "azurerm_storage_account" "storage_account" {
  resource_group_name      = var.resource_group_name         # Groupe de ressources dans lequel il est créé
  name                     = var.storage_account_name        # Identifiant unique du compte
  account_kind             = "StorageV2"                    # Type de compte pour un usage général
  account_tier             = "Standard"                     # Niveau de service choisi
  account_replication_type = "LRS"                          # Mode de réplication : stockage localement redondant
  location                 = var.location                    # Région géographique
}

# Ajout d'un conteneur dans le compte de stockage
resource "azurerm_storage_container" "storage_container" {
  name                  = var.container_name                # Identifiant du conteneur
  storage_account_name  = azurerm_storage_account.storage_account.name # Référence au compte de stockage
  container_access_type = "private"                         # Niveau d'accès : privé uniquement
}

# Téléchargement d'un fichier JSON dans le conteneur
resource "azurerm_storage_blob" "json_blob" {
  name                   = "quotes.json"                    # Nom du fichier blob dans Azure
  storage_account_name   = azurerm_storage_account.storage_account.name # Lien avec le compte de stockage
  storage_container_name = azurerm_storage_container.storage_container.name # Lien avec le conteneur
  type                   = "Block"                          # Catégorie du blob (Block blob pour fichiers classiques)
  source                 = "./modules/blob_storage/quotes.json"          # Chemin source vers le fichier local
}
