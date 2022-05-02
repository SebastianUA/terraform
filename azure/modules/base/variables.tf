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
# Azure resource group
#-----------------------------------------------------------
variable "enable_resource_group" {
  description = "Enable resource group usage"
  default     = false
}

variable "resource_group_name" {
  description = "The Name which should be used for this Resource Group. Changing this forces a new Resource Group to be created."
  default     = ""
}

variable "resource_group_location" {
  description = "(Required) The Azure Region where the Resource Group should exist. Changing this forces a new Resource Group to be created."
  default     = null
}

variable "resource_group_timeouts" {
  description = "Set timeouts for resource group"
  default     = {}
}

#-----------------------------------------------------------
# Azure resource provider registration
#-----------------------------------------------------------
variable "enable_resource_provider_registration" {
  description = "Enable resource provider registration usage"
  default     = false
}

variable "resource_provider_registration_name" {
  description = "(Required) The namespace of the Resource Provider which should be registered. Changing this forces a new resource to be created."
  default     = null
}

variable "resource_provider_registration_feature" {
  description = "(Optional) A list of feature blocks"
  default     = []
}

variable "resource_provider_registration_timeouts" {
  description = "Set timeouts for resource provider registration"
  default     = {}
}

#-----------------------------------------------------------
# Azure subscription
#-----------------------------------------------------------
variable "enable_subscription" {
  description = "Enable subscription usage"
  default     = false
}

variable "subscription_name" {
  description = "The Name of the Subscription. This is the Display Name in the portal."
  default     = ""
}

variable "subscription_alias" {
  description = "(Optional) The Alias name for the subscription. Terraform will generate a new GUID if this is not supplied. Changing this forces a new Subscription to be created."
  default     = null
}

variable "subscription_billing_scope_id" {
  description = "(Optional) The Azure Billing Scope ID. Can be a Microsoft Customer Account Billing Scope ID, a Microsoft Partner Account Billing Scope ID or an Enrollment Billing Scope ID."
  default     = null
}

variable "subscription_id" {
  description = "(Optional) The ID of the Subscription. Changing this forces a new Subscription to be created."
  default     = null
}

variable "subscription_workload" {
  description = "(Optional) The workload type of the Subscription. Possible values are Production (default) and DevTest. Changing this forces a new Subscription to be created."
  default     = null
}

variable "subscription_timeouts" {
  description = "Set timeouts for resource provider registration"
  default     = {}
}