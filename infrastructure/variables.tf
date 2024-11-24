#####################################
########## MICROSOFT AZURE ##########
#####################################

# Your Azure Microsoft subscription id
variable "subscription_id" {
  description = "Your Azure subscription ID."
  type        = string
  sensitive   = true
}
# Azure location
variable "location" {
  description = "The Azure region to deploy resources in"
  type        = string
  default     = "francecentral"
}

#####################################
########## RESOURCE GROUP ###########
#####################################

# Resource Group name
variable "resource_group_name" {
  description = "The name of the Resource Group"
  type        = string
  default     = "juniacloudcomputingprojectbgm2" 
}

#####################################
########## APP SERVICE ##############
#####################################

# App Service name
variable "app_service_name" {
  description = "The name of the App Service"
  type        = string
  default     = "juniacloudcomputingappservicebgm2" 
}
variable "service_plan_name" {
  description = "The name of the App Service Plan"
  type        = string
  default     = "juniacloudcomputingappserviceplanbgm2" 
}
variable "linux_fx_version" {
  description = "Runtime stack for the App Service (e.g., NODE|14-lts)"
  type        = string
  default     = "NODE|14-lts"
}

#####################################
########## BLOB STORAGE #############
#####################################

# Storage Account
variable "storage_account_name" {
  description = "The name of the Storage Account"
  type        = string
  default     = "juniacloudstoragebgm2"
}

# Storage Container
variable "storage_container_name" {
  description = "The name of the Blob Storage Container"
  type        = string
  default     = "juniablobcontainerbgm2"
}

variable "container_access_type" {
  description = "Access type for the Blob Storage Container (private, blob, or container)"
  type        = string
  default     = "blob"
}