#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "this"
}

variable "environment" {
  description = "Environment for service"
  default     = "STAGE"
}

variable "tags" {
  description = "Add additional tags"
  default     = {}
}

#-----------------------------------------------------------
# Azure tenant template deployment
#-----------------------------------------------------------
variable "enable_tenant_template_deployment" {
  description = "Enable tenant template deployment usage"
  default     = false
}

variable "tenant_template_deployment_name" {
  description = "The name which should be used for this Template. Changing this forces a new Template to be created."
  default     = ""
}

variable "tenant_template_deployment_location" {
  description = "(Required) The Azure Region where the Template should exist. Changing this forces a new Template to be created."
  default     = null
}

variable "tenant_template_deployment_debug_level" {
  description = "(Optional) The Debug Level which should be used for this Resource Group Template Deployment. Possible values are none, requestContent, responseContent and requestContent, responseContent"
  default     = null
}

variable "tenant_template_deployment_parameters_content" {
  description = "(Optional) The contents of the ARM Template parameters file - containing a JSON list of parameters."
  default     = null
}

variable "tenant_template_deployment_template_content" {
  description = "(Optional) The contents of the ARM Template which should be deployed into this Resource Group. Cannot be specified with template_spec_version_id."
  default     = null
}

variable "tenant_template_deployment_template_spec_version_id" {
  description = "(Optional) The ID of the Template Spec Version to deploy. Cannot be specified with template_content"
  default     = null
}

variable "tenant_template_deployment_timeouts" {
  description = "Set timeouts for tenant template deployment"
  default     = {}
}

#-----------------------------------------------------------
# Azure template deployment
#-----------------------------------------------------------
variable "enable_template_deployment" {
  description = "Enable template deployment usage"
  default     = false
}

variable "template_deployment_name" {
  description = "Specifies the name of the template deployment. Changing this forces a new resource to be created."
  default     = ""
}

variable "template_deployment_resource_group_name" {
  description = "(Required) The name of the resource group in which to create the template deployment."
  default     = null
}

variable "template_deployment_deployment_mode" {
  description = "Required) Specifies the mode that is used to deploy resources. This value could be either Incremental or Complete. Note that you will almost always want this to be set to Incremental otherwise the deployment will destroy all infrastructure not specified within the template, and Terraform will not be aware of this."
  default     = null
}

variable "template_deployment_template_body" {
  description = "(Optional) Specifies the JSON definition for the template."
  default     = null
}

variable "template_deployment_parameters" {
  description = "(Optional) Specifies the name and value pairs that define the deployment parameters for the template."
  default     = null
}

variable "template_deployment_parameters_body" {
  description = "(Optional) Specifies a valid Azure JSON parameters file that define the deployment parameters. It can contain KeyVault references"
  default     = null
}

variable "template_deployment_timeouts" {
  description = "Set timeouts for template deployment"
  default     = {}
}

#-----------------------------------------------------------
# Azure subscription template deployment
#-----------------------------------------------------------

variable "enable_subscription_template_deployment" {
  description = "Enable subscription template deployment usage"
  default     = false
}

variable "subscription_template_deployment_name" {
  description = "The name which should be used for this Subscription Template Deployment. Changing this forces a new Subscription Template Deployment to be created."
  default     = ""
}

variable "subscription_template_deployment_location" {
  description = "(Required) The Azure Region where the Subscription Template Deployment should exist. Changing this forces a new Subscription Template Deployment to be created."
  default     = null
}

variable "subscription_template_deployment_debug_level" {
  description = "(Optional) The Debug Level which should be used for this Subscription Template Deployment. Possible values are none, requestContent, responseContent and requestContent, responseContent."
  default     = null
}

variable "subscription_template_deployment_template_content" {
  description = "(Optional) The contents of the ARM Template which should be deployed into this Subscription."
  default     = null
}

variable "subscription_template_deployment_template_spec_version_id" {
  description = "(Optional) The ID of the Template Spec Version to deploy into the Subscription. Cannot be specified with template_content"
  default     = null
}

variable "subscription_template_deployment_parameters_content" {
  description = "(Optional) The contents of the ARM Template parameters file - containing a JSON list of parameters."
  default     = null
}

variable "subscription_template_deployment_timeouts" {
  description = "Set timeouts for subscription template deployment"
  default     = {}
}

#-----------------------------------------------------------
# Azure resource group template deployment
#-----------------------------------------------------------
variable "enable_resource_group_template_deployment" {
  description = "Enable resource group template deployment usage"
  default     = false
}

variable "resource_group_template_deployment_name" {
  description = "The name which should be used for this Resource Group Template Deployment. Changing this forces a new Resource Group Template Deployment to be created."
  default     = ""
}

variable "resource_group_template_deployment_resource_group_name" {
  description = "(Required) The name of the Resource Group where the Resource Group Template Deployment should exist. Changing this forces a new Resource Group Template Deployment to be created."
  default     = null
}

variable "resource_group_template_deployment_deployment_mode" {
  description = "(Required) The Deployment Mode for this Resource Group Template Deployment. Possible values are Complete (where resources in the Resource Group not specified in the ARM Template will be destroyed) and Incremental (where resources are additive only)."
  default     = null
}

variable "resource_group_template_deployment_debug_level" {
  description = "(Optional) The Debug Level which should be used for this Resource Group Template Deployment. Possible values are none, requestContent, responseContent and requestContent, responseContent."
  default     = null
}

variable "resource_group_template_deployment_template_content" {
  description = "(Optional) The contents of the ARM Template which should be deployed into this Resource Group. Cannot be specified with template_spec_version_id."
  default     = null
}

variable "resource_group_template_deployment_template_spec_version_id" {
  description = "(Optional) The ID of the Template Spec Version to deploy. Cannot be specified with template_content."
  default     = null
}

variable "resource_group_template_deployment_parameters_content" {
  description = "(Optional) The contents of the ARM Template parameters file - containing a JSON list of parameters."
  default     = null
}

variable "resource_group_template_deployment_timeouts" {
  description = "Set timeouts for resource group template deployment"
  default     = {}
}

#-----------------------------------------------------------
# Azure management group template deployment
#-----------------------------------------------------------
variable "enable_management_group_template_deployment" {
  description = "Enable management group template deployment usage"
  default     = false
}

variable "management_group_template_deployment_name" {
  description = "The name which should be used for this Template Deployment. Changing this forces a new Template Deployment to be created."
  default     = ""
}

variable "management_group_template_deployment_management_group_id" {
  description = "(Required) The Name of the Management Group to apply the Deployment Template to."
  default     = null
}

variable "management_group_template_deployment_location" {
  description = "(Required) The Azure Region where the Template should exist. Changing this forces a new Template to be created."
  default     = null
}

variable "management_group_template_deployment_debug_level" {
  description = "(Optional) The Debug Level which should be used for this Resource Group Template Deployment. Possible values are none, requestContent, responseContent and requestContent, responseContent."
  default     = null
}

variable "management_group_template_deployment_parameters_content" {
  description = "(Optional) The contents of the ARM Template parameters file - containing a JSON list of parameters."
  default     = null
}

variable "management_group_template_deployment_template_content" {
  description = "(Optional) The contents of the ARM Template which should be deployed into this Resource Group. Cannot be specified with template_spec_version_id."
  default     = null
}

variable "management_group_template_deployment_template_spec_version_id" {
  description = "(Optional) The ID of the Template Spec Version to deploy. Cannot be specified with template_content"
  default     = null
}

variable "subscription_template_deployment_timeouts" {
  description = "Set timeouts for subscription template deployment"
  default     = {}
}