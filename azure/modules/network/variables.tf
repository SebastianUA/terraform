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
# Azure network security group
#-----------------------------------------------------------
variable "enable_network_security_group" {
  description = "Enable network security group usage"
  default     = false
}

variable "network_security_group_name" {
  description = "Specifies the name of the network security group. Changing this forces a new resource to be created."
  default     = ""
}

variable "network_security_group_resource_group_name" {
  description = "(Required) The name of the resource group in which to create the network security group. Changing this forces a new resource to be created."
  default     = null
}

variable "network_security_group_location" {
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  default     = null
}

variable "network_security_group_security_rule" {
  description = "(Optional) List of objects representing security rules"
  default     = []
}

variable "network_security_group_timeouts" {
  description = "Set timeouts for network security group"
  default     = {}
}

#-----------------------------------------------------------
# Azure network security rule
#-----------------------------------------------------------
variable "enable_network_security_rule" {
  description = "Enable network security rule usage"
  default     = false
}

variable "network_security_rule_name" {
  description = "The name of the security rule. This needs to be unique across all Rules in the Network Security Group. Changing this forces a new resource to be created."
  default     = ""
}

variable "network_security_rule_resource_group_name" {
  description = "(Required) The name of the resource group in which to create the Network Security Rule. Changing this forces a new resource to be created."
  default     = null
}

variable "network_security_rule_network_security_group_name" {
  description = "The name of the Network Security Group that we want to attach the rule to. Changing this forces a new resource to be created."
  default     = ""
}

variable "network_security_rule_protocol" {
  description = "(Required) Network protocol this rule applies to. Possible values include Tcp, Udp, Icmp, Esp, Ah or * (which matches all)."
  default     = null
}

variable "network_security_rule_access" {
  description = "(Required) Specifies whether network traffic is allowed or denied. Possible values are Allow and Deny."
  default     = null
}

variable "network_security_rule_priority" {
  description = "(Required) Specifies the priority of the rule. The value can be between 100 and 4096. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule."
  default     = null
}

variable "network_security_rule_direction" {
  description = "(Required) The direction specifies if rule will be evaluated on incoming or outgoing traffic. Possible values are Inbound and Outbound."
  default     = null
}

variable "network_security_rule_description" {
  description = "(Optional) A description for this rule. Restricted to 140 characters."
  default     = null
}

variable "network_security_rule_source_port_range" {
  description = "(Optional) Source Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if source_port_ranges is not specified."
  default     = null
}

variable "network_security_rule_source_port_ranges" {
  description = "(Optional) List of source ports or port ranges. This is required if source_port_range is not specified."
  default     = null
}

variable "network_security_rule_destination_port_range" {
  description = "(Optional) Destination Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if destination_port_ranges is not specified."
  default     = null
}

variable "network_security_rule_destination_port_ranges" {
  description = "(Optional) List of destination ports or port ranges. This is required if destination_port_range is not specified."
  default     = null
}

variable "network_security_rule_source_address_prefix" {
  description = "(Optional) CIDR or source IP range or * to match any IP. Tags such as ‘VirtualNetwork’, ‘AzureLoadBalancer’ and ‘Internet’ can also be used. This is required if source_address_prefixes is not specified."
  default     = null
}

variable "network_security_rule_source_address_prefixes" {
  description = "(Optional) List of source address prefixes. Tags may not be used. This is required if source_address_prefix is not specified."
  default     = null
}

variable "network_security_rule_source_application_security_group_ids" {
  description = "(Optional) A List of source Application Security Group IDs"
  default     = null
}

variable "network_security_rule_destination_address_prefix" {
  description = "(Optional) CIDR or destination IP range or * to match any IP. Tags such as ‘VirtualNetwork’, ‘AzureLoadBalancer’ and ‘Internet’ can also be used. Besides, it also supports all available Service Tags like ‘Sql.WestEurope‘, ‘Storage.EastUS‘, etc. You can list the available service tags with the CLI: shell az network list-service-tags --location westcentralus. For further information please see Azure CLI - az network list-service-tags. This is required if destination_address_prefixes is not specified."
  default     = null
}

variable "network_security_rule_destination_address_prefixes" {
  description = "(Optional) List of destination address prefixes. Tags may not be used. This is required if destination_address_prefix is not specified."
  default     = null
}

variable "network_security_rule_destination_application_security_group_ids" {
  description = "(Optional) A List of destination Application Security Group IDs"
  default     = null
}

variable "network_security_rule_timeouts" {
  description = "Set timeouts for network security rule"
  default     = {}
}

variable "enable_network_security_rule_stacks" {
  description = "Enable network security rules with multiple blocks"
  default     = false
}

variable "network_security_rule_stacks" {
  description = "Set rules properties"
  default     = []
}

variable "network_security_rule_stacks_timeouts" {
  description = "Set timeouts for network security rule stacks"
  default     = {}
}

#-----------------------------------------------------------
# Azure virtual network
#-----------------------------------------------------------
variable "enable_virtual_network" {
  description = "Enable virtual network usage"
  default     = false
}

variable "virtual_network_name" {
  description = "The name of the virtual network. Changing this forces a new resource to be created."
  default     = ""
}

variable "virtual_network_resource_group_name" {
  description = "(Required) The name of the resource group in which to create the virtual network."
  default     = null
}

variable "virtual_network_location" {
  description = "(Required) The location/region where the virtual network is created. Changing this forces a new resource to be created."
  default     = null
}

variable "virtual_network_address_space" {
  description = "(Required) The address space that is used the virtual network. You can supply more than one address space."
  default     = null
}

variable "virtual_network_bgp_community" {
  description = "(Optional) The BGP community attribute in format <as-number>:<community-value>."
  default     = null
}

variable "virtual_network_dns_servers" {
  description = "(Optional) List of IP addresses of DNS servers"
  default     = null
}

variable "virtual_network_edge_zone" {
  description = "(Optional) Specifies the Edge Zone within the Azure Region where this Virtual Network should exist. Changing this forces a new Virtual Network to be created."
  default     = null
}

variable "virtual_network_flow_timeout_in_minutes" {
  description = "(Optional) The flow timeout in minutes for the Virtual Network, which is used to enable connection tracking for intra-VM flows. Possible values are between 4 and 30 minutes."
  default     = null
}

variable "virtual_network_subnet" {
  description = "(Optional) Can be specified multiple times to define multiple subnets."
  default     = []
}

variable "virtual_network_ddos_protection_plan" {
  description = "(Optional) A ddos_protection_plan block"
  default     = {}
}

variable "virtual_network_timeouts" {
  description = "Set timeouts for virtual network"
  default     = {}
}

#
#
#
# variable "AAAAA" {
#   description = "AAAAA"
#   default     = null
# }