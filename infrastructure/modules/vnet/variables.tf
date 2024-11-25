variable "resource_group_name" {
  description = "The name of the Resource Group where the VNet will be deployed"
  type        = string
}

variable "location" {
  description = "The Azure region where the VNet will be deployed"
  type        = string
}

variable "vnet_name" {
  description = "The name of the Virtual Network"
  type        = string
}

variable "address_space" {
  description = "The address space for the Virtual Network"
  type        = list(string)
}

variable "app_service_subnet_name" {
  description = "The name of the subnet for the App Service"
  type        = string
}

variable "app_service_subnet_prefix" {
  description = "The address prefix for the App Service subnet"
  type        = string
}

variable "blob_storage_subnet_name" {
  description = "The name of the subnet for the Blob Storage"
  type        = string
}

variable "blob_storage_subnet_prefix" {
  description = "The address prefix for the Blob Storage subnet"
  type        = string
}

variable "database_subnet_name" {
  description = "The name of the subnet for the Blob Storage"
  type        = string
}

variable "database_subnet_prefix" {
  description = "The address prefix for the Blob Storage subnet"
  type        = string
}