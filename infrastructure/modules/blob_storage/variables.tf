variable "resource_group_name" {
  description = "The name of the Resource Group where the Storage Account will be deployed"
  type        = string
}

variable "location" {
  description = "The Azure region where the Storage Account will be deployed"
  type        = string
}

variable "storage_account_name" {
  description = "The name of the Storage Account"
  type        = string
}

variable "storage_container_name" {
  description = "The name of the Blob Storage Container"
  type        = string
}

variable "container_access_type" {
  description = "Access type for the Blob Storage Container (private, blob, or container)"
  type        = string
  default     = "blob"
}
