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
# Azure role definition
#-----------------------------------------------------------
variable "enable_role_definition" {
  description = "Enable role definition usage"
  default     = false
}

variable "role_definition_name" {
  description = "The name of the Role Definition. Changing this forces a new resource to be created."
  default     = ""
}

variable "role_definition_scope" {
  description = "(Required) The scope at which the Role Definition applies to, such as /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333, /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333/resourceGroups/myGroup, or /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333/resourceGroups/myGroup/providers/Microsoft.Compute/virtualMachines/myVM. It is recommended to use the first entry of the assignable_scopes. Changing this forces a new resource to be created."
  default     = null
}

variable "role_definition_description" {
  description = "(Optional) A description of the Role Definition."
  default     = null
}

variable "role_definition_role_definition_id" {
  description = "(Optional) A unique UUID/GUID which identifies this role - one will be generated if not specified. Changing this forces a new resource to be created."
  default     = null
}

variable "role_definition_assignable_scopes" {
  description = "(Optional) One or more assignable scopes for this Role Definition, such as /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333, /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333/resourceGroups/myGroup, or /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333/resourceGroups/myGroup/providers/Microsoft.Compute/virtualMachines/myVM"
  default     = null
}

variable "role_definition_permissions" {
  description = "(Optional) A permissions block"
  default     = []
}

variable "role_definition_timeouts" {
  description = "Set timeouts for role definition"
  default     = {}
}

#-----------------------------------------------------------
# Azure role assignment
#-----------------------------------------------------------
variable "enable_role_assignment" {
  description = "Enable role assignment usage"
  default     = false
}

variable "role_assignment_name" {
  description = "(Optional) A unique UUID/GUID for this Role Assignment - one will be generated if not specified. Changing this forces a new resource to be created."
  default     = null
}

variable "role_assignment_scope" {
  description = "(Required) The scope at which the Role Assignment applies to, such as /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333, /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333/resourceGroups/myGroup, or /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333/resourceGroups/myGroup/providers/Microsoft.Compute/virtualMachines/myVM, or /providers/Microsoft.Management/managementGroups/myMG. Changing this forces a new resource to be created."
  default     = null
}

variable "role_assignment_principal_id" {
  description = " (Required) The ID of the Principal (User, Group or Service Principal) to assign the Role Definition to. Changing this forces a new resource to be created."
  default     = null
}

variable "role_assignment_description" {
  description = "(Optional) The description for this Role Assignment. Changing this forces a new resource to be created."
  default     = null
}

variable "role_assignment_role_definition_id" {
  description = "(Optional) The Scoped-ID of the Role Definition. Changing this forces a new resource to be created. Conflicts with role_definition_name"
  default     = null
}

variable "role_assignment_role_definition_name" {
  description = "(Optional) The name of a built-in Role. Changing this forces a new resource to be created. Conflicts with role_definition_id"
  default     = null
}

variable "role_assignment_condition" {
  description = "(Optional) The condition that limits the resources that the role can be assigned to. Changing this forces a new resource to be created."
  default     = null
}

variable "role_assignment_condition_version" {
  description = "(Optional) The version of the condition. Possible values are 1.0 or 2.0. Changing this forces a new resource to be created."
  default     = null
}

variable "role_assignment_delegated_managed_identity_resource_id" {
  description = "(Optional) The delegated Azure Resource Id which contains a Managed Identity. Changing this forces a new resource to be created."
  default     = null
}

variable "role_assignment_skip_service_principal_aad_check" {
  description = "(Optional) If the principal_id is a newly provisioned Service Principal set this value to true to skip the Azure Active Directory check which may fail due to replication lag. This argument is only valid if the principal_id is a Service Principal identity. If it is not a Service Principal identity it will cause the role assignment to fail. Defaults to false"
  default     = null
}

variable "role_assignment_timeouts" {
  description = "Set timeouts for role assignment"
  default     = {}
}

#-----------------------------------------------------------
# Azure user assigned identity
#-----------------------------------------------------------
variable "enable_user_assigned_identity" {
  description = "Enable user assigned identity usage"
  default     = false
}

variable "user_assigned_identity_name" {
  description = "The name of the user assigned identity. Changing this forces a new identity to be created."
  default     = ""
}

variable "user_assigned_identity_resource_group_name" {
  description = "(Required) The name of the resource group in which to create the user assigned identity."
  default     = null
}

variable "user_assigned_identity_location" {
  description = "(Required) The location/region where the user assigned identity is created."
  default     = null
}

variable "user_assigned_identity_timeouts" {
  description = "Set timeouts for user assigned identity"
  default     = {}
}
