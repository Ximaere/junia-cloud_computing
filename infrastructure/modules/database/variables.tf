variable "resource_group_name" {
  description = "Name of the resource group in which to create the PostgreSQL server"
  type        = string
}

variable "location" {
  description = "Azure region where the PostgreSQL server will be created"
  type        = string
}

variable "postgresql_server_name" {
  description = "Name of the PostgreSQL flexible server"
  type        = string
}

variable "administrator_login" {
  description = "Administrator login name for the PostgreSQL server"
  type        = string
}

variable "administrator_password" {
  description = "Administrator password for the PostgreSQL server"
  type        = string
  sensitive   = true
}

variable "sku_name" {
  description = "The SKU name of the PostgreSQL server (e.g., 'Standard_D2s_v3')"
  type        = string
}

variable "storage_mb" {
  description = "The maximum storage allowed for the PostgreSQL server (in MB)"
  type        = number
}

variable "version" {
  description = "PostgreSQL version (e.g., '13')"
  type        = string
}

variable "delegated_subnet_id" {
  description = "ID of the delegated subnet for the PostgreSQL server"
  type        = string
}

variable "backup_retention_days" {
  description = "Number of days to retain backups"
  type        = number
  default     = 7
}

variable "allowed_ip_ranges" {
  description = "List of allowed IP ranges for PostgreSQL firewall rules"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags to associate with the PostgreSQL server"
  type        = map(string)
  default     = {}
}
