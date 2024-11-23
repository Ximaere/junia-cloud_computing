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
  default     = "juniacloudcomputingprojectbgm" 
}

#####################################
########## APP SERVICE ##############
#####################################

# App Service name
variable "app_service_name" {
  description = "The name of the App Service"
  type        = string
  default     = "juniacloudcomputingappservicebgm" 
}
variable "service_plan_name" {
  description = "The name of the App Service Plan"
  type        = string
  default     = "juniacloudcomputingappserviceplanbgm" 
}
variable "linux_fx_version" {
  description = "Runtime stack for the App Service (e.g., NODE|14-lts)"
  type        = string
  default     = "NODE|14-lts"
}
