#-----------------------------------------------------------
# Global
#-----------------------------------------------------------
variable "name" {
  description = "The name for resources"
  default     = "test"
}

variable "environment" {
  description = "The environment for resources"
  default     = "dev"
}

variable "tags" {
  description = "Add additional tags"
  default     = {}
}

#-----------------------------------------------------------
# core vcn
#-----------------------------------------------------------
variable "enable_core_vcn" {
  description = "Enable core vcn usages"
  default     = false
}

variable "core_vcn_compartment_id" {
  description = "(Required) (Updatable) The OCID of the compartment to contain the VCN."
  default     = null
}

variable "core_vcn_byoipv6cidr_details" {
  description = "(Optional) The list of BYOIPv6 OCIDs and BYOIPv6 prefixes required to create a VCN that uses BYOIPv6 address ranges."
  default     = []
}

variable "core_vcn_display_name" {
  description = "(Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  default     = null
}

variable "core_vcn_cidr_blocks" {
  description = "(Optional) (Updatable) The list of one or more IPv4 CIDR blocks for the VCN"
  default     = null
}

variable "core_vcn_dns_label" {
  description = "(Optional) A DNS label for the VCN, used in conjunction with the VNIC's hostname and subnet's DNS label to form a fully qualified domain name (FQDN) for each VNIC within this subnet (for example, bminstance1.subnet123.vcn1.oraclevcn.com). Not required to be unique, but it's a best practice to set unique DNS labels for VCNs in your tenancy. Must be an alphanumeric string that begins with a letter. The value cannot be changed. You must set this value if you want instances to be able to use hostnames to resolve other instances in the VCN. Otherwise the Internet and VCN Resolver will not work."
  default     = null
}

variable "core_vcn_ipv6private_cidr_blocks" {
  description = "(Optional) The list of one or more ULA or Private IPv6 CIDR blocks for the vcn"
  default     = null
}

variable "core_vcn_is_ipv6enabled" {
  description = "(Optional) Whether IPv6 is enabled for the VCN. Default is false. If enabled, Oracle will assign the VCN a IPv6 /56 CIDR block. You may skip having Oracle allocate the VCN a IPv6 /56 CIDR block by setting isOracleGuaAllocationEnabled to false. For important details about IPv6 addressing in a VCN, see IPv6 Addresses. Example: true"
  default     = null
}

variable "core_vcn_is_oracle_gua_allocation_enabled" {
  description = "(Optional) Specifies whether to skip Oracle allocated IPv6 GUA. By default, Oracle will allocate one GUA of /56 size for an IPv6 enabled VCN."
  default     = null
}

variable "core_vcn_security_attributes" {
  description = "(Optional) (Updatable) Security Attributes for this resource. This is unique to ZPR, and helps identify which resources are allowed to be accessed by what permission controls. Example: {'Oracle-DataSecurity-ZPR.MaxEgressCount.value': '42', 'Oracle-DataSecurity-ZPR.MaxEgressCount.mode': 'audit'}"
  default     = null
}

variable "core_vcn_freeform_tags" {
  description = "(Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags."
  default     = {}
}

variable "core_vcn_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Vcn * update - (Defaults to 20 minutes), when updating the Vcn * delete - (Defaults to 20 minutes), when destroying the Vcn"
  default     = {}
}

#-----------------------------------------------------------
# core private ip
#-----------------------------------------------------------
variable "enable_core_private_ip" {
  description = "Enable core private ip usages"
  default     = false
}

variable "core_private_ip_display_name" {
  description = "(Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  default     = null
}

variable "core_private_ip_hostname_label" {
  description = "(Optional) (Updatable) The hostname for the private IP. Used for DNS. The value is the hostname portion of the private IP's fully qualified domain name (FQDN) (for example, bminstance1 in FQDN bminstance1.subnet123.vcn1.oraclevcn.com). Must be unique across all VNICs in the subnet and comply with RFC 952 and RFC 1123."
  default     = null
}

variable "core_private_ip_ip_address" {
  description = "(Optional) A private IP address of your choice. Must be an available IP address within the subnet's CIDR. If you don't specify a value, Oracle automatically assigns a private IP address from the subnet. Example: 10.0.3.3"
  default     = null
}

variable "core_private_ip_vlan_id" {
  description = "(Optional) Use this attribute only with the Oracle Cloud VMware Solution. The OCID of the VLAN from which the private IP is to be drawn. The IP address, if supplied, must be valid for the given VLAN. See Vlan."
  default     = null
}

variable "core_private_ip_vnic_id" {
  description = "(Optional) (Updatable) The OCID of the VNIC to assign the private IP to. The VNIC and private IP must be in the same subnet."
  default     = null
}

variable "core_private_ip_freeform_tags" {
  description = "(Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags"
  default     = {}
}

variable "core_private_ip_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Private Ip * update - (Defaults to 20 minutes), when updating the Private Ip * delete - (Defaults to 20 minutes), when destroying the Private Ip"
  default     = {}
}

#-----------------------------------------------------------
# core public ip pool capacity
#-----------------------------------------------------------
variable "enable_core_public_ip_pool_capacity" {
  description = "Enable core public ip pool capacity usages"
  default     = false
}

variable "core_public_ip_pool_capacity_public_ip_pool_id" {
  description = "(Required) The OCID of the pool object created by the current tenancy"
  default     = null
}

variable "core_public_ip_pool_capacity_byoip_id" {
  description = "(Required) The OCID of the Byoip Range Id object to which the cidr block belongs."
  default     = null
}

variable "core_public_ip_pool_capacity_cidr_block" {
  description = "(Required) The CIDR IP address range to be added to the Public Ip Pool. Example: 10.0.1.0/24"
  default     = null
}

#-----------------------------------------------------------
# core public ip pool
#-----------------------------------------------------------
variable "enable_core_public_ip_pool" {
  description = "Enable core public ip pool usages"
  default     = false
}

variable "core_public_ip_pool_compartment_id" {
  description = "(Required) (Updatable) The OCID of the compartment containing the public IP pool."
  default     = null
}

variable "core_public_ip_pool_display_name" {
  description = "(Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  default     = null
}

variable "core_public_ip_pool_freeform_tags" {
  description = "(Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags."
  default     = {}
}

variable "core_public_ip_pool_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Public Ip Pool * update - (Defaults to 20 minutes), when updating the Public Ip Pool * delete - (Defaults to 20 minutes), when destroying the Public Ip Pool"
  default     = {}
}

#-----------------------------------------------------------
# core public ip
#-----------------------------------------------------------
variable "enable_core_public_ip" {
  description = "Enable core public ip usages"
  default     = false
}

variable "core_public_ip_compartment_id" {
  description = "(Required) (Updatable) The OCID of the compartment to contain the public IP. For ephemeral public IPs, you must set this to the private IP's compartment OCID."
  default     = null
}

variable "core_public_ip_lifetime" {
  description = "(Required) Defines when the public IP is deleted and released back to the Oracle Cloud Infrastructure public IP pool. For more information, see Public IP Addresses."
  default     = null
}

variable "core_public_ip_display_name" {
  description = "(Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  default     = null
}

variable "core_public_ip_private_ip_id" {
  description = "(Optional) (Updatable) The OCID of the private IP to assign the public IP to."
  default     = null
}

variable "core_public_ip_public_ip_pool_id" {
  description = "(Optional) The OCID of the public IP pool."
  default     = null
}

variable "core_public_ip_freeform_tags" {
  description = "(Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. "
  default     = {}
}

variable "core_public_ip_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Public Ip * update - (Defaults to 20 minutes), when updating the Public Ip * delete - (Defaults to 20 minutes), when destroying the Public Ip"
  default     = {}
}

#-----------------------------------------------------------
# core route table
#-----------------------------------------------------------
variable "enable_core_route_table" {
  description = "Enable core route table usages"
  default     = false
}

variable "core_route_table_compartment_id" {
  description = "(Required) (Updatable) The OCID of the compartment to contain the route table."
  default     = null
}

variable "core_route_table_vcn_id" {
  description = "(Required) The OCID of the VCN the route table belongs to."
  default     = ""
}

variable "core_route_table_display_name" {
  description = "(Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  default     = null
}

variable "core_route_table_route_rules" {
  description = "(Optional) (Updatable) The collection of rules used for routing destination IPs to network devices."
  default     = []
}

variable "core_route_table_freeform_tags" {
  description = "(Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. "
  default     = {}
}

variable "core_route_table_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Route Table * update - (Defaults to 20 minutes), when updating the Route Table * delete - (Defaults to 20 minutes), when destroying the Route Table"
  default     = {}
}

#-----------------------------------------------------------
# core route table attachment
#-----------------------------------------------------------
variable "enable_core_route_table_attachment" {
  description = "Enable core route table attachment usages"
  default     = false
}

variable "core_route_table_attachment_subnet_id" {
  description = "(Required) The OCID of the subnet."
  default     = ""
}

variable "core_route_table_attachment_route_table_id" {
  description = "(Required) The OCID of the route table."
  default     = ""
}

#-----------------------------------------------------------
# core vlan
#-----------------------------------------------------------
variable "enable_core_vlan" {
  description = "Enable core vlan usages"
  default     = false
}

variable "core_vlan_cidr_block" {
  description = "(Required) (Updatable) The range of IPv4 addresses that will be used for layer 3 communication with hosts outside the VLAN"
  default     = null
}

variable "core_vlan_compartment_id" {
  description = "(Required) (Updatable) The OCID of the compartment to contain the VLAN."
  default     = null
}

variable "core_vlan_vcn_id" {
  description = "(Required) The OCID of the VCN to contain the VLAN."
  default     = ""
}

variable "core_vlan_display_name" {
  description = "(Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  default     = null
}

variable "core_vlan_availability_domain" {
  description = "(Optional) Controls whether the VLAN is regional or specific to an availability domain. A regional VLAN has the flexibility to implement failover across availability domains. Previously, all VLANs were AD-specific."
  default     = null
}

variable "core_vlan_nsg_ids" {
  description = "(Optional) (Updatable) A list of the OCIDs of the network security groups (NSGs) to add all VNICs in the VLAN to. For more information about NSGs"
  default     = null
}

variable "core_vlan_route_table_id" {
  description = "(Optional) (Updatable) The OCID of the route table the VLAN will use. If you don't provide a value, the VLAN uses the VCN's default route table."
  default     = null
}

variable "core_vlan_vlan_tag" {
  description = "(Optional) The IEEE 802.1Q VLAN tag for this VLAN. The value must be unique across all VLANs in the VCN. If you don't provide a value, Oracle assigns one. You cannot change the value later. VLAN tag 0 is reserved for use by Oracle."
  default     = null
}

variable "core_vlan_freeform_tags" {
  description = "(Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags."
  default     = {}
}

variable "core_vlan_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Vlan * update - (Defaults to 20 minutes), when updating the Vlan * delete - (Defaults to 20 minutes), when destroying the Vlan"
  default     = {}
}

#-----------------------------------------------------------
# core vnic attachment
#-----------------------------------------------------------
variable "enable_core_vnic_attachment" {
  description = "Enable core vnic attachment usages"
  default     = false
}

variable "core_vnic_attachment_create_vnic_details" {
  description = "(Required) (Updatable) Contains properties for a VNIC. You use this object when creating the primary VNIC during instance launch or when creating a secondary VNIC. For more information about VNICs, see Virtual Network Interface Cards (VNICs)."
  default     = []
}

variable "core_vnic_attachment_instance_id" {
  description = "(Required) The OCID of the instance."
  default     = null
}

variable "core_vnic_attachment_display_name" {
  description = "(Optional) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  default     = null
}

variable "core_vnic_attachment_nic_index" {
  description = "(Optional) Which physical network interface card (NIC) the VNIC will use. Defaults to 0. Certain bare metal instance shapes have two active physical NICs (0 and 1). If you add a secondary VNIC to one of these instances, you can specify which NIC the VNIC will use. For more information, see Virtual Network Interface Cards (VNICs)."
  default     = null
}

variable "core_vnic_attachment_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Vnic Attachment * update - (Defaults to 20 minutes), when updating the Vnic Attachment * delete - (Defaults to 20 minutes), when destroying the Vnic Attachment"
  default     = {}
}

#-----------------------------------------------------------
# core subnet
#-----------------------------------------------------------
variable "enable_core_subnet" {
  description = "Enable core subnet usages"
  default     = false
}

variable "core_subnet_cidr_block" {
  description = "(Required) (Updatable) The CIDR IP address range of the subnet. "
  default     = null
}

variable "core_subnet_compartment_id" {
  description = "(Required) (Updatable) The OCID of the compartment to contain the subnet."
  default     = null
}

variable "core_subnet_vcn_id" {
  description = "(Required) The OCID of the VCN to contain the subnet."
  default     = ""
}

variable "core_subnet_availability_domain" {
  description = " (Optional) Controls whether the subnet is regional or specific to an availability domain. Oracle recommends creating regional subnets because they're more flexible and make it easier to implement failover across availability domains. Originally, AD-specific subnets were the only kind available to use."
  default     = null
}

variable "core_subnet_dhcp_options_id" {
  description = "(Optional) (Updatable) The OCID of the set of DHCP options the subnet will use. If you don't provide a value, the subnet uses the VCN's default set of DHCP options."
  default     = null
}

variable "core_subnet_display_name" {
  description = "(Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  default     = null
}

variable "core_subnet_dns_label" {
  description = "(Optional) A DNS label for the subnet, used in conjunction with the VNIC's hostname and VCN's DNS label to form a fully qualified domain name (FQDN) for each VNIC within this subnet (for example, bminstance1.subnet123.vcn1.oraclevcn.com). Must be an alphanumeric string that begins with a letter and is unique within the VCN. The value cannot be changed."
  default     = null
}

variable "core_subnet_ipv6cidr_block" {
  description = "(Optional) (Updatable) Use this to enable IPv6 addressing for this subnet. The VCN must be enabled for IPv6. You can't change this subnet characteristic later. All subnets are /64 in size. The subnet portion of the IPv6 address is the fourth hextet from the left (1111 in the following example)."
  default     = null
}

variable "core_subnet_ipv6cidr_blocks" {
  description = "(Optional) (Updatable) The list of all IPv6 prefixes (Oracle allocated IPv6 GUA, ULA or private IPv6 prefixes, BYOIPv6 prefixes) for the subnet"
  default     = null
}

variable "core_subnet_prohibit_internet_ingress" {
  description = "(Optional) Whether to disallow ingress internet traffic to VNICs within this subnet. Defaults to false."
  default     = null
}

variable "core_subnet_prohibit_public_ip_on_vnic" {
  description = "(Optional) Whether VNICs within this subnet can have public IP addresses. Defaults to false, which means VNICs created in this subnet will automatically be assigned public IP addresses unless specified otherwise during instance launch or VNIC creation (with the assignPublicIp flag in CreateVnicDetails). If prohibitPublicIpOnVnic is set to true, VNICs created in this subnet cannot have public IP addresses (that is, it's a private subnet)."
  default     = null
}

variable "core_subnet_route_table_id" {
  description = "(Optional) (Updatable) The OCID of the route table the subnet will use. If you don't provide a value, the subnet uses the VCN's default route table."
  default     = null
}

variable "core_subnet_security_list_ids" {
  description = "(Optional) (Updatable) The OCIDs of the security list or lists the subnet will use. If you don't provide a value, the subnet uses the VCN's default security list. Remember that security lists are associated with the subnet, but the rules are applied to the individual VNICs in the subnet."
  default     = null
}

variable "core_subnet_freeform_tags" {
  description = "(Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags."
  default     = {}
}

variable "core_subnet_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Subnet * update - (Defaults to 20 minutes), when updating the Subnet * delete - (Defaults to 20 minutes), when destroying the Subnet"
  default     = {}
}

#-----------------------------------------------------------
# core dhcp options
#-----------------------------------------------------------
variable "enable_core_dhcp_options" {
  description = "Enablecore dhcp options usages"
  default     = false
}

variable "core_dhcp_options_compartment_id" {
  description = "(Required) (Updatable) The OCID of the compartment to contain the set of DHCP options."
  default     = null
}

variable "core_dhcp_options_options" {
  description = "List of DHCP options configurations."
  # type        = list(map(any))
  default = []

  # validation {
  #   condition     = length(var.core_dhcp_options_options) == 0 || length(var.core_dhcp_options_options) > 0
  #   error_message = "If provided, the variable 'core_dhcp_options_options' must contain at least one DHCP option configuration."
  # }
}

variable "core_dhcp_options_vcn_id" {
  description = "The OCID of the VCN the set of DHCP options belongs to."
  default     = ""
}

variable "core_dhcp_options_display_name" {
  description = "(Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  default     = null
}

variable "core_dhcp_options_freeform_tags" {
  description = "(Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags."
  default     = {}
}

variable "core_dhcp_options_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Dhcp Options * update - (Defaults to 20 minutes), when updating the Dhcp Options * delete - (Defaults to 20 minutes), when destroying the Dhcp Options"
  default     = {}
}

#-----------------------------------------------------------
# core service gateway
#-----------------------------------------------------------
variable "enable_core_service_gateway" {
  description = "Enable core service gateway usages"
  default     = false
}

variable "core_service_gateway_compartment_id" {
  description = "(Required) (Updatable) The OCID of the compartment to contain the service gateway."
  default     = null
}

variable "core_service_gateway_services" {
  description = "(Required) (Updatable) List of the OCIDs of the Service objects to enable for the service gateway. This list can be empty if you don't want to enable any Service objects when you create the gateway. You can enable a Service object later by using either AttachServiceId or UpdateServiceGateway."
  default     = []
}

variable "core_service_gateway_vcn_id" {
  description = "The OCID of the VCN."
  default     = ""
}

variable "core_service_gateway_display_name" {
  description = "(Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  default     = null
}

variable "core_service_gateway_route_table_id" {
  description = "(Optional) (Updatable) The OCID of the route table the service gateway will use."
  default     = null
}

variable "core_service_gateway_freeform_tags" {
  description = "(Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags"
  default     = {}
}

variable "core_service_gateway_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Service Gateway * update - (Defaults to 20 minutes), when updating the Service Gateway * delete - (Defaults to 20 minutes), when destroying the Service Gateway"
  default     = {}
}

#-----------------------------------------------------------
# core nat gateway
#-----------------------------------------------------------
variable "enable_core_nat_gateway" {
  description = "Enable core nat gateway usages"
  default     = false
}

variable "core_nat_gateway_compartment_id" {
  description = "Required) (Updatable) The OCID of the compartment to contain the NAT gateway."
  default     = null
}

variable "core_nat_gateway_vcn_id" {
  description = "(Required) The OCID of the VCN the gateway belongs to."
  default     = ""
}

variable "core_nat_gateway_block_traffic" {
  description = "(Optional) (Updatable) Whether the NAT gateway blocks traffic through it. The default is false. Example: true"
  default     = null
}

variable "core_nat_gateway_display_name" {
  description = "(Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  default     = null
}

variable "core_nat_gateway_public_ip_id" {
  description = "(Optional) The OCID of the public IP address associated with the NAT gateway."
  default     = null
}

variable "core_nat_gateway_route_table_id" {
  description = "(Optional) (Updatable) The OCID of the route table used by the NAT gateway."
  default     = null
}

variable "core_nat_gateway_freeform_tags" {
  description = "(Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags."
  default     = {}
}

variable "core_nat_gateway_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Nat Gateway * update - (Defaults to 20 minutes), when updating the Nat Gateway * delete - (Defaults to 20 minutes), when destroying the Nat Gateway"
  default     = {}
}

#-----------------------------------------------------------
# core internet gateway
#-----------------------------------------------------------
variable "enable_core_internet_gateway" {
  description = "Enable core internet gateway usages"
  default     = false
}

variable "core_internet_gateway_compartment_id" {
  description = "(Required) (Updatable) The OCID of the compartment to contain the internet gateway."
  default     = null
}

variable "core_internet_gateway_vcn_id" {
  description = "The OCID of the VCN the Internet Gateway is attached to."
  default     = ""
}

variable "core_internet_gateway_enabled" {
  description = "(Optional) (Updatable) Whether the gateway is enabled upon creation."
  default     = null
}

variable "core_internet_gateway_display_name" {
  description = "(Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  default     = null
}

variable "core_internet_gateway_route_table_id" {
  description = "(Optional) (Updatable) The OCID of the route table the Internet Gateway is using."
  default     = null
}

variable "core_internet_gateway_freeform_tags" {
  description = "(Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags."
  default     = {}
}

variable "core_internet_gateway_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Internet Gateway * update - (Defaults to 20 minutes), when updating the Internet Gateway * delete - (Defaults to 20 minutes), when destroying the Internet Gateway"
  default     = {}
}

#-----------------------------------------------------------
# core ipv6
#-----------------------------------------------------------
variable "enable_core_ipv6" {
  description = "Enable core ipv6 usages"
  default     = false
}

variable "core_ipv6_vnic_id" {
  description = "(Updatable) The OCID of the VNIC to assign the IPv6 to. The IPv6 will be in the VNIC's subnet."
  default     = null
}

variable "core_ipv6_display_name" {
  description = "(Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  default     = null
}

variable "core_ipv6_ip_address" {
  description = "(Optional) An IPv6 address of your choice. Must be an available IP address within the subnet's CIDR. If you don't specify a value, Oracle automatically assigns an IPv6 address from the subnet. The subnet is the one that contains the VNIC you specify in vnicId. Example: 2001:DB8::"
  default     = null
}

variable "core_ipv6_ipv6subnet_cidr" {
  description = "(Optional) The IPv6 prefix allocated to the subnet. This is required if more than one IPv6 prefix exists on the subnet."
  default     = null
}

variable "core_ipv6_freeform_tags" {
  description = "(Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags."
  default     = {}
}

variable "core_ipv6_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Ipv6 * update - (Defaults to 20 minutes), when updating the Ipv6 * delete - (Defaults to 20 minutes), when destroying the Ipv6"
  default     = {}
}

#-----------------------------------------------------------
# core local peering gateway
#-----------------------------------------------------------
variable "enable_core_local_peering_gateway" {
  description = "enable_core_local_peering_gateway usages"
  default     = false
}

variable "core_local_peering_gateway_compartment_id" {
  description = "(Required) (Updatable) The OCID of the compartment containing the local peering gateway (LPG)."
  default     = null
}

variable "core_local_peering_gateway_vcn_id" {
  description = "The OCID of the VCN the LPG belongs to."
  default     = ""
}

variable "core_local_peering_gateway_display_name" {
  description = "(Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  default     = null
}

variable "core_local_peering_gateway_peer_id" {
  description = "(Optional) The OCID of the LPG you want to peer with. Specifying a peer_id connects this local peering gateway (LPG) to another one in the same region. This operation must be called by the VCN administrator who is designated as the requestor in the peering relationship. The acceptor must implement an Identity and Access Management (IAM) policy that gives the requestor permission to connect to LPGs in the acceptor's compartment. Without that permission, this operation will fail. For more information, see VCN Peering."
  default     = null
}

variable "core_local_peering_gateway_route_table_id" {
  description = "(Optional) (Updatable) The OCID of the route table the LPG will use."
  default     = ""
}

variable "core_local_peering_gateway_freeform_tags" {
  description = "(Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. "
  default     = {}
}

variable "core_local_peering_gateway_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Local Peering Gateway * update - (Defaults to 20 minutes), when updating the Local Peering Gateway * delete - (Defaults to 20 minutes), when destroying the Local Peering Gateway"
  default     = {}
}

