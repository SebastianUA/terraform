#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "this"
}

variable "environment" {
  description = "Environment for service"
  default     = "test"
}

variable "tags" {
  description = "Add additional tags"
  default     = {}
}

#-----------------------------------------------------------
# Azure mysql active directory administrator
#-----------------------------------------------------------
variable "enable_mysql_active_directory_administrator" {
  description = "Enable mysql active directory administrator usage"
  default     = false
}

variable "mysql_active_directory_administrator_server_name" {
  description = "The name of the MySQL Server on which to set the administrator. Changing this forces a new resource to be created."
  default     = null
}

variable "mysql_active_directory_administrator_resource_group_name" {
  description = "(Required) The name of the resource group for the MySQL server. Changing this forces a new resource to be created."
  default     = null
}

variable "mysql_active_directory_administrator_login" {
  description = "(Required) The login name of the principal to set as the server administrator"
  default     = null
}

variable "mysql_active_directory_administrator_object_id" {
  description = "(Required) The ID of the principal to set as the server administrator. For a managed identity this should be the Client ID of the identity."
  default     = null
}

variable "mysql_active_directory_administrator_tenant_id" {
  description = "(Required) The Azure Tenant ID"
  default     = null
}

variable "mysql_active_directory_administrator_timeouts" {
  description = "Set timeouts for mysql active directory administrator"
  default     = {}
}

#-----------------------------------------------------------
# Azure mysql configuration
#-----------------------------------------------------------
variable "enable_mysql_configuration" {
  description = "Enable mysql configuration usage"
  default     = false
}

variable "mysql_configuration_name" {
  description = "Specifies the name of the MySQL Configuration, which needs to be a valid MySQL configuration name. Changing this forces a new resource to be created."
  default     = ""
}

variable "mysql_configuration_server_name" {
  description = "Specifies the name of the MySQL Server. Changing this forces a new resource to be created."
  default     = ""
}

variable "mysql_configuration_resource_group_name" {
  description = "(Required) The name of the resource group in which the MySQL Server exists. Changing this forces a new resource to be created."
  default     = null
}

variable "mysql_configuration_value" {
  description = "(Required) Specifies the value of the MySQL Configuration. See the MySQL documentation for valid values."
  default     = null
}

variable "mysql_configuration_timeouts" {
  description = "Set timeouts for mysql configuration"
  default     = {}
}

#
#
#
variable "AAAAAA" {
  description = "AAAAAA"
  default     = null
}

variable "AAAAAA" {
  description = "AAAAAA"
  default     = null
}

variable "AAAAAA" {
  description = "AAAAAA"
  default     = null
}

variable "AAAAAA" {
  description = "AAAAAA"
  default     = null
}

variable "AAAAAA" {
  description = "AAAAAA"
  default     = null
}

variable "AAAAAA" {
  description = "AAAAAA"
  default     = null
}

variable "AAAAAA" {
  description = "AAAAAA"
  default     = null
}

variable "AAAAAA" {
  description = "AAAAAA"
  default     = null
}

variable "AAAAAA" {
  description = "AAAAAA"
  default     = null
}

variable "AAAAAA" {
  description = "AAAAAA"
  default     = null
}

variable "AAAAAA" {
  description = "AAAAAA"
  default     = null
}

variable "AAAAAA" {
  description = "AAAAAA"
  default     = null
}

variable "AAAAAA" {
  description = "AAAAAA"
  default     = null
}

variable "AAAAAA" {
  description = "AAAAAA"
  default     = null
}

variable "AAAAAA" {
  description = "AAAAAA"
  default     = null
}

variable "AAAAAA" {
  description = "AAAAAA"
  default     = null
}

variable "AAAAAA" {
  description = "AAAAAA"
  default     = null
}