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

#-----------------------------------------------------------
# Azure policy definition
#-----------------------------------------------------------
variable "enable_policy_definition" {
  description = "Enable policy definition usage"
  default     = false
}

variable "policy_definition_name" {
  description = "The name of the policy definition. Changing this forces a new resource to be created."
  default     = ""
}

variable "policy_definition_policy_type" {
  description = "(Required) The policy type. Possible values are BuiltIn, Custom and NotSpecified. Changing this forces a new resource to be created."
  default     = null
}

variable "policy_definition_mode" {
  description = "(Required) The policy mode that allows you to specify which resource types will be evaluated. Possible values are All, Indexed, Microsoft.ContainerService.Data, Microsoft.CustomerLockbox.Data, Microsoft.DataCatalog.Data, Microsoft.KeyVault.Data, Microsoft.Kubernetes.Data, Microsoft.MachineLearningServices.Data, Microsoft.Network.Data and Microsoft.Synapse.Data."
  default     = null
}

variable "policy_definition_display_name" {
  description = "(Required) The display name of the policy definition."
  default     = null
}

variable "policy_definition_description" {
  description = "(Optional) The description of the policy definition."
  default     = null
}

variable "policy_definition_management_group_id" {
  description = "(Optional) The name of the Management Group where this policy should be defined. Changing this forces a new resource to be created."
  default     = null
}

variable "policy_definition_policy_rule" {
  description = "(Optional) The policy rule for the policy definition. This is a JSON string representing the rule that contains an if and a then block."
  default     = null
}

variable "policy_definition_metadata" {
  description = "(Optional) The metadata for the policy definition. This is a JSON string representing additional metadata that should be stored with the policy definition."
  default     = null
}

variable "policy_definition_parameters" {
  description = "(Optional) Parameters for the policy definition. This field is a JSON string that allows you to parameterize your policy definition."
  default     = null
}

variable "policy_definition_timeouts" {
  description = "Set timeouts for policy definition"
  default     = {}
}

#-----------------------------------------------------------
# Azure management group policy assignment
#-----------------------------------------------------------
variable "enable_management_group_policy_assignment" {
  description = "Enable management group policy assignment usage"
  default     = false
}

variable "management_group_policy_assignment_name" {
  description = "The name which should be used for this Policy Assignment. Changing this forces a new Policy Assignment to be created."
  default     = ""
}

variable "management_group_policy_assignment_policy_definition_id" {
  description = "The ID of the Policy Definition or Policy Definition Set. Changing this forces a new Policy Assignment to be created."
  default     = null
}

variable "management_group_policy_assignment_management_group_id" {
  description = "(Required) The ID of the Management Group. Changing this forces a new Policy Assignment to be created."
  default     = null
}

variable "management_group_policy_assignment_description" {
  description = "(Optional) A description which should be used for this Policy Assignment."
  default     = null
}

variable "management_group_policy_assignment_display_name" {
  description = "(Optional) The Display Name for this Policy Assignment."
  default     = null
}

variable "management_group_policy_assignment_enforce" {
  description = "(Optional) Specifies if this Policy should be enforced or not?"
  default     = null
}

variable "management_group_policy_assignment_location" {
  description = "(Optional) The Azure Region where the Policy Assignment should exist. Changing this forces a new Policy Assignment to be created."
  default     = null
}

variable "management_group_policy_assignment_metadata" {
  description = "(Optional) A JSON mapping of any Metadata for this Policy."
  default     = null
}

variable "management_group_policy_assignment_not_scopes" {
  description = "(Optional) Specifies a list of Resource Scopes (for example a Subscription, or a Resource Group) within this Management Group which are excluded from this Policy."
  default     = null
}

variable "management_group_policy_assignment_parameters" {
  description = "(Optional) A JSON mapping of any Parameters for this Policy."
  default     = null
}

variable "management_group_policy_assignment_identity" {
  description = "(Optional) An identity block"
  default     = {}
}

variable "management_group_policy_assignment_non_compliance_message" {
  description = " (Optional) One or more non_compliance_message blocks"
  default     = []
}

variable "management_group_policy_assignment_timeouts" {
  description = "Set timeouts for management group policy assignment"
  default     = {}
}

#-----------------------------------------------------------
# Azure subscription policy assignment
#-----------------------------------------------------------
variable "enable_subscription_policy_assignment" {
  description = "Enable subscription policy assignment usage"
  default     = false
}

variable "subscription_policy_assignment_name" {
  description = "The name which should be used for this Policy Assignment. Changing this forces a new Policy Assignment to be created."
  default     = ""
}

variable "subscription_policy_assignment_policy_definition_id" {
  description = "The ID of the Policy Definition or Policy Definition Set. Changing this forces a new Policy Assignment to be created."
  default     = ""
}

variable "subscription_policy_assignment_subscription_id" {
  description = "(Required) The ID of the Subscription where this Policy Assignment should be created. Changing this forces a new Policy Assignment to be created."
  default     = null
}

variable "subscription_policy_assignment_description" {
  description = "(Optional) A description which should be used for this Policy Assignment."
  default     = null
}

variable "subscription_policy_assignment_display_name" {
  description = "(Optional) The Display Name for this Policy Assignment."
  default     = null
}

variable "subscription_policy_assignment_enforce" {
  description = "(Optional) Specifies if this Policy should be enforced or not?"
  default     = null
}

variable "subscription_policy_assignment_location" {
  description = "(Optional) The Azure Region where the Policy Assignment should exist. Changing this forces a new Policy Assignment to be created."
  default     = null
}

variable "subscription_policy_assignment_metadata" {
  description = "(Optional) A JSON mapping of any Metadata for this Policy."
  default     = null
}

variable "subscription_policy_assignment_not_scopes" {
  description = "(Optional) Specifies a list of Resource Scopes (for example a Subscription, or a Resource Group) within this Management Group which are excluded from this Policy."
  default     = null
}

variable "subscription_policy_assignment_parameters" {
  description = "(Optional) A JSON mapping of any Parameters for this Policy."
  default     = null
}

variable "subscription_policy_assignment_identity" {
  description = "(Optional) An identity block"
  default     = {}
}

variable "subscription_policy_assignment_non_compliance_message" {
  description = "(Optional) One or more non_compliance_message blocks"
  default     = []
}

variable "subscription_policy_assignment_timeouts" {
  description = "Set timeouts for subscription policy assignment"
  default     = {}
}

#-----------------------------------------------------------
# Azure resource policy assignment
#-----------------------------------------------------------
variable "enable_resource_policy_assignment" {
  description = "Enable resource policy assignment usage"
  default     = false
}

variable "resource_policy_assignment_name" {
  description = "The name which should be used for this Policy Assignment. Changing this forces a new Resource Policy Assignment to be created."
  default     = ""
}

variable "resource_policy_assignment_resource_id" {
  description = "(Required) The ID of the Resource (or Resource Scope) where this should be applied. Changing this forces a new Resource Policy Assignment to be created."
  default     = null
}

variable "resource_policy_assignment_policy_definition_id" {
  description = "The ID of the Policy Definition or Policy Definition Set. Changing this forces a new Policy Assignment to be created."
  default     = ""
}

variable "resource_policy_assignment_description" {
  description = "(Optional) A description which should be used for this Policy Assignment."
  default     = null
}

variable "resource_policy_assignment_display_name" {
  description = "(Optional) The Display Name for this Policy Assignment."
  default     = null
}

variable "resource_policy_assignment_enforce" {
  description = "(Optional) Specifies if this Policy should be enforced or not?"
  default     = null
}

variable "resource_policy_assignment_location" {
  description = "(Optional) The Azure Region where the Policy Assignment should exist. Changing this forces a new Policy Assignment to be created."
  default     = null
}

variable "resource_policy_assignment_metadata" {
  description = "(Optional) A JSON mapping of any Metadata for this Policy."
  default     = null
}

variable "resource_policy_assignment_not_scopes" {
  description = "(Optional) Specifies a list of Resource Scopes (for example a Subscription, or a Resource Group) within this Management Group which are excluded from this Policy."
  default     = null
}

variable "resource_policy_assignment_parameters" {
  description = "(Optional) A JSON mapping of any Parameters for this Policy."
  default     = null
}

variable "resource_policy_assignment_identity" {
  description = "(Optional) An identity block"
  default     = {}
}

variable "resource_policy_assignment_non_compliance_message" {
  description = "(Optional) One or more non_compliance_message blocks"
  default     = []
}

variable "resource_policy_assignment_timeouts" {
  description = "Set timeouts for resource policy assignment"
  default     = {}
}

#-----------------------------------------------------------
# Azure resource group policy assignment
#-----------------------------------------------------------
variable "enable_resource_group_policy_assignment" {
  description = "Enable resource group policy assignment usage"
  default     = false
}

variable "resource_group_policy_assignment_name" {
  description = "The name which should be used for this Policy Assignment. Changing this forces a new Policy Assignment to be created."
  default     = ""
}

variable "resource_group_policy_assignment_resource_group_id" {
  description = "(Required) The ID of the Resource Group where this Policy Assignment should be created. Changing this forces a new Policy Assignment to be created."
  default     = null
}

variable "resource_group_policy_assignment_policy_definition_id" {
  description = "The ID of the Policy Definition or Policy Definition Set. Changing this forces a new Policy Assignment to be created."
  default     = ""
}

variable "resource_group_policy_assignment_description" {
  description = "(Optional) A description which should be used for this Policy Assignment."
  default     = null
}

variable "resource_group_policy_assignment_display_name" {
  description = "(Optional) The Display Name for this Policy Assignment."
  default     = null
}

variable "resource_group_policy_assignment_enforce" {
  description = "(Optional) Specifies if this Policy should be enforced or not?"
  default     = null
}

variable "resource_group_policy_assignment_location" {
  description = "(Optional) The Azure Region where the Policy Assignment should exist. Changing this forces a new Policy Assignment to be created."
  default     = null
}

variable "resource_group_policy_assignment_metadata" {
  description = "(Optional) A JSON mapping of any Metadata for this Policy."
  default     = null
}

variable "resource_group_policy_assignment_not_scopes" {
  description = "(Optional) Specifies a list of Resource Scopes (for example a Subscription, or a Resource Group) within this Management Group which are excluded from this Policy."
  default     = null
}

variable "resource_group_policy_assignment_parameters" {
  description = "(Optional) A JSON mapping of any Parameters for this Policy."
  default     = null
}

variable "resource_group_policy_assignment_identity" {
  description = "(Optional) An identity block"
  default     = {}
}

variable "resource_group_policy_assignment_non_compliance_message" {
  description = "(Optional) One or more non_compliance_message blocks"
  default     = []
}

variable "resource_group_policy_assignment_timeouts" {
  description = "Set timeouts for resource group policy assignment"
  default     = {}
}

#-----------------------------------------------------------
# Azure subscription policy remediation
#-----------------------------------------------------------
variable "enable_subscription_policy_remediation" {
  description = "Enable subscription policy remediation usage"
  default     = false
}

variable "subscription_policy_remediation_name" {
  description = "The name of the Policy Remediation. Changing this forces a new resource to be created."
  default     = ""
}

variable "subscription_policy_remediation_subscription_id" {
  description = "(Required) The Subscription ID at which the Policy Remediation should be applied. Changing this forces a new resource to be created."
  default     = null
}

variable "subscription_policy_remediation_policy_assignment_id" {
  description = "The ID of the Policy Assignment that should be remediated."
  default     = null
}

variable "subscription_policy_remediation_policy_definition_id" {
  description = "(Optional) The unique ID for the policy definition within the policy set definition that should be remediated. Required when the policy assignment being remediated assigns a policy set definition."
  default     = null
}

variable "subscription_policy_remediation_location_filters" {
  description = "(Optional) A list of the resource locations that will be remediated."
  default     = null
}

variable "subscription_policy_remediation_resource_discovery_mode" {
  description = "(Optional) The way that resources to remediate are discovered. Possible values are ExistingNonCompliant, ReEvaluateCompliance. Defaults to ExistingNonCompliant."
  default     = null
}

variable "subscription_policy_remediation_timeouts" {
  description = "Set timeouts for subscription policy remediation"
  default     = {}
}

#-----------------------------------------------------------
# Azure management group policy remediation
#-----------------------------------------------------------
variable "enable_management_group_policy_remediation" {
  description = "Enable management group policy remediation usage"
  default     = false
}

variable "management_group_policy_remediation_name" {
  description = "The name of the Policy Remediation. Changing this forces a new resource to be created."
  default     = ""
}

variable "management_group_policy_remediation_management_group_id" {
  description = "Required) The Management Group ID at which the Policy Remediation should be applied. Changing this forces a new resource to be created."
  default     = null
}

variable "management_group_policy_remediation_policy_assignment_id" {
  description = "The ID of the Policy Assignment that should be remediated."
  default     = ""
}

variable "management_group_policy_remediation_policy_definition_id" {
  description = "(Optional) The unique ID for the policy definition within the policy set definition that should be remediated. Required when the policy assignment being remediated assigns a policy set definition."
  default     = null
}

variable "management_group_policy_remediation_location_filters" {
  description = "(Optional) A list of the resource locations that will be remediated."
  default     = null
}

variable "management_group_policy_remediation_resource_discovery_mode" {
  description = "(Optional) The way that resources to remediate are discovered. Possible values are ExistingNonCompliant, ReEvaluateCompliance. Defaults to ExistingNonCompliant."
  default     = null
}

variable "management_group_policy_remediation_timeouts" {
  description = "Set timeouts for management group policy remediation"
  default     = {}
}

#-----------------------------------------------------------
# Azure resource group policy remediation
#-----------------------------------------------------------
variable "enable_resource_group_policy_remediation" {
  description = "Enable resource group policy remediation udage"
  default     = false
}

variable "resource_group_policy_remediation_name" {
  description = "The name of the Policy Remediation. Changing this forces a new resource to be created."
  default     = ""
}

variable "resource_group_policy_remediation_resource_group_id" {
  description = "(Required) The Resource Group ID at which the Policy Remediation should be applied. Changing this forces a new resource to be created."
  default     = null
}

variable "resource_group_policy_remediation_policy_assignment_id" {
  description = "The ID of the Policy Assignment that should be remediated."
  default     = ""
}

variable "resource_group_policy_remediation_policy_definition_id" {
  description = "(Optional) The unique ID for the policy definition within the policy set definition that should be remediated. Required when the policy assignment being remediated assigns a policy set definition."
  default     = null
}

variable "resource_group_policy_remediation_location_filters" {
  description = "(Optional) A list of the resource locations that will be remediated."
  default     = null
}

variable "resource_group_policy_remediation_resource_discovery_mode" {
  description = "(Optional) The way that resources to remediate are discovered. Possible values are ExistingNonCompliant, ReEvaluateCompliance. Defaults to ExistingNonCompliant."
  default     = null
}

variable "resource_group_policy_remediation_timeouts" {
  description = "Set timeouts for resource group policy remediation"
  default     = {}
}

#-----------------------------------------------------------
# Azure resource policy remediation
#-----------------------------------------------------------
variable "enable_resource_policy_remediation" {
  description = "Enable resource policy remediation usage"
  default     = false
}

variable "resource_policy_remediation_name" {
  description = "The name of the Policy Remediation. Changing this forces a new resource to be created."
  default     = ""
}

variable "resource_policy_remediation_resource_id" {
  description = "(Required) The Resource ID at which the Policy Remediation should be applied. Changing this forces a new resource to be created."
  default     = null
}

variable "resource_policy_remediation_policy_assignment_id" {
  description = "The ID of the Policy Assignment that should be remediated."
  default     = ""
}

variable "resource_policy_remediation_policy_definition_id" {
  description = "(Optional) The unique ID for the policy definition within the policy set definition that should be remediated. Required when the policy assignment being remediated assigns a policy set definition."
  default     = null
}

variable "resource_policy_remediation_location_filters" {
  description = "(Optional) A list of the resource locations that will be remediated."
  default     = null
}

variable "resource_policy_remediation_resource_discovery_mode" {
  description = "(Optional) The way that resources to remediate are discovered. Possible values are ExistingNonCompliant, ReEvaluateCompliance. Defaults to ExistingNonCompliant."
  default     = null
}

variable "resource_policy_remediation_timeouts" {
  description = "Set timeouts for resource policy remediation"
  default     = {}
}

#-----------------------------------------------------------
# Azure policy set definition
#-----------------------------------------------------------
variable "enable_policy_set_definition" {
  description = "Enable policy set definition usage"
  default     = false
}

variable "policy_set_definition_name" {
  description = "The name of the policy set definition. Changing this forces a new resource to be created."
  default     = ""
}

variable "policy_set_definition_policy_type" {
  description = "(Required) The policy set type. Possible values are BuiltIn or Custom. Changing this forces a new resource to be created."
  default     = null
}

variable "policy_set_definition_display_name" {
  description = "(Required) The display name of the policy set definition."
  default     = null
}

variable "policy_set_definition_description" {
  description = "(Optional) The description of the policy set definition."
  default     = null
}

variable "policy_set_definition_management_group_id" {
  description = "(Optional) The name of the Management Group where this policy set definition should be defined. Changing this forces a new resource to be created."
  default     = null
}

variable "policy_set_definition_metadata" {
  description = "(Optional) The metadata for the policy set definition. This is a JSON object representing additional metadata that should be stored with the policy definition."
  default     = null
}

variable "policy_set_definition_parameters" {
  description = "(Optional) Parameters for the policy set definition. This field is a JSON object that allows you to parameterize your policy definition."
  default     = null
}

variable "policy_set_definition_policy_policy_definition_reference" {
  description = "(Optional) One or more policy_definition_reference blocks"
  default     = []
}

variable "policy_set_definition_policy_definition_group" {
  description = "(Optional) One or more policy_definition_group blocks"
  default     = []
}

variable "policy_set_definition_timeouts" {
  description = "Set timeouts for policy set definition"
  default     = {}
}

#-----------------------------------------------------------
# Azure policy virtual machine configuration assignment
#-----------------------------------------------------------
variable "enable_policy_virtual_machine_configuration_assignment" {
  description = "Enable policy virtual machine configuration assignment usage"
  default     = false
}

variable "policy_virtual_machine_configuration_assignment_name" {
  description = "The name of the Guest Configuration that will be assigned in this Guest Configuration Assignment. Changing this forces a new resource to be created."
  default     = ""
}

variable "policy_virtual_machine_configuration_assignment_location" {
  description = "(Required) The Azure location where the Policy Virtual Machine Configuration Assignment should exist. Changing this forces a new resource to be created."
  default     = null
}

variable "policy_virtual_machine_configuration_assignment_virtual_machine_id" {
  description = "(Required) The resource ID of the Policy Virtual Machine which this Guest Configuration Assignment should apply to. Changing this forces a new resource to be created."
  default     = null
}

variable "policy_virtual_machine_configuration_assignment_configuration" {
  description = "(Required) A configuration block"
  default     = {}
}

variable "policy_virtual_machine_configuration_assignment_timeouts" {
  description = "Set timeouts for policy virtual machine configuration assignment"
  default     = {}
}