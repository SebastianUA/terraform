#-----------------------------------------------------------
# Azure resource group
#-----------------------------------------------------------
output "resource_group_id" {
  description = "The ID of the Resource Group."
  value       = element(concat(azurerm_resource_group.resource_group.*.id, [""]), 0)
}

output "resource_group_name" {
  description = "The name of the Resource Group."
  value       = element(concat(azurerm_resource_group.resource_group.*.name, [""]), 0)
}

output "resource_group_location" {
  description = "The location of the Resource Group."
  value       = element(concat(azurerm_resource_group.resource_group.*.location, [""]), 0)
}

#-----------------------------------------------------------
# Azure resource provider registration
#-----------------------------------------------------------
output "resource_provider_registration_id" {
  description = "The ID of the Resource provider registration."
  value       = element(concat(azurerm_resource_provider_registration.resource_provider_registration.*.id, [""]), 0)
}

#-----------------------------------------------------------
# Azure subscription
#-----------------------------------------------------------
output "subscription_id" {
  description = "The Resource ID of the Alias."
  value       = element(concat(azurerm_subscription.subscription.*.id, [""]), 0)
}

output "subscription_tenant_id" {
  description = "The ID of the Tenant to which the subscription belongs."
  value       = element(concat(azurerm_subscription.subscription.*.tenant_id, [""]), 0)
}
