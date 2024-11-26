Dépôt github écrit par Barea-Fernandez Enzo, Gorse Clément et Muanza Noé

# **Infrastructure Terraform**

Ce dossier contient l'infrastructure Terraform permettant de déployer une application sur Azure. Le projet utilise plusieurs modules pour organiser les différentes parties de l'infrastructure et faciliter leur gestion. Voici une description détaillée du contenu du dossier.

## **Structure du dossier**

## Modules

app_service/ : Déploie une App Service Plan et un App Service Linux, avec la configuration pour exécuter une application Docker et intégrer des services comme le stockage Azure Blob et les VNet.
blob_storage/ : Crée un compte de stockage Azure, des conteneurs Blob, et configure les permissions nécessaires.
postgresql_server/ : Configure un serveur PostgreSQL dans Azure, y compris les paramètres de réseau privé (Private Endpoint).
network/ : Crée un Virtual Network (VNet) avec des sous-réseaux dédiés pour les services (App Service, stockage, base de données).

## Fichiers principaux##

main.tf : Définit les appels aux modules et les ressources globales nécessaires (par exemple, le groupe de ressources Azure).
variables.tf : Liste les variables nécessaires au déploiement de l'infrastructure. Ces variables doivent être définies dans un fichier terraform.tfvars ou passées en ligne de commande.
outputs.tf : Définit les sorties Terraform pour partager des informations essentielles, comme les identifiants de ressources créées.

## **Mise en commentaire de la partie New Relic**

La configuration initiale prévoyait l'intégration de New Relic pour la supervision et le monitoring de l'application. Cependant, cette partie a été mise en commentaire dans les fichiers Terraform, car elle ne fonctionne pas dans l'état actuel.