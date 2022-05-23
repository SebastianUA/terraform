#-----------------------------------------------------------
# Azure policy definition
#-----------------------------------------------------------
output "policy_definition_id" {
  description = "The ID of the Policy Definition."
  value       = element(concat(azurerm_policy_definition.policy_definition.*.id, [""]), 0)
}

#-----------------------------------------------------------
# Azure management group policy assignment
#-----------------------------------------------------------
output "management_group_policy_assignment_id" {
  description = "The ID of the Management Group Policy Assignment."
  value       = element(concat(azurerm_management_group_policy_assignment.management_group_policy_assignment.*.id, [""]), 0)
}

#-----------------------------------------------------------
# Azure subscription policy assignment
#-----------------------------------------------------------
output "subscription_policy_assignment_id" {
  description = "The ID of the Subscription Policy Assignment."
  value       = element(concat(azurerm_subscription_policy_assignment.subscription_policy_assignment.*.id, [""]), 0)
}

#-----------------------------------------------------------
# Azure resource policy assignment
#-----------------------------------------------------------
output "resource_policy_assignment_id" {
  description = "The ID of the Resource Policy Assignment."
  value       = element(concat(azurerm_resource_policy_assignment.resource_policy_assignment.*.id, [""]), 0)
}

#-----------------------------------------------------------
# Azure resource group policy assignment
#-----------------------------------------------------------
output "resource_group_policy_assignment_id" {
  description = "The ID of the Resource Group Policy Assignment."
  value       = element(concat(azurerm_resource_group_policy_assignment.resource_group_policy_assignment.*.id, [""]), 0)
}

output "resource_group_policy_assignment_identity" {
  description = "The identity settings of the Resource Group Policy Assignment."
  value       = concat(azurerm_resource_group_policy_assignment.resource_group_policy_assignment.*.identity, [""])
}

#-----------------------------------------------------------
# Azure policy subscription policy remediation
#-----------------------------------------------------------
output "subscription_policy_remediation_id" {
  description = "The ID of the Policy Remediation."
  value       = element(concat(azurerm_subscription_policy_remediation.subscription_policy_remediation.*.id, [""]), 0)
}

#-----------------------------------------------------------
# Azure policy management group policy remediation
#-----------------------------------------------------------
output "management_group_policy_remediation_id" {
  description = "The ID of the Policy Remediation."
  value       = element(concat(azurerm_management_group_policy_remediation.management_group_policy_remediation.*.id, [""]), 0)
}

#-----------------------------------------------------------
# Azure resource group policy remediation
#-----------------------------------------------------------
output "resource_group_policy_remediation_id" {
  description = "The ID of the Policy Remediation."
  value       = element(concat(azurerm_resource_group_policy_remediation.resource_group_policy_remediation.*.id, [""]), 0)
}

#-----------------------------------------------------------
# Azure resource policy remediation
#-----------------------------------------------------------
output "resource_policy_remediation_id" {
  description = "The ID of the Policy Remediation."
  value       = element(concat(azurerm_resource_policy_remediation.resource_policy_remediation.*.id, [""]), 0)
}

#-----------------------------------------------------------
# Azure policy set definition
#-----------------------------------------------------------
output "resource_policy_remediation_id" {
  description = "The ID of the Policy Set Definition."
  value       = element(concat(azurerm_policy_set_definition.policy_set_definition.*.id, [""]), 0)
}

#-----------------------------------------------------------
# Azure policy virtual machine configuration assignment
#-----------------------------------------------------------
output "policy_virtual_machine_configuration_assignment_id" {
  description = "The ID of the Policy Virtual Machine Configuration Assignment."
  value       = element(concat(azurerm_policy_virtual_machine_configuration_assignment.policy_virtual_machine_configuration_assignment.*.id, [""]), 0)
}