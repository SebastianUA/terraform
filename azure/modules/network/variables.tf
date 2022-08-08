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

#-----------------------------------------------------------
# Azure public ip
#-----------------------------------------------------------
variable "enable_public_ip" {
  description = "Enable public ip usage"
  default     = false
}

variable "public_ip_name" {
  description = "Specifies the name of the Public IP. Changing this forces a new Public IP to be created."
  default     = ""
}

variable "public_ip_resource_group_name" {
  description = "(Required) The name of the Resource Group where this Public IP should exist. Changing this forces a new Public IP to be created."
  default     = null
}

variable "public_ip_location" {
  description = "(Required) Specifies the supported Azure location where the Public IP should exist. Changing this forces a new resource to be created."
  default     = null
}

variable "public_ip_allocation_method" {
  description = "(Required) Defines the allocation method for this IP address. Possible values are Static or Dynamic"
  default     = null
}

variable "public_ip_zones" {
  description = "(Optional) A collection containing the availability zone to allocate the Public IP in."
  default     = null
}

variable "public_ip_domain_name_label" {
  description = "(Optional) Label for the Domain Name. Will be used to make up the FQDN. If a domain name label is specified, an A DNS record is created for the public IP in the Microsoft Azure DNS system."
  default     = null
}

variable "public_ip_edge_zone" {
  description = "(Optional) Specifies the Edge Zone within the Azure Region where this Public IP should exist. Changing this forces a new Public IP to be created."
  default     = null
}

variable "public_ip_idle_timeout_in_minutes" {
  description = "(Optional) Specifies the timeout for the TCP idle connection. The value can be set between 4 and 30 minutes."
  default     = null
}

variable "public_ip_ip_tags" {
  description = "(Optional) A mapping of IP tags to assign to the public IP."
  default     = null
}

variable "public_ip_ip_version" {
  description = "(Optional) The IP Version to use, IPv6 or IPv4."
  default     = null
}

variable "public_ip_public_ip_prefix_id" {
  description = "(Optional) If specified then public IP address allocated will be provided from the public IP prefix resource."
  default     = null
}

variable "public_ip_reverse_fqdn" {
  description = " (Optional) A fully qualified domain name that resolves to this public IP address. If the reverseFqdn is specified, then a PTR DNS record is created pointing from the IP address in the in-addr.arpa domain to the reverse FQDN."
  default     = null
}

variable "public_ip_sku" {
  description = "(Optional) The SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Basic."
  default     = null
}

variable "public_ip_sku_tier" {
  description = "(Optional) The SKU Tier that should be used for the Public IP. Possible values are Regional and Global. Defaults to Regional."
  default     = null
}

variable "public_ip_timeouts" {
  description = "Set timeouts for public ip"
  default     = {}
}

#-----------------------------------------------------------
# Azure subnet
#-----------------------------------------------------------
variable "enable_subnet" {
  description = "Enable subnet usage"
  default     = false
}

variable "subnet_name" {
  description = "The name of the subnet. Changing this forces a new resource to be created."
  default     = ""
}

variable "subnet_resource_group_name" {
  description = "(Required) The name of the resource group in which to create the subnet. Changing this forces a new resource to be created."
  default     = null
}

variable "subnet_virtual_network_name" {
  description = "The name of the virtual network to which to attach the subnet. Changing this forces a new resource to be created."
  default     = ""
}

variable "subnet_address_prefixes" {
  description = "(Required) The address prefixes to use for the subnet."
  default     = null
}

variable "subnet_enforce_private_link_endpoint_network_policies" {
  description = "(Optional) Enable or Disable network policies for the private link endpoint on the subnet. Setting this to true will Disable the policy and setting this to false will Enable the policy. Default value is false."
  default     = null
}

variable "subnet_enforce_private_link_service_network_policies" {
  description = "(Optional) Enable or Disable network policies for the private link service on the subnet. Setting this to true will Disable the policy and setting this to false will Enable the policy. Default value is false."
  default     = null
}

variable "subnet_service_endpoints" {
  description = "(Optional) The list of Service endpoints to associate with the subnet. Possible values include: Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.ContainerRegistry, Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql, Microsoft.Storage and Microsoft.Web."
  default     = null
}

variable "subnet_service_endpoint_policy_ids" {
  description = "(Optional) The list of IDs of Service Endpoint Policies to associate with the subnet."
  default     = null
}

variable "subnet_delegation" {
  description = "(Optional) One or more delegation blocks"
  default     = []
}

variable "subnet_timeouts" {
  description = "Set timeouts for subnet"
  default     = {}
}

#-----------------------------------------------------------
# Azure bastion host
#-----------------------------------------------------------
variable "enable_bastion_host" {
  description = "Enable bastion host usage"
  default     = false
}

variable "bastion_host_name" {
  description = "Specifies the name of the Bastion Host. Changing this forces a new resource to be created."
  default     = ""
}

variable "bastion_host_resource_group_name" {
  description = "(Required) The name of the resource group in which to create the Bastion Host."
  default     = null
}

variable "bastion_host_location" {
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. Review Azure Bastion Host FAQ for supported locations."
  default     = null
}

variable "bastion_host_copy_paste_enabled" {
  description = "(Optional) Is Copy/Paste feature enabled for the Bastion Host. Defaults to true."
  default     = null
}

variable "bastion_host_file_copy_enabled" {
  description = "(Optional) Is File Copy feature enabled for the Bastion Host. Defaults to false."
  default     = null
}

variable "bastion_host_sku" {
  description = "(Optional) The SKU of the Bastion Host. Accepted values are Basic and Standard. Defaults to Basic"
  default     = null
}

variable "bastion_host_ip_connect_enabled" {
  description = "(Optional) Is IP Connect feature enabled for the Bastion Host. Defaults to false."
  default     = null
}

variable "bastion_host_scale_units" {
  description = "(Optional) The number of scale units with which to provision the Bastion Host. Possible values are between 2 and 50. Defaults to 2"
  default     = null
}

variable "bastion_host_shareable_link_enabled" {
  description = "(Optional) Is Shareable Link feature enabled for the Bastion Host. Defaults to false."
  default     = null
}

variable "bastion_host_tunneling_enabled" {
  description = "(Optional) Is Tunneling feature enabled for the Bastion Host. Defaults to false."
  default     = null
}

variable "bastion_host_ip_configuration" {
  description = "(Required) A ip_configuration block"
  default     = {}
}

variable "bastion_host_timeouts" {
  description = "Set timeouts for bastion host"
  default     = {}
}

#-----------------------------------------------------------
# Azure private link service
#-----------------------------------------------------------
variable "enable_private_link_service" {
  description = "Enable private link service usage"
  default     = false
}

variable "private_link_service_name" {
  description = "Specifies the name of this Private Link Service. Changing this forces a new resource to be created."
  default     = ""
}

variable "private_link_service_resource_group_name" {
  description = "(Required) The name of the Resource Group where the Private Link Service should exist. Changing this forces a new resource to be created."
  default     = null
}

variable "private_link_service_location" {
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  default     = null
}

variable "private_link_service_load_balancer_frontend_ip_configuration_ids" {
  description = "(Required) A list of Frontend IP Configuration IDs from a Standard Load Balancer, where traffic from the Private Link Service should be routed. You can use Load Balancer Rules to direct this traffic to appropriate backend pools where your applications are running."
  default     = null
}

variable "private_link_service_nat_ip_configuration" {
  description = "(Required) One or more (up to 8) nat_ip_configuration block"
  default     = []
}

variable "private_link_service_auto_approval_subscription_ids" {
  description = "(Optional) A list of Subscription UUID/GUID's that will be automatically be able to use this Private Link Service."
  default     = null
}

variable "private_link_service_enable_proxy_protocol" {
  description = "(Optional) Should the Private Link Service support the Proxy Protocol? Defaults to false."
  default     = null
}

variable "private_link_service_fqdns" {
  description = "(Optional) List of FQDNs allowed for the Private Link Service."
  default     = null
}

variable "private_link_service_visibility_subscription_ids" {
  description = "(Optional) A list of Subscription UUID/GUID's that will be able to see this Private Link Service."
  default     = null
}

variable "private_link_service_timeouts" {
  description = "Set timeouts for private link service"
  default     = {}
}

#-----------------------------------------------------------
# Azure private endpoint
#-----------------------------------------------------------
variable "enable_private_endpoint" {
  description = "Enable private endpoint usage"
  default     = false
}

variable "private_endpoint_name" {
  description = "Specifies the Name of the Private Endpoint. Changing this forces a new resource to be created."
  default     = ""
}

variable "private_endpoint_resource_group_name" {
  description = "(Required) Specifies the Name of the Resource Group within which the Private Endpoint should exist. Changing this forces a new resource to be created."
  default     = null
}

variable "private_endpoint_location" {
  description = "(Required) The supported Azure location where the resource exists. Changing this forces a new resource to be created."
  default     = null
}

variable "private_endpoint_subnet_id" {
  description = "(Required) The ID of the Subnet from which Private IP Addresses will be allocated for this Private Endpoint. Changing this forces a new resource to be created."
  default     = null
}

variable "private_endpoint_private_dns_zone_group" {
  description = "(Optional) A private_dns_zone_group block"
  default     = {}
}

variable "private_endpoint_private_service_connection" {
  description = "(Required) A private_service_connection block"
  default     = {}
}

variable "private_endpoint_timeouts" {
  description = "Set timeouts for private endpoint"
  default     = {}
}

#-----------------------------------------------------------
# Azure network interface
#-----------------------------------------------------------
variable "enable_network_interface" {
  description = "Enable network interface usage"
  default     = false
}

variable "network_interface_name" {
  description = "The name of the Network Interface. Changing this forces a new resource to be created."
  default     = ""
}

variable "network_interface_location" {
  description = "(Required) The location where the Network Interface should exist. Changing this forces a new resource to be created."
  default     = null
}

variable "network_interface_resource_group_name" {
  description = "(Required) The name of the Resource Group in which to create the Network Interface. Changing this forces a new resource to be created."
  default     = null
}

variable "network_interface_dns_servers" {
  description = "(Optional) A list of IP Addresses defining the DNS Servers which should be used for this Network Interface."
  default     = null
}

variable "network_interface_edge_zone" {
  description = "(Optional) Specifies the Edge Zone within the Azure Region where this Network Interface should exist. Changing this forces a new Network Interface to be created."
  default     = null
}

variable "network_interface_enable_ip_forwarding" {
  description = "(Optional) Should IP Forwarding be enabled? Defaults to false."
  default     = null
}

variable "network_interface_enable_accelerated_networking" {
  description = "(Optional) Should Accelerated Networking be enabled? Defaults to false."
  default     = null
}

variable "network_interface_internal_dns_name_label" {
  description = "(Optional) The (relative) DNS Name used for internal communications between Virtual Machines in the same Virtual Network."
  default     = null
}

variable "network_interface_ip_configuration" {
  description = "(Required) One or more ip_configuration blocks"
  default     = []
}

variable "network_interface_timeouts" {
  description = "Set timeouts network interface"
  default     = {}
}