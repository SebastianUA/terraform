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
  description = "One or more subnet blocks."
  value       = concat(azurerm_virtual_network.virtual_network.*.subnet, [""])
}

#-----------------------------------------------------------
# Azure public ip
#-----------------------------------------------------------
output "public_ip_id" {
  description = "The ID of this Public IP."
  value       = element(concat(azurerm_public_ip.public_ip.*.id, [""]), 0)
}

output "public_ip_ip_address" {
  description = "The IP address value that was allocated."
  value       = element(concat(azurerm_public_ip.public_ip.*.ip_address, [""]), 0)
}

output "public_ip_fqdn" {
  description = "Fully qualified domain name of the A DNS record associated with the public IP. domain_name_label must be specified to get the fqdn. This is the concatenation of the domain_name_label and the regionalized DNS zone"
  value       = element(concat(azurerm_public_ip.public_ip.*.fqdn, [""]), 0)
}

#-----------------------------------------------------------
# Azure subnet
#-----------------------------------------------------------
output "subnet_id" {
  description = "The subnet ID."
  value       = element(concat(azurerm_subnet.subnet.*.id, [""]), 0)
}

output "subnet_name" {
  description = "The name of the subnet."
  value       = element(concat(azurerm_subnet.subnet.*.name, [""]), 0)
}

output "subnet_resource_group_name" {
  description = "The name of the resource group in which the subnet is created in."
  value       = element(concat(azurerm_subnet.subnet.*.resource_group_name, [""]), 0)
}

output "subnet_virtual_network_name" {
  description = "The name of the virtual network in which the subnet is created in"
  value       = element(concat(azurerm_subnet.subnet.*.virtual_network_name, [""]), 0)
}

output "subnet_address_prefixes" {
  description = "The address prefixes for the subnet"
  value       = concat(azurerm_subnet.subnet.*.address_prefixes, [""])
}

#-----------------------------------------------------------
# Azure bastion host
#-----------------------------------------------------------
output "bastion_host_id" {
  description = "The ID of the Bastion Host."
  value       = element(concat(azurerm_bastion_host.bastion_host.*.id, [""]), 0)
}

output "bastion_host_dns_name" {
  description = "The FQDN for the Bastion Host."
  value       = element(concat(azurerm_bastion_host.bastion_host.*.dns_name, [""]), 0)
}

#-----------------------------------------------------------
# Azure private link service
#-----------------------------------------------------------
output "private_link_service_id" {
  description = "The ID of the private link service."
  value       = element(concat(azurerm_private_link_service.private_link_service.*.id, [""]), 0)
}

output "private_link_service_alias" {
  description = "A globally unique DNS Name for your Private Link Service. You can use this alias to request a connection to your Private Link Service."
  value       = concat(azurerm_private_link_service.private_link_service.*.alias, [""])
}

#-----------------------------------------------------------
# Azure private endpoint
#-----------------------------------------------------------
output "private_endpoint_id" {
  description = "The ID of the Private Endpoint."
  value       = element(concat(azurerm_private_endpoint.private_endpoint.*.id, [""]), 0)
}

output "private_endpoint_network_interface" {
  description = "The ID of the Private Endpoint (network interface)."
  value       = concat(azurerm_private_endpoint.private_endpoint.*.network_interface, [""])
}

output "private_endpoint_private_dns_zone_group" {
  description = "The ID of the Private Endpoint (private dns zone group)."
  value       = concat(azurerm_private_endpoint.private_endpoint.*.private_dns_zone_group, [""])
}

output "private_endpoint_custom_dns_configs" {
  description = "The ID of the Private Endpoint (custom dns configs)."
  value       = concat(azurerm_private_endpoint.private_endpoint.*.custom_dns_configs, [""])
}

output "private_endpoint_private_dns_zone_configs" {
  description = "The ID of the Private Endpoint (private dns zone configs)."
  value       = concat(azurerm_private_endpoint.private_endpoint.*.private_dns_zone_configs, [""])
}

output "private_endpoint_private_service_connection" {
  description = "The ID of the Private Endpoint (private service connection)."
  value       = concat(azurerm_private_endpoint.private_endpoint.*.private_service_connection, [""])
}

# output "private_endpoint_record_sets" {
#   description = "The ID of the Private Endpoint (record sets)."
#   value       = concat(azurerm_private_endpoint.private_endpoint.*.record_sets, [""])
# }

#-----------------------------------------------------------
# Azure network interface
#-----------------------------------------------------------
output "network_interface_id" {
  description = "The ID of the Network Interface."
  value       = element(concat(azurerm_network_interface.network_interface.*.id, [""]), 0)
}

output "network_interface_applied_dns_servers" {
  description = "If the Virtual Machine using this Network Interface is part of an Availability Set, then this list will have the union of all DNS servers from all Network Interfaces that are part of the Availability Set."
  value       = concat(azurerm_network_interface.network_interface.*.applied_dns_servers, [""])
}

output "network_interface_internal_domain_name_suffix" {
  description = "Even if internal_dns_name_label is not specified, a DNS entry is created for the primary NIC of the VM. This DNS name can be constructed by concatenating the VM name with the value of internal_domain_name_suffix."
  value       = element(concat(azurerm_network_interface.network_interface.*.internal_domain_name_suffix, [""]), 0)
}

output "network_interface_mac_address" {
  description = "The Media Access Control (MAC) Address of the Network Interface."
  value       = element(concat(azurerm_network_interface.network_interface.*.mac_address, [""]), 0)
}

output "network_interface_private_ip_address" {
  description = "The first private IP address of the network interface."
  value       = element(concat(azurerm_network_interface.network_interface.*.private_ip_address, [""]), 0)
}

output "network_interface_private_ip_addresses" {
  description = "The private IP addresses of the network interface."
  value       = concat(azurerm_network_interface.network_interface.*.private_ip_addresses)
}

output "network_interface_virtual_machine_id" {
  description = "The ID of the Virtual Machine which this Network Interface is connected to."
  value       = element(concat(azurerm_network_interface.network_interface.*.virtual_machine_id, [""]), 0)
}