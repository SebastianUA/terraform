#-----------------------------------------------------------
# Azure network security group
#-----------------------------------------------------------
output "network_security_group_id" {
  description = "The ID of the Network Security Group."
  value       = element(concat(azurerm_network_security_group.network_security_group.*.id, [""]), 0)
}

output "network_security_group_name" {
  description = "The name of the Network Security Group."
  value       = element(concat(azurerm_network_security_group.network_security_group.*.name, [""]), 0)
}

#-----------------------------------------------------------
# Azure network security rule
#-----------------------------------------------------------
output "network_security_rule_id" {
  description = "The ID of the Network Security Rule."
  value       = element(concat(azurerm_network_security_rule.network_security_rule.*.id, [""]), 0)
}

output "network_security_rule_stacks_id" {
  description = "The IDs of the Network Security Rules."
  value       = concat(azurerm_network_security_rule.network_security_rule_stacks.*.id, [""])
}

#-----------------------------------------------------------
# Azure virtual network
#-----------------------------------------------------------
output "virtual_network_id" {
  description = "The virtual NetworkConfiguration ID."
  value       = element(concat(azurerm_virtual_network.virtual_network.*.id, [""]), 0)
}

output "virtual_network_name" {
  description = "The name of the virtual network."
  value       = element(concat(azurerm_virtual_network.virtual_network.*.name, [""]), 0)
}

output "virtual_network_resource_group_name" {
  description = "The name of the resource group in which to create the virtual network."
  value       = element(concat(azurerm_virtual_network.virtual_network.*.resource_group_name, [""]), 0)
}

output "virtual_network_location" {
  description = "The location/region where the virtual network is created."
  value       = element(concat(azurerm_virtual_network.virtual_network.*.location, [""]), 0)
}

output "virtual_network_address_space" {
  description = "The list of address spaces used by the virtual network."
  value       = concat(azurerm_virtual_network.virtual_network.*.address_space, [""])
}

output "virtual_network_guid" {
  description = "The GUID of the virtual network."
  value       = element(concat(azurerm_virtual_network.virtual_network.*.guid, [""]), 0)
}

output "virtual_network_subnet" {
  description = "The virtual NetworkConfiguration ID."
  value       = concat(azurerm_virtual_network.virtual_network.*.subnet, [""])
}

#
#
#