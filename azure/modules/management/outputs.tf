#-----------------------------------------------------------
# Azure management group
#-----------------------------------------------------------
output "management_group_id" {
  description = "The ID of the Management Group."
  value       = element(concat(azurerm_management_group.management_group.*.id, [""]), 0)
}

#-----------------------------------------------------------
# Azure management lock
#-----------------------------------------------------------
output "management_lock_id" {
  description = "The ID of the Management Lock."
  value       = element(concat(azurerm_management_lock.management_lock.*.id, [""]), 0)
}

#-----------------------------------------------------------
# Azure management group subscription association
#-----------------------------------------------------------
output "management_group_subscription_association_id" {
  description = "The ID of the Management Group Subscription Association."
  value       = element(concat(azurerm_management_group_subscription_association.management_group_subscription_association.*.id, [""]), 0)
}