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
# Azure management group
#-----------------------------------------------------------
variable "enable_management_group" {
  description = "Enable management group usage"
  default     = false
}

variable "management_group_name" {
  description = "The name or UUID for this Management Group, which needs to be unique across your tenant. A new UUID will be generated if not provided. Changing this forces a new resource to be created."
  default     = ""
}

variable "management_group_display_name" {
  description = "(Optional) A friendly name for this Management Group. If not specified, this will be the same as the name"
  default     = null
}

variable "management_group_parent_management_group_id" {
  description = "(Optional) The ID of the Parent Management Group. Changing this forces a new resource to be created."
  default     = null
}

variable "management_group_subscription_ids" {
  description = "(Optional) A list of Subscription GUIDs which should be assigned to the Management Group."
  default     = null
}

variable "management_group_timeouts" {
  description = "Set timeouts for management group"
  default     = {}
}

#-----------------------------------------------------------
# Azure management lock
#-----------------------------------------------------------
variable "enable_management_lock" {
  description = "Enable management lock usage"
  default     = false
}

variable "management_lock_name" {
  description = "Specifies the name of the Management Lock. Changing this forces a new resource to be created."
  default     = ""
}

variable "management_lock_scope" {
  description = "(Required) Specifies the scope at which the Management Lock should be created. Changing this forces a new resource to be created."
  default     = null
}

variable "management_lock_lock_level" {
  description = "(Required) Specifies the Level to be used for this Lock. Possible values are CanNotDelete and ReadOnly. Changing this forces a new resource to be created."
  default     = null
}

variable "management_lock_notes" {
  description = "(Optional) Specifies some notes about the lock. Maximum of 512 characters. Changing this forces a new resource to be created."
  default     = null
}

variable "management_lock_timeouts" {
  description = "Set timeouts management lock"
  default     = {}
}

#-----------------------------------------------------------
# Azure management group subscription association
#-----------------------------------------------------------
variable "enable_management_group_subscription_association" {
  description = "Enable management group subscription association usage"
  default     = false
}

variable "management_group_subscription_association_management_group_id" {
  description = "(Required) The ID of the Management Group to associate the Subscription with. Changing this forces a new Management to be created."
  default     = null
}

variable "management_group_subscription_association_subscription_id" {
  description = "(Required) The ID of the Subscription to be associated with the Management Group. Changing this forces a new Management to be created."
  default     = null
}

variable "management_group_subscription_association_timeouts" {
  description = "Set timeouts for management group subscription association"
  default     = {}
}