variable "resource_group_name" {
  description = "The name of the Resource Group where the App Service will be deployed"
  type        = string
}

variable "location" {
  description = "The Azure region where the App Service will be deployed"
  type        = string
}

variable "app_service_name" {
  description = "The name of the App Service"
  type        = string
}

variable "service_plan_name" {
  description = "The name of the App Service Plan"
  type        = string
}

variable "linux_fx_version" {
  description = "Runtime stack for the App Service (e.g., NODE|14-lts)"
  type        = string
}

variable "service_app_subnet_id" {
  description = "The ID of the subnet to associate with the app service"
  type        = string
}