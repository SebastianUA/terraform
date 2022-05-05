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
# Azure active directory domain service
#-----------------------------------------------------------
variable "enable_active_directory_domain_service" {
  description = "Enable active directory domain service usage"
  default     = false
}

variable "active_directory_domain_service_name" {
  description = "The display name for your managed Active Directory Domain Service resource. Changing this forces a new resource to be created."
  default     = ""
}

variable "active_directory_domain_service_location" {
  description = "(Required) The Azure location where the Domain Service exists. Changing this forces a new resource to be created."
  default     = null
}

variable "active_directory_domain_service_resource_group_name" {
  description = "(Required) The name of the Resource Group in which the Domain Service should exist. Changing this forces a new resource to be created."
  default     = null
}

variable "active_directory_domain_service_sku" {
  description = "(Required) The SKU to use when provisioning the Domain Service resource. One of Standard, Enterprise or Premium"
  default     = null
}

variable "active_directory_domain_service_domain_name" {
  description = "(Required) The Active Directory domain to use. See official documentation for constraints and recommendations."
  default     = null
}

variable "active_directory_domain_service_filtered_sync_enabled" {
  description = "Whether to enable group-based filtered sync (also called scoped synchronisation). Defaults to false"
  default     = null
}

variable "active_directory_domain_service_secure_ldap" {
  description = "(Optional) A secure_ldap block"
  default     = []
}

variable "active_directory_domain_service_initial_replica_set" {
  description = "(Required) An initial_replica_set block. The initial replica set inherits the same location as the Domain Service resource."
  default     = []
}

variable "user_assigned_identity_notifications" {
  description = "(Optional) A notifications block"
  default     = []
}

variable "user_assigned_identity_security" {
  description = "(Optional) A security block"
  default     = {}
}

variable "user_assigned_identity_timeouts" {
  description = "Set timeouts for user assigned identity"
  default     = {}
}

#-----------------------------------------------------------
# Azure active directory domain service replica set
#-----------------------------------------------------------
variable "enable_active_directory_domain_service_replica_set" {
  description = "Enable active directory domain service replica set usage"
  default     = false
}

variable "active_directory_domain_service_replica_set_domain_service_id" {
  description = "The ID of the Domain Service for which to create this Replica Set. Changing this forces a new resource to be created."
  default     = ""
}

variable "active_directory_domain_service_replica_set_location" {
  description = "(Required) The Azure location where this Replica Set should exist. Changing this forces a new resource to be created."
  default     = null
}

variable "active_directory_domain_service_replica_set_subnet_id" {
  description = "(Required) The ID of the subnet in which to place this Replica Set."
  default     = null
}

variable "active_directory_domain_service_replica_set_timeouts" {
  description = "Set timeouts active directory domain service replica set"
  default     = {}
}
