#-----------------------------------------------------------
# Azure role definition
#-----------------------------------------------------------
output "role_definition_id" {
  description = "This ID is specific to Terraform - and is of the format {roleDefinitionId}|{scope}."
  value       = element(concat(azurerm_role_definition.role_definition.*.id, [""]), 0)
}

output "role_definition_role_definition_id" {
  description = "The Role Definition ID."
  value       = element(concat(azurerm_role_definition.role_definition.*.role_definition_id, [""]), 0)
}

output "role_definition_role_definition_resource_id" {
  description = "The Azure Resource Manager ID for the resource."
  value       = element(concat(azurerm_role_definition.role_definition.*.role_definition_resource_id, [""]), 0)
}

#-----------------------------------------------------------
# Azure role assignment
#-----------------------------------------------------------
output "role_assignment_id" {
  description = "The Role Assignment ID."
  value       = element(concat(azurerm_role_assignment.role_assignment.*.id, [""]), 0)
}

output "role_assignment_principal_type" {
  description = "The type of the principal_id, e.g. User, Group, Service Principal, Application, etc."
  value       = element(concat(azurerm_role_assignment.role_assignment.*.principal_type, [""]), 0)
}

#-----------------------------------------------------------
# Azure user assigned identity
#-----------------------------------------------------------
output "user_assigned_identity_id" {
  description = "The user assigned identity ID."
  value       = element(concat(azurerm_user_assigned_identity.user_assigned_identity.*.id, [""]), 0)
}

output "user_assigned_identity_principal_id" {
  description = "Service Principal ID associated with the user assigned identity."
  value       = element(concat(azurerm_user_assigned_identity.user_assigned_identity.*.principal_id, [""]), 0)
}

output "user_assigned_identity_client_id" {
  description = "Client ID associated with the user assigned identity."
  value       = element(concat(azurerm_user_assigned_identity.user_assigned_identity.*.client_id, [""]), 0)
}

output "user_assigned_identity_tenant_id" {
  description = "Tenant ID associated with the user assigned identity."
  value       = element(concat(azurerm_user_assigned_identity.user_assigned_identity.*.tenant_id, [""]), 0)
}
