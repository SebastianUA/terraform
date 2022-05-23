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
# Azure databricks workspace
#-----------------------------------------------------------
variable "enable_databricks_workspace" {
  description = "Enable databricks workspace usage"
  default     = false
}

variable "databricks_workspace_name" {
  description = "Specifies the name of the Databricks Workspace resource. Changing this forces a new resource to be created."
  default     = ""
}

variable "databricks_workspace_resource_group_name" {
  description = "(Required) The name of the Resource Group in which the Databricks Workspace should exist. Changing this forces a new resource to be created."
  default     = null
}

variable "databricks_workspace_location" {
  description = "(Required) Specifies the supported Azure location where the resource has to be created. Changing this forces a new resource to be created."
  default     = null
}

variable "databricks_workspace_load_balancer_backend_address_pool_id" {
  description = "(Optional) Resource ID of the Outbound Load balancer Backend Address Pool for Secure Cluster Connectivity (No Public IP) workspace. Changing this forces a new resource to be created."
  default     = null
}

variable "databricks_workspace_sku" {
  description = "(Required) The sku to use for the Databricks Workspace. Possible values are standard, premium, or trial. Changing this can force a new resource to be created in some circumstances."
  default     = null
}

variable "databricks_workspace_managed_services_cmk_key_vault_key_id" {
  description = "(Optional) Customer managed encryption properties for the Databricks Workspace managed resources(e.g. Notebooks and Artifacts). Changing this forces a new resource to be created."
  default     = null
}

variable "databricks_workspace_managed_resource_group_name" {
  description = "(Optional) The name of the resource group where Azure should place the managed Databricks resources. Changing this forces a new resource to be created."
  default     = null
}

variable "databricks_workspace_customer_managed_key_enabled" {
  description = "(Optional) Is the workspace enabled for customer managed key encryption? If true this enables the Managed Identity for the managed storage account. Possible values are true or false. Defaults to false. This field is only valid if the Databricks Workspace sku is set to premium. Changing this forces a new resource to be created."
  default     = null
}

variable "databricks_workspace_infrastructure_encryption_enabled" {
  description = "Optional) Is the Databricks File System root file system enabled with a secondary layer of encryption with platform managed keys? Possible values are true or false. Defaults to false. This field is only valid if the Databricks Workspace sku is set to premium. Changing this forces a new resource to be created."
  default     = null
}

variable "databricks_workspace_public_network_access_enabled" {
  description = "(Optional) Allow public access for accessing workspace. Set value to false to access workspace only via private link endpoint. Possible values include true or false. Defaults to true. Changing this forces a new resource to be created."
  default     = null
}

variable "databricks_workspace_network_security_group_rules_required" {
  description = "(Optional) Does the data plane (clusters) to control plane communication happen over private link endpoint only or publicly? Possible values AllRules, NoAzureDatabricksRules or NoAzureServiceRules. Required when public_network_access_enabled is set to false. Changing this forces a new resource to be created."
  default     = null
}

variable "databricks_workspace_custom_parameters" {
  description = "(Optional) A custom_parameters block "
  default     = {}
}

variable "databricks_workspace_timeouts" {
  description = "Set timeouts for databricks workspace"
  default     = {}
}

#-----------------------------------------------------------
# Azure databricks workspace customer managed key
#-----------------------------------------------------------
variable "enable_databricks_workspace_customer_managed_key" {
  description = "Enable databricks workspace customer managed key usage"
  default     = false
}

variable "databricks_workspace_customer_managed_key_workspace_id" {
  description = "The ID of the Databricks workspace."
  default     = ""
}

variable "databricks_workspace_customer_managed_key_key_vault_key_id" {
  description = "(Required) The ID of the Key Vault."
  default     = null
}

variable "databricks_workspace_customer_managed_key_timeouts" {
  description = "Set timeouts for databricks workspace customer managed key"
  default     = {}
}