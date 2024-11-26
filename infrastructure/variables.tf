#####################################
########## RESOURCE GROUP ###########
#####################################

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
  default = "juniacloudcomputingprojectbgm2"
}

variable "location" {
  description = "The Azure location/region for the resources (e.g., France Central)."
  type        = string
  default = "francecentral"
}

#####################################
############## NETWORK ##############
#####################################

variable "vnet_name" {
  description = "The name of the virtual network (VNet)."
  type        = string
  default = "vnet-bgm"
}

variable "address_space" {
  description = "The address space for the virtual network."
  type        = list(string)
  default = [ "10.0.0.0/16" ]
}

variable "subnet_name" {
  description = "The name of the subnet for the virtual network."
  type        = string
  default = "subnet-bgm"
}

variable "subnet_address_prefixes" {
  description = "The address prefixes for the subnet."
  type        = list(string)
  default = [ "10.0.1.0/24" ]
}

#####################################
########### BLOB STORAGE ############
#####################################

variable "storage_account_name" {
  description = "The name of the storage account."
  type        = string
  default = "juniacloudstoragebgm"
}

variable "container_name" {
  description = "The name of the blob storage container."
  type        = string
  default = "api"
}

#####################################
############ POSTGRESQL #############
#####################################

variable "server_name" {
  description = "The name of the PostgreSQL server."
  type        = string
  default = "juniacloudcomputingserverbgm"
}

variable "admin_login" {
  description = "The admin login for the PostgreSQL server."
  type        = string
}

variable "admin_password" {
  description = "The admin password for the PostgreSQL server."
  type        = string
  sensitive   = true
}

variable "sku_name" {
  description = "The SKU of the PostgreSQL server."
  type        = string
  default = "B_Standard_B2ms"
}

variable "storage_mb" {
  description = "The storage size in MB for the PostgreSQL server."
  type        = number
  default = 32768
}

variable "database_name" {
  description = "The name of the initial database to create on the PostgreSQL server."
  type        = string
  default = "mydatabasebgm"
}

variable "name" {
  description = "The friendly name of the PostgreSQL Flexible Server."
  type        = string
  default = "psql-server-"
}

variable "postgresql_db_name" {
  description = "Your PostgreSQL database name"
  type        = string
  default = "juniapostgresqlbgm2"
}

#####################################
############ APP SERVICE ############
#####################################

variable "app_service_plan_name" {
  description = "The name of the App Service Plan."
  type        = string
  default = "juniacloudcomputingappserviceplanbgm"
}

variable "app_service_name" {
  description = "The name of the App Service."
  type        = string
  default = "juniacloudcomputingappservicebgm"
}

#####################################
########## MICROSOFT AZURE ##########
#####################################

variable "subscription_id" {
  description = "The Azure subscription ID where the resources will be deployed."
  type        = string
}

#####################################
############## DOCKER ###############
#####################################

variable "docker_registry_password" {
  description = "Docker password"
  type        = string
}

variable "docker_image" {
  description = "Image"
  type        = string
  default     = "ghcr.io/ximaere/junia-cloud_computing:latest"
}

variable "docker_registry_username" {
  description = "Docker username"
  type        = string
  default     = "Clem2nt"
}

variable "docker_registry_url" {
  description = "Docker url"
  type        = string
  default     = "https://ghcr.io"
}

/*variable "new_relic_license_key" {
  type        = string
  sensitive   = true
  description = "New Relic license key used by the app service container to publish logs & metrics."
}

variable "new_relic_app_name" {
  type        = string
  description = "Name of the application in New Relic."
  default = "log"
}*/