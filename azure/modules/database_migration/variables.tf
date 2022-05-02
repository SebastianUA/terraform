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
# Azure database migration service
#-----------------------------------------------------------
variable "enable_database_migration_service" {
  description = "Enable database migration service usage"
  default     = false
}

variable "database_migration_service_name" {
  description = "Specify the name of the database migration service. Changing this forces a new resource to be created."
  default     = ""
}

variable "database_migration_service_location" {
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  default     = null
}

variable "database_migration_service_resource_group_name" {
  description = "(Required) Name of the resource group in which to create the database migration service. Changing this forces a new resource to be created."
  default     = null
}

variable "database_migration_service_subnet_id" {
  description = "(Required) The ID of the virtual subnet resource to which the database migration service should be joined. Changing this forces a new resource to be created."
  default     = null
}

variable "database_migration_service_sku_name" {
  description = "(Required) The SKU name of the database migration service. Possible values are Premium_4vCores, Standard_1vCores, Standard_2vCores and Standard_4vCores. Changing this forces a new resource to be created."
  default     = null
}

variable "database_migration_service_timeouts" {
  description = "Set timeouts for database migration service"
  default     = {}
}

#-----------------------------------------------------------
# Azure database migration project
#-----------------------------------------------------------
variable "enable_database_migration_project" {
  description = "Enable database migration project usage"
  default     = false
}

variable "database_migration_project_name" {
  description = "Specify the name of the database migration project. Changing this forces a new resource to be created."
  default     = ""
}

variable "database_migration_project_service_name" {
  description = "Name of the database migration service where resource belongs to. Changing this forces a new resource to be created."
  default     = ""
}

variable "database_migration_project_resource_group_name" {
  description = "(Required) Name of the resource group in which to create the database migration project. Changing this forces a new resource to be created."
  default     = null
}

variable "database_migration_project_location" {
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  default     = null
}

variable "database_migration_project_source_platform" {
  description = "(Required) The platform type of the migration source. Currently only support: SQL(on-premises SQL Server). Changing this forces a new resource to be created."
  default     = null
}

variable "database_migration_project_target_platform" {
  description = "(Required) The platform type of the migration target. Currently only support: SQLDB(Azure SQL Database). Changing this forces a new resource to be created."
  default     = null
}

variable "database_migration_project_timeouts" {
  description = "Set timeouts for database migration project"
  default     = {}
}