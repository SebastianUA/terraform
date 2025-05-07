#-----------------------------------------------------------
# core vcn
#-----------------------------------------------------------
output "core_vcn_id" {
  description = "The VCN's Oracle ID (OCID)."
  value       = element(concat(oci_core_vcn.core_vcn.*.id, [""]), 0)
}

output "core_vcn_ipv6cidr_blocks" {
  description = "For an IPv6-enabled VCN, this is the list of IPv6 prefixes for the VCN's IP address space. The prefixes are provided by Oracle and the sizes are always /56."
  value       = element(concat(oci_core_vcn.core_vcn.*.ipv6cidr_blocks, [""]), 0)
}

output "core_vcn_ipv6private_cidr_blocks" {
  description = "For an IPv6-enabled VCN, this is the list of Private IPv6 prefixes for the VCN's IP address space."
  value       = element(concat(oci_core_vcn.core_vcn.*.ipv6private_cidr_blocks, [""]), 0)
}

output "core_vcn_security_attributes" {
  description = "Security Attributes for this resource. This is unique to ZPR, and helps identify which resources are allowed to be accessed by what permission controls."
  value       = concat(oci_core_vcn.core_vcn.*.security_attributes, [""])
}

output "core_vcn_state" {
  description = "The VCN's current state."
  value       = element(concat(oci_core_vcn.core_vcn.*.state, [""]), 0)
}

output "core_vcn_time_created" {
  description = "The date and time the VCN was created, in the format defined by RFC3339. Example: 2016-08-25T21:10:29.600Z"
  value       = element(concat(oci_core_vcn.core_vcn.*.time_created, [""]), 0)
}

output "core_vcn_vcn_domain_name" {
  description = "The VCN's domain name, which consists of the VCN's DNS label, and the oraclevcn.com domain."
  value       = element(concat(oci_core_vcn.core_vcn.*.vcn_domain_name, [""]), 0)
}

output "core_vcn_cidr_blocks" {
  description = "The list of IPv4 CIDR blocks the VCN will use."
  value       = element(concat(oci_core_vcn.core_vcn.*.cidr_blocks, [""]), 0)
}

output "core_vcn_compartment_id" {
  description = "The OCID of the compartment containing the VCN."
  value       = element(concat(oci_core_vcn.core_vcn.*.compartment_id, [""]), 0)
}

output "core_vcn_default_dhcp_options_id" {
  description = "The OCID for the VCN's default set of DHCP options."
  value       = element(concat(oci_core_vcn.core_vcn.*.default_dhcp_options_id, [""]), 0)
}

output "core_vcn_default_route_table_id" {
  description = "The OCID for the VCN's default route table."
  value       = element(concat(oci_core_vcn.core_vcn.*.default_route_table_id, [""]), 0)
}

output "core_vcn_default_security_list_id" {
  description = "The OCID for the VCN's default security list."
  value       = element(concat(oci_core_vcn.core_vcn.*.default_security_list_id, [""]), 0)
}

output "core_vcn_display_name" {
  description = "A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  value       = element(concat(oci_core_vcn.core_vcn.*.display_name, [""]), 0)
}

output "core_vcn_dns_label" {
  description = "A DNS label for the VCN, used in conjunction with the VNIC's hostname and subnet's DNS label to form a fully qualified domain name (FQDN) for each VNIC within this subnet (for example, bminstance1.subnet123.vcn1.oraclevcn.com). Must be an alphanumeric string that begins with a letter. The value cannot be changed."
  value       = element(concat(oci_core_vcn.core_vcn.*.dns_label, [""]), 0)
}

output "core_vcn_byoipv6cidr_blocks" {
  description = "The list of BYOIPv6 prefixes required to create a VCN that uses BYOIPv6 ranges."
  value       = element(concat(oci_core_vcn.core_vcn.*.byoipv6cidr_blocks, [""]), 0)
}

#-----------------------------------------------------------
# core private ip
#-----------------------------------------------------------
output "core_private_ip_id" {
  description = "The private IP's Oracle ID (OCID)."
  value       = element(concat(oci_core_private_ip.core_private_ip.*.id, [""]), 0)
}

output "core_private_ip_is_primary" {
  description = "Whether this private IP is the primary one on the VNIC. Primary private IPs are unassigned and deleted automatically when the VNIC is terminated. Example: true"
  value       = element(concat(oci_core_private_ip.core_private_ip.*.is_primary, [""]), 0)
}

output "core_private_ip_is_reserved" {
  description = "true if the IP is reserved and can exist detached from vnic"
  value       = element(concat(oci_core_private_ip.core_private_ip.*.is_reserved, [""]), 0)
}

output "core_private_ip_subnet_id" {
  description = "The OCID of the subnet the VNIC is in."
  value       = concat(oci_core_private_ip.core_private_ip.*.subnet_id, [""])
}

output "core_private_ip_vlan_id" {
  description = "Applicable only if the PrivateIp object is being used with a VLAN as part of the Oracle Cloud VMware Solution. The vlanId is the OCID of the VLAN. See Vlan."
  value       = element(concat(oci_core_private_ip.core_private_ip.*.vlan_id, [""]), 0)
}

output "core_private_ip_vnic_id" {
  description = "The OCID of the VNIC the private IP is assigned to. The VNIC and private IP must be in the same subnet. However, if the PrivateIp object is being used with a VLAN as part of the Oracle Cloud VMware Solution, the vnicId is null."
  value       = element(concat(oci_core_private_ip.core_private_ip.*.vnic_id, [""]), 0)
}

output "core_private_ip_hostname_label" {
  description = "The hostname for the private IP. Used for DNS. The value is the hostname portion of the private IP's fully qualified domain name (FQDN) (for example, bminstance1 in FQDN bminstance1.subnet123.vcn1.oraclevcn.com). Must be unique across all VNICs in the subnet and comply with RFC 952 and RFC 1123."
  value       = element(concat(oci_core_private_ip.core_private_ip.*.hostname_label, [""]), 0)
}

output "core_private_ip_ip_address" {
  description = "The private IP address of the privateIp object. The address is within the CIDR of the VNIC's subnet."
  value       = element(concat(oci_core_private_ip.core_private_ip.*.ip_address, [""]), 0)
}

output "core_private_ip_availability_domain" {
  description = "The private IP's availability domain. This attribute will be null if this is a secondary private IP assigned to a VNIC that is in a regional subnet. Example: Uocm:PHX-AD-1"
  value       = element(concat(oci_core_private_ip.core_private_ip.*.availability_domain, [""]), 0)
}

output "core_private_ip_compartment_id" {
  description = "The OCID of the compartment containing the private IP."
  value       = element(concat(oci_core_private_ip.core_private_ip.*.compartment_id, [""]), 0)
}

output "core_private_ip_display_name" {
  description = "A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  value       = element(concat(oci_core_private_ip.core_private_ip.*.display_name, [""]), 0)
}

#-----------------------------------------------------------
# core public ip pool capacity
#-----------------------------------------------------------
output "core_public_ip_pool_capacity_public_ip_pool_id" {
  description = "The OCID of the pool object"
  value       = element(concat(oci_core_public_ip_pool_capacity.core_public_ip_pool_capacity.*.public_ip_pool_id, [""]), 0)
}

output "core_public_ip_pool_capacity_byoip_id" {
  description = "The OCID of the Byoip Range Id object"
  value       = element(concat(oci_core_public_ip_pool_capacity.core_public_ip_pool_capacity.*.byoip_id, [""]), 0)
}

output "core_public_ip_pool_capacity_cidr_block" {
  description = "The CIDR IP address range to be added to the Public Ip Pool"
  value       = element(concat(oci_core_public_ip_pool_capacity.core_public_ip_pool_capacity.*.cidr_block, [""]), 0)
}

#-----------------------------------------------------------
# core public ip pool
#-----------------------------------------------------------
output "core_public_ip_pool_id" {
  description = "The OCID of the public IP pool."
  value       = element(concat(oci_core_public_ip_pool.core_public_ip_pool.*.id, [""]), 0)
}

output "core_public_ip_pool_state" {
  description = "The public IP pool's current state."
  value       = element(concat(oci_core_public_ip_pool.core_public_ip_pool.*.state, [""]), 0)
}

output "core_public_ip_pool_cidr_blocks" {
  description = "The CIDR blocks added to this pool. This could be all or a portion of a BYOIP CIDR block."
  value       = concat(oci_core_public_ip_pool.core_public_ip_pool.*.cidr_blocks, [""])
}

output "core_public_ip_pool_compartment_id" {
  description = "The OCID of the compartment containing this pool."
  value       = element(concat(oci_core_public_ip_pool.core_public_ip_pool.*.compartment_id, [""]), 0)
}

output "core_public_ip_pool_display_name" {
  description = "A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  value       = element(concat(oci_core_public_ip_pool.core_public_ip_pool.*.display_name, [""]), 0)
}

#-----------------------------------------------------------
# core public ip
#-----------------------------------------------------------
output "core_public_ip_id" {
  description = "The public IP's Oracle ID (OCID)."
  value       = element(concat(oci_core_public_ip.core_public_ip.*.id, [""]), 0)
}

output "core_public_ip_assigned_entity_id" {
  description = "The OCID of the entity the public IP is assigned to, or in the process of being assigned to."
  value       = element(concat(oci_core_public_ip.core_public_ip.*.assigned_entity_id, [""]), 0)
}

output "core_public_ip_assigned_entity_type" {
  description = "The type of entity the public IP is assigned to, or in the process of being assigned to."
  value       = element(concat(oci_core_public_ip.core_public_ip.*.assigned_entity_type, [""]), 0)
}

output "core_public_ip_availability_domain" {
  description = "The public IP's availability domain. This property is set only for ephemeral public IPs that are assigned to a private IP (that is, when the scope of the public IP is set to AVAILABILITY_DOMAIN). The value is the availability domain of the assigned private IP. Example: Uocm:PHX-AD-1"
  value       = element(concat(oci_core_public_ip.core_public_ip.*.availability_domain, [""]), 0)
}

output "core_public_ip_compartment_id" {
  description = "The OCID of the compartment containing the public IP. For an ephemeral public IP, this is the compartment of its assigned entity (which can be a private IP or a regional entity such as a NAT gateway). For a reserved public IP that is currently assigned, its compartment can be different from the assigned private IP's."
  value       = element(concat(oci_core_public_ip.core_public_ip.*.compartment_id, [""]), 0)
}

output "core_public_ip_ip_address" {
  description = "The public IP address of the publicIp object. Example: 203.0.113.2"
  value       = element(concat(oci_core_public_ip.core_public_ip.*.ip_address, [""]), 0)
}

output "core_public_ip_lifetime" {
  description = "Defines when the public IP is deleted and released back to Oracle's public IP pool."
  value       = element(concat(oci_core_public_ip.core_public_ip.*.lifetime, [""]), 0)
}

output "core_public_ip_display_name" {
  description = "A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  value       = element(concat(oci_core_public_ip.core_public_ip.*.display_name, [""]), 0)
}

output "core_public_ip_state" {
  description = "The public IP's current state."
  value       = element(concat(oci_core_public_ip.core_public_ip.*.state, [""]), 0)
}

output "core_public_ip_public_ip_pool_id" {
  description = "The OCID of the pool object created in the current tenancy."
  value       = element(concat(oci_core_public_ip.core_public_ip.*.public_ip_pool_id, [""]), 0)
}

output "core_public_ip_scope" {
  description = "Whether the public IP is regional or specific to a particular availability domain."
  value       = concat(oci_core_public_ip.core_public_ip.*.scope, [""])
}

#-----------------------------------------------------------
# core route table
#-----------------------------------------------------------
output "core_route_table_id" {
  description = "ID of core route table"
  value       = element(concat(oci_core_route_table.core_route_table.*.id, [""]), 0)
}

output "core_route_table_state" {
  description = "The route table's current state."
  value       = element(concat(oci_core_route_table.core_route_table.*.state, [""]), 0)
}

output "core_route_table_vcn_id" {
  description = "The OCID of the VCN the route table list belongs to."
  value       = element(concat(oci_core_route_table.core_route_table.*.vcn_id, [""]), 0)
}

output "core_route_table_route_rules" {
  description = "The collection of rules for routing destination IPs to network devices."
  value       = concat(oci_core_route_table.core_route_table.*.route_rules, [""])
}

output "core_route_table_compartment_id" {
  description = "The OCID of the compartment containing the route table."
  value       = element(concat(oci_core_route_table.core_route_table.*.compartment_id, [""]), 0)
}

output "core_route_table_display_name" {
  description = "A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  value       = element(concat(oci_core_route_table.core_route_table.*.display_name, [""]), 0)
}

// publics
output "core_route_table_publics_id" {
  description = "ID of core route table"
  value       = element(concat(oci_core_route_table.core_route_table_publics.*.id, [""]), 0)
}

output "core_route_table_publics_state" {
  description = "The route table's current state."
  value       = element(concat(oci_core_route_table.core_route_table_publics.*.state, [""]), 0)
}

output "core_route_table_publics_vcn_id" {
  description = "The OCID of the VCN the route table list belongs to."
  value       = element(concat(oci_core_route_table.core_route_table_publics.*.vcn_id, [""]), 0)
}

output "core_route_table_publics_route_rules" {
  description = "The collection of rules for routing destination IPs to network devices."
  value       = concat(oci_core_route_table.core_route_table_publics.*.route_rules, [""])
}

output "core_route_table_publics_compartment_id" {
  description = "The OCID of the compartment containing the route table."
  value       = element(concat(oci_core_route_table.core_route_table_publics.*.compartment_id, [""]), 0)
}

output "core_route_table_publics_display_name" {
  description = "A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  value       = element(concat(oci_core_route_table.core_route_table_publics.*.display_name, [""]), 0)
}

// privates
output "core_route_table_privates_id" {
  description = "ID of core route table"
  value       = element(concat(oci_core_route_table.core_route_table_privates.*.id, [""]), 0)
}

output "core_route_table_privates_state" {
  description = "The route table's current state."
  value       = element(concat(oci_core_route_table.core_route_table_privates.*.state, [""]), 0)
}

output "core_route_table_privates_vcn_id" {
  description = "The OCID of the VCN the route table list belongs to."
  value       = element(concat(oci_core_route_table.core_route_table_privates.*.vcn_id, [""]), 0)
}

output "core_route_table_privates_route_rules" {
  description = "The collection of rules for routing destination IPs to network devices."
  value       = concat(oci_core_route_table.core_route_table_privates.*.route_rules, [""])
}

output "core_route_table_privates_compartment_id" {
  description = "The OCID of the compartment containing the route table."
  value       = element(concat(oci_core_route_table.core_route_table_privates.*.compartment_id, [""]), 0)
}

output "core_route_table_privates_display_name" {
  description = "A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  value       = element(concat(oci_core_route_table.core_route_table_privates.*.display_name, [""]), 0)
}

#-----------------------------------------------------------
# core route table attachment
#-----------------------------------------------------------
output "core_route_table_attachment_id" {
  description = "ID of core route table attachment"
  value       = element(concat(oci_core_route_table_attachment.core_route_table_attachment.*.id, [""]), 0)
}

output "core_route_table_attachment_subnet_id" {
  description = "The OCID of the subnet."
  value       = element(concat(oci_core_route_table_attachment.core_route_table_attachment.*.subnet_id, [""]), 0)
}

output "core_route_table_attachment_route_table_id" {
  description = "The OCID of the route table."
  value       = element(concat(oci_core_route_table_attachment.core_route_table_attachment.*.route_table_id, [""]), 0)
}

// publics
output "core_route_table_attachment_publics_id" {
  description = "ID of core route table attachment"
  value       = element(concat(oci_core_route_table_attachment.core_route_table_attachment_publics.*.id, [""]), 0)
}

output "core_route_table_attachment_publics_subnet_id" {
  description = "The OCID of the subnet."
  value       = concat(oci_core_route_table_attachment.core_route_table_attachment_publics.*.subnet_id, [""])
}

output "core_route_table_attachment_publics_route_table_id" {
  description = "The OCID of the route table."
  value       = element(concat(oci_core_route_table_attachment.core_route_table_attachment_publics.*.route_table_id, [""]), 0)
}

// privates
output "core_route_table_attachment_privates_id" {
  description = "ID of core route table attachment"
  value       = element(concat(oci_core_route_table_attachment.core_route_table_attachment_privates.*.id, [""]), 0)
}

output "core_route_table_attachment_privates_subnet_id" {
  description = "The OCID of the subnet."
  value       = concat(oci_core_route_table_attachment.core_route_table_attachment_privates.*.subnet_id, [""])
}

output "core_route_table_attachment_privates_route_table_id" {
  description = "The OCID of the route table."
  value       = element(concat(oci_core_route_table_attachment.core_route_table_attachment_privates.*.route_table_id, [""]), 0)
}

#-----------------------------------------------------------
# core vlan
#-----------------------------------------------------------
output "core_vlan_id" {
  description = "The VLAN's Oracle ID (OCID)."
  value       = element(concat(oci_core_vlan.core_vlan.*.id, [""]), 0)
}

output "core_vlan_availability_domain" {
  description = "The VLAN's availability domain. This attribute will be null if this is a regional VLAN rather than an AD-specific VLAN. Example: Uocm:PHX-AD-1"
  value       = element(concat(oci_core_vlan.core_vlan.*.availability_domain, [""]), 0)
}

output "core_vlan_cidr_block" {
  description = "The range of IPv4 addresses that will be used for layer 3 communication with hosts outside the VLAN. Example: 192.168.1.0/24"
  value       = element(concat(oci_core_vlan.core_vlan.*.cidr_block, [""]), 0)
}

output "core_vlan_compartment_id" {
  description = "The OCID of the compartment containing the VLAN."
  value       = element(concat(oci_core_vlan.core_vlan.*.compartment_id, [""]), 0)
}

output "core_vlan_display_name" {
  description = "A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  value       = element(concat(oci_core_vlan.core_vlan.*.display_name, [""]), 0)
}

output "core_vlan_nsg_ids" {
  description = "A list of the OCIDs of the network security groups (NSGs) to use with this VLAN. All VNICs in the VLAN belong to these NSGs. For more information about NSGs, see NetworkSecurityGroup."
  value       = concat(oci_core_vlan.core_vlan.*.nsg_ids, [""])
}

output "core_vlan_route_table_id" {
  description = "The OCID of the route table that the VLAN uses."
  value       = element(concat(oci_core_vlan.core_vlan.*.route_table_id, [""]), 0)
}

output "core_vlan_state" {
  description = "The VLAN's current state."
  value       = element(concat(oci_core_vlan.core_vlan.*.state, [""]), 0)
}

output "core_vlan_vcn_id" {
  description = "The OCID of the VCN the VLAN is in."
  value       = element(concat(oci_core_vlan.core_vlan.*.vcn_id, [""]), 0)
}

output "core_vlan_vlan_tag" {
  description = "The IEEE 802.1Q VLAN tag of this VLAN. Example: 100"
  value       = element(concat(oci_core_vlan.core_vlan.*.vlan_tag, [""]), 0)
}

#-----------------------------------------------------------
# core vnic attachment
#-----------------------------------------------------------
output "core_vnic_attachment_id" {
  description = "The OCID of the VNIC attachment."
  value       = element(concat(oci_core_vnic_attachment.core_vnic_attachment.*.id, [""]), 0)
}

output "core_vnic_attachment_state" {
  description = "The current state of the VNIC attachment."
  value       = element(concat(oci_core_vnic_attachment.core_vnic_attachment.*.state, [""]), 0)
}

output "core_vnic_attachment_subnet_id" {
  description = "The OCID of the subnet to create the VNIC in."
  value       = element(concat(oci_core_vnic_attachment.core_vnic_attachment.*.subnet_id, [""]), 0)
}

output "core_vnic_attachment_vlan_id" {
  description = "The OCID of the VLAN to create the VNIC in. Creating the VNIC in a VLAN (instead of a subnet) is possible only if you are an Oracle Cloud VMware Solution customer. See Vlan."
  value       = element(concat(oci_core_vnic_attachment.core_vnic_attachment.*.vlan_id, [""]), 0)
}

output "core_vnic_attachment_vlan_tag" {
  description = "The Oracle-assigned VLAN tag of the attached VNIC. Available after the attachment process is complete."
  value       = element(concat(oci_core_vnic_attachment.core_vnic_attachment.*.vlan_tag, [""]), 0)
}

output "core_vnic_attachment_vnic_id" {
  description = "The OCID of the VNIC. Available after the attachment process is complete."
  value       = element(concat(oci_core_vnic_attachment.core_vnic_attachment.*.vnic_id, [""]), 0)
}

output "core_vnic_attachment_availability_domain" {
  description = "The availability domain of the instance. Example: Uocm:PHX-AD-1"
  value       = element(concat(oci_core_vnic_attachment.core_vnic_attachment.*.availability_domain, [""]), 0)
}

output "core_vnic_attachment_compartment_id" {
  description = "The OCID of the compartment the VNIC attachment is in, which is the same compartment the instance is in."
  value       = element(concat(oci_core_vnic_attachment.core_vnic_attachment.*.compartment_id, [""]), 0)
}

output "core_vnic_attachment_display_name" {
  description = "A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  value       = element(concat(oci_core_vnic_attachment.core_vnic_attachment.*.display_name, [""]), 0)
}

output "core_vnic_attachment_instance_id" {
  description = "The OCID of the instance."
  value       = element(concat(oci_core_vnic_attachment.core_vnic_attachment.*.instance_id, [""]), 0)
}

output "core_vnic_attachment_nic_index" {
  description = "Which physical network interface card (NIC) the VNIC uses. Certain bare metal instance shapes have two active physical NICs (0 and 1). If you add a secondary VNIC to one of these instances, you can specify which NIC the VNIC will use. For more information, see Virtual Network Interface Cards (VNICs)."
  value       = element(concat(oci_core_vnic_attachment.core_vnic_attachment.*.nic_index, [""]), 0)
}

#-----------------------------------------------------------
# core subnet
#-----------------------------------------------------------
output "core_subnet_id" {
  description = "The subnet's Oracle ID (OCID)."
  value       = element(concat(oci_core_subnet.core_subnet.*.id, [""]), 0)
}

output "core_subnet_availability_domain" {
  description = "The subnet's availability domain. This attribute will be null if this is a regional subnet instead of an AD-specific subnet. Oracle recommends creating regional subnets. Example: Uocm:PHX-AD-1"
  value       = element(concat(oci_core_subnet.core_subnet.*.availability_domain, [""]), 0)
}

output "core_subnet_cidr_block" {
  description = "The subnet's CIDR block. Example: 10.0.1.0/24"
  value       = element(concat(oci_core_subnet.core_subnet.*.cidr_block, [""]), 0)
}

output "core_subnet_compartment_id" {
  description = "The OCID of the compartment containing the subnet."
  value       = element(concat(oci_core_subnet.core_subnet.*.compartment_id, [""]), 0)
}

output "core_subnet_dhcp_options_id" {
  description = "The OCID of the set of DHCP options that the subnet uses."
  value       = element(concat(oci_core_subnet.core_subnet.*.dhcp_options_id, [""]), 0)
}

output "core_subnet_display_name" {
  description = "A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  value       = element(concat(oci_core_subnet.core_subnet.*.display_name, [""]), 0)
}

output "core_subnet_dns_label" {
  description = "A DNS label for the subnet, used in conjunction with the VNIC's hostname and VCN's DNS label to form a fully qualified domain name (FQDN) for each VNIC within this subnet (for example, bminstance1.subnet123.vcn1.oraclevcn.com). Must be an alphanumeric string that begins with a letter and is unique within the VCN. The value cannot be changed."
  value       = element(concat(oci_core_subnet.core_subnet.*.dns_label, [""]), 0)
}

output "core_subnet_ipv6cidr_block" {
  description = "For an IPv6-enabled subnet, this is the IPv6 prefix for the subnet's IP address space. The subnet size is always /64. See IPv6 Addresses. Example: 2001:0db8:0123:1111::/64"
  value       = element(concat(oci_core_subnet.core_subnet.*.ipv6cidr_block, [""]), 0)
}

output "core_subnet_ipv6cidr_blocks" {
  description = "The list of all IPv6 prefixes (Oracle allocated IPv6 GUA, ULA or private IPv6 prefixes, BYOIPv6 prefixes) for the subnet."
  value       = element(concat(oci_core_subnet.core_subnet.*.ipv6cidr_blocks, [""]), 0)
}

output "core_subnet_ipv6virtual_router_ip" {
  description = "For an IPv6-enabled subnet, this is the IPv6 address of the virtual router. Example: 2001:0db8:0123:1111:89ab:cdef:1234:5678"
  value       = element(concat(oci_core_subnet.core_subnet.*.ipv6virtual_router_ip, [""]), 0)
}

output "core_subnet_prohibit_internet_ingress" {
  description = "Whether to disallow ingress internet traffic to VNICs within this subnet. Defaults to false."
  value       = element(concat(oci_core_subnet.core_subnet.*.prohibit_internet_ingress, [""]), 0)
}

output "core_subnet_prohibit_public_ip_on_vnic" {
  description = "Whether VNICs within this subnet can have public IP addresses. Defaults to false, which means VNICs created in this subnet will automatically be assigned public IP addresses unless specified otherwise during instance launch or VNIC creation (with the assignPublicIp flag in CreateVnicDetails). If prohibitPublicIpOnVnic is set to true, VNICs created in this subnet cannot have public IP addresses (that is, it's a private subnet). Example: true"
  value       = element(concat(oci_core_subnet.core_subnet.*.prohibit_public_ip_on_vnic, [""]), 0)
}

output "core_subnet_route_table_id" {
  description = "The OCID of the route table that the subnet uses."
  value       = element(concat(oci_core_subnet.core_subnet.*.route_table_id, [""]), 0)
}

output "core_subnet_security_list_ids" {
  description = "The OCIDs of the security list or lists that the subnet uses. Remember that security lists are associated with the subnet, but the rules are applied to the individual VNICs in the subnet."
  value       = element(concat(oci_core_subnet.core_subnet.*.security_list_ids, [""]), 0)
}

output "core_subnet_state" {
  description = "The subnet's current state."
  value       = element(concat(oci_core_subnet.core_subnet.*.state, [""]), 0)
}

output "core_subnet_subnet_domain_name" {
  description = "The subnet's domain name, which consists of the subnet's DNS label, the VCN's DNS label, and the oraclevcn.com domain."
  value       = element(concat(oci_core_subnet.core_subnet.*.subnet_domain_name, [""]), 0)
}

output "core_subnet_vcn_id" {
  description = "The OCID of the VCN the subnet is in."
  value       = element(concat(oci_core_subnet.core_subnet.*.vcn_id, [""]), 0)
}

output "core_subnet_virtual_router_ip" {
  description = "The IP address of the virtual router. Example: 10.0.14.1"
  value       = element(concat(oci_core_subnet.core_subnet.*.virtual_router_ip, [""]), 0)
}

output "core_subnet_virtual_router_mac" {
  description = "The MAC address of the virtual router. Example: 00:00:00:00:00:01"
  value       = element(concat(oci_core_subnet.core_subnet.*.virtual_router_mac, [""]), 0)
}

// privates
output "core_subnet_privates_id" {
  description = "The subnet's Oracle ID (OCID)."
  value       = concat(oci_core_subnet.core_subnet_privates.*.id, [""])
}

output "core_subnet_privates_availability_domain" {
  description = "The subnet's availability domain. This attribute will be null if this is a regional subnet instead of an AD-specific subnet. Oracle recommends creating regional subnets. Example: Uocm:PHX-AD-1"
  value       = element(concat(oci_core_subnet.core_subnet_privates.*.availability_domain, [""]), 0)
}

output "core_subnet_privates_cidr_block" {
  description = "The subnet's CIDR block. Example: 10.0.1.0/24"
  value       = element(concat(oci_core_subnet.core_subnet_privates.*.cidr_block, [""]), 0)
}

output "core_subnet_privates_compartment_id" {
  description = "The OCID of the compartment containing the subnet."
  value       = element(concat(oci_core_subnet.core_subnet_privates.*.compartment_id, [""]), 0)
}

output "core_subnet_privates_dhcp_options_id" {
  description = "The OCID of the set of DHCP options that the subnet uses."
  value       = element(concat(oci_core_subnet.core_subnet_privates.*.dhcp_options_id, [""]), 0)
}

output "core_subnet_privates_display_name" {
  description = "A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  value       = element(concat(oci_core_subnet.core_subnet_privates.*.display_name, [""]), 0)
}

output "core_subnet_privates_dns_label" {
  description = "A DNS label for the subnet, used in conjunction with the VNIC's hostname and VCN's DNS label to form a fully qualified domain name (FQDN) for each VNIC within this subnet (for example, bminstance1.subnet123.vcn1.oraclevcn.com). Must be an alphanumeric string that begins with a letter and is unique within the VCN. The value cannot be changed."
  value       = element(concat(oci_core_subnet.core_subnet_privates.*.dns_label, [""]), 0)
}

output "core_subnet_privates_ipv6cidr_block" {
  description = "For an IPv6-enabled subnet, this is the IPv6 prefix for the subnet's IP address space. The subnet size is always /64. See IPv6 Addresses. Example: 2001:0db8:0123:1111::/64"
  value       = element(concat(oci_core_subnet.core_subnet_privates.*.ipv6cidr_block, [""]), 0)
}

output "core_subnet_privates_ipv6cidr_blocks" {
  description = "The list of all IPv6 prefixes (Oracle allocated IPv6 GUA, ULA or private IPv6 prefixes, BYOIPv6 prefixes) for the subnet."
  value       = element(concat(oci_core_subnet.core_subnet_privates.*.ipv6cidr_blocks, [""]), 0)
}

output "core_subnet_privates_ipv6virtual_router_ip" {
  description = "For an IPv6-enabled subnet, this is the IPv6 address of the virtual router. Example: 2001:0db8:0123:1111:89ab:cdef:1234:5678"
  value       = element(concat(oci_core_subnet.core_subnet_privates.*.ipv6virtual_router_ip, [""]), 0)
}

output "core_subnet_privates_prohibit_internet_ingress" {
  description = "Whether to disallow ingress internet traffic to VNICs within this subnet. Defaults to false."
  value       = element(concat(oci_core_subnet.core_subnet_privates.*.prohibit_internet_ingress, [""]), 0)
}

output "core_subnet_privates_prohibit_public_ip_on_vnic" {
  description = "Whether VNICs within this subnet can have public IP addresses. Defaults to false, which means VNICs created in this subnet will automatically be assigned public IP addresses unless specified otherwise during instance launch or VNIC creation (with the assignPublicIp flag in CreateVnicDetails). If prohibitPublicIpOnVnic is set to true, VNICs created in this subnet cannot have public IP addresses (that is, it's a private subnet). Example: true"
  value       = element(concat(oci_core_subnet.core_subnet_privates.*.prohibit_public_ip_on_vnic, [""]), 0)
}

output "core_subnet_privates_route_table_id" {
  description = "The OCID of the route table that the subnet uses."
  value       = element(concat(oci_core_subnet.core_subnet_privates.*.route_table_id, [""]), 0)
}

output "core_subnet_privates_security_list_ids" {
  description = "The OCIDs of the security list or lists that the subnet uses. Remember that security lists are associated with the subnet, but the rules are applied to the individual VNICs in the subnet."
  value       = element(concat(oci_core_subnet.core_subnet_privates.*.security_list_ids, [""]), 0)
}

output "core_subnet_privates_state" {
  description = "The subnet's current state."
  value       = element(concat(oci_core_subnet.core_subnet_privates.*.state, [""]), 0)
}

output "core_subnet_privates_subnet_domain_name" {
  description = "The subnet's domain name, which consists of the subnet's DNS label, the VCN's DNS label, and the oraclevcn.com domain."
  value       = element(concat(oci_core_subnet.core_subnet_privates.*.subnet_domain_name, [""]), 0)
}

output "core_subnet_privates_vcn_id" {
  description = "The OCID of the VCN the subnet is in."
  value       = element(concat(oci_core_subnet.core_subnet_privates.*.vcn_id, [""]), 0)
}

output "core_subnet_privates_virtual_router_ip" {
  description = "The IP address of the virtual router. Example: 10.0.14.1"
  value       = element(concat(oci_core_subnet.core_subnet_privates.*.virtual_router_ip, [""]), 0)
}

output "core_subnet_privates_virtual_router_mac" {
  description = "The MAC address of the virtual router. Example: 00:00:00:00:00:01"
  value       = element(concat(oci_core_subnet.core_subnet_privates.*.virtual_router_mac, [""]), 0)
}

// publics
output "core_subnet_publics_id" {
  description = "The subnet's Oracle ID (OCID)."
  value       = concat(oci_core_subnet.core_subnet_publics.*.id, [""])
}

output "core_subnet_publics_availability_domain" {
  description = "The subnet's availability domain. This attribute will be null if this is a regional subnet instead of an AD-specific subnet. Oracle recommends creating regional subnets. Example: Uocm:PHX-AD-1"
  value       = element(concat(oci_core_subnet.core_subnet_publics.*.availability_domain, [""]), 0)
}

output "core_subnet_publics_cidr_block" {
  description = "The subnet's CIDR block. Example: 10.0.1.0/24"
  value       = element(concat(oci_core_subnet.core_subnet_publics.*.cidr_block, [""]), 0)
}

output "core_subnet_publics_compartment_id" {
  description = "The OCID of the compartment containing the subnet."
  value       = element(concat(oci_core_subnet.core_subnet_publics.*.compartment_id, [""]), 0)
}

output "core_subnet_publics_dhcp_options_id" {
  description = "The OCID of the set of DHCP options that the subnet uses."
  value       = element(concat(oci_core_subnet.core_subnet_publics.*.dhcp_options_id, [""]), 0)
}

output "core_subnet_publics_display_name" {
  description = "A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  value       = element(concat(oci_core_subnet.core_subnet_publics.*.display_name, [""]), 0)
}

output "core_subnet_publics_dns_label" {
  description = "A DNS label for the subnet, used in conjunction with the VNIC's hostname and VCN's DNS label to form a fully qualified domain name (FQDN) for each VNIC within this subnet (for example, bminstance1.subnet123.vcn1.oraclevcn.com). Must be an alphanumeric string that begins with a letter and is unique within the VCN. The value cannot be changed."
  value       = element(concat(oci_core_subnet.core_subnet_publics.*.dns_label, [""]), 0)
}

output "core_subnet_publics_ipv6cidr_block" {
  description = "For an IPv6-enabled subnet, this is the IPv6 prefix for the subnet's IP address space. The subnet size is always /64. See IPv6 Addresses. Example: 2001:0db8:0123:1111::/64"
  value       = element(concat(oci_core_subnet.core_subnet_publics.*.ipv6cidr_block, [""]), 0)
}

output "core_subnet_publics_ipv6cidr_blocks" {
  description = "The list of all IPv6 prefixes (Oracle allocated IPv6 GUA, ULA or private IPv6 prefixes, BYOIPv6 prefixes) for the subnet."
  value       = element(concat(oci_core_subnet.core_subnet_publics.*.ipv6cidr_blocks, [""]), 0)
}

output "core_subnet_publics_ipv6virtual_router_ip" {
  description = "For an IPv6-enabled subnet, this is the IPv6 address of the virtual router. Example: 2001:0db8:0123:1111:89ab:cdef:1234:5678"
  value       = element(concat(oci_core_subnet.core_subnet_publics.*.ipv6virtual_router_ip, [""]), 0)
}

output "core_subnet_publics_prohibit_internet_ingress" {
  description = "Whether to disallow ingress internet traffic to VNICs within this subnet. Defaults to false."
  value       = element(concat(oci_core_subnet.core_subnet_publics.*.prohibit_internet_ingress, [""]), 0)
}

output "core_subnet_publics_prohibit_public_ip_on_vnic" {
  description = "Whether VNICs within this subnet can have public IP addresses. Defaults to false, which means VNICs created in this subnet will automatically be assigned public IP addresses unless specified otherwise during instance launch or VNIC creation (with the assignPublicIp flag in CreateVnicDetails). If prohibitPublicIpOnVnic is set to true, VNICs created in this subnet cannot have public IP addresses (that is, it's a private subnet). Example: true"
  value       = element(concat(oci_core_subnet.core_subnet_publics.*.prohibit_public_ip_on_vnic, [""]), 0)
}

output "core_subnet_publics_route_table_id" {
  description = "The OCID of the route table that the subnet uses."
  value       = element(concat(oci_core_subnet.core_subnet_publics.*.route_table_id, [""]), 0)
}

output "core_subnet_publics_security_list_ids" {
  description = "The OCIDs of the security list or lists that the subnet uses. Remember that security lists are associated with the subnet, but the rules are applied to the individual VNICs in the subnet."
  value       = element(concat(oci_core_subnet.core_subnet_publics.*.security_list_ids, [""]), 0)
}

output "core_subnet_publics_state" {
  description = "The subnet's current state."
  value       = element(concat(oci_core_subnet.core_subnet_publics.*.state, [""]), 0)
}

output "core_subnet_publics_subnet_domain_name" {
  description = "The subnet's domain name, which consists of the subnet's DNS label, the VCN's DNS label, and the oraclevcn.com domain."
  value       = element(concat(oci_core_subnet.core_subnet_publics.*.subnet_domain_name, [""]), 0)
}

output "core_subnet_publics_vcn_id" {
  description = "The OCID of the VCN the subnet is in."
  value       = element(concat(oci_core_subnet.core_subnet_publics.*.vcn_id, [""]), 0)
}

output "core_subnet_publics_virtual_router_ip" {
  description = "The IP address of the virtual router. Example: 10.0.14.1"
  value       = element(concat(oci_core_subnet.core_subnet_publics.*.virtual_router_ip, [""]), 0)
}

output "core_subnet_publics_virtual_router_mac" {
  description = "The MAC address of the virtual router. Example: 00:00:00:00:00:01"
  value       = element(concat(oci_core_subnet.core_subnet_publics.*.virtual_router_mac, [""]), 0)
}

#-----------------------------------------------------------
# core dhcp options
#-----------------------------------------------------------
output "core_dhcp_options_id" {
  description = "Oracle ID (OCID) for the set of DHCP options."
  value       = element(concat(oci_core_dhcp_options.core_dhcp_options.*.id, [""]), 0)
}

output "core_dhcp_options_compartment_id" {
  description = "The OCID of the compartment containing the set of DHCP options."
  value       = element(concat(oci_core_dhcp_options.core_dhcp_options.*.compartment_id, [""]), 0)
}

output "core_dhcp_options_display_name" {
  description = "A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  value       = element(concat(oci_core_dhcp_options.core_dhcp_options.*.display_name, [""]), 0)
}

output "core_dhcp_options_domain_name_type" {
  description = "The search domain name type of DHCP options"
  value       = element(concat(oci_core_dhcp_options.core_dhcp_options.*.domain_name_type, [""]), 0)
}

output "core_dhcp_options_options" {
  description = "The collection of individual DHCP options."
  value       = concat(oci_core_dhcp_options.core_dhcp_options.*.options, [""])
}

output "core_dhcp_options_state" {
  description = "The current state of the set of DHCP options."
  value       = element(concat(oci_core_dhcp_options.core_dhcp_options.*.state, [""]), 0)
}

output "core_dhcp_options_vcn_id" {
  description = "The OCID of the VCN the set of DHCP options belongs to."
  value       = element(concat(oci_core_dhcp_options.core_dhcp_options.*.vcn_id, [""]), 0)
}

#-----------------------------------------------------------
# core service gateway
#-----------------------------------------------------------
output "core_service_gateway_id" {
  description = "The OCID of the service gateway."
  value       = element(concat(oci_core_service_gateway.core_service_gateway.*.id, [""]), 0)
}

output "core_service_gateway_block_traffic" {
  description = "Whether the service gateway blocks all traffic through it. The default is false. When this is true, traffic is not routed to any services, regardless of route rules. Example: true"
  value       = element(concat(oci_core_service_gateway.core_service_gateway.*.block_traffic, [""]), 0)
}

output "core_service_gateway_compartment_id" {
  description = "The OCID of the compartment that contains the service gateway."
  value       = element(concat(oci_core_service_gateway.core_service_gateway.*.compartment_id, [""]), 0)
}

output "core_service_gateway_display_name" {
  description = "A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  value       = element(concat(oci_core_service_gateway.core_service_gateway.*.display_name, [""]), 0)
}

output "core_service_gateway_route_table_id" {
  description = "The OCID of the route table the service gateway is using. For information about why you would associate a route table with a service gateway, see Transit Routing: Private Access to Oracle Services."
  value       = element(concat(oci_core_service_gateway.core_service_gateway.*.route_table_id, [""]), 0)
}

output "core_service_gateway_services" {
  description = "List of the Service objects enabled for this service gateway. The list can be empty. You can enable a particular Service by using AttachServiceId or UpdateServiceGateway."
  value       = concat(oci_core_service_gateway.core_service_gateway.*.services, [""])
}

output "core_service_gateway_state" {
  description = "The service gateway's current state."
  value       = element(concat(oci_core_service_gateway.core_service_gateway.*.state, [""]), 0)
}

output "core_service_gateway_vcn_id" {
  description = "The OCID of the VCN the service gateway belongs to."
  value       = element(concat(oci_core_service_gateway.core_service_gateway.*.vcn_id, [""]), 0)
}

#-----------------------------------------------------------
# core nat gateway
#-----------------------------------------------------------
output "core_nat_gateway_id" {
  description = "The OCID of the NAT gateway."
  value       = element(concat(oci_core_nat_gateway.core_nat_gateway.*.id, [""]), 0)
}

output "core_nat_gateway_display_name" {
  description = "A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  value       = element(concat(oci_core_nat_gateway.core_nat_gateway.*.display_name, [""]), 0)
}

output "core_nat_gateway_compartment_id" {
  description = "The OCID of the compartment that contains the NAT gateway."
  value       = element(concat(oci_core_nat_gateway.core_nat_gateway.*.compartment_id, [""]), 0)
}

output "core_nat_gateway_block_traffic" {
  description = "Whether the NAT gateway blocks traffic through it. The default is false. Example: true"
  value       = element(concat(oci_core_nat_gateway.core_nat_gateway.*.block_traffic, [""]), 0)
}

output "core_nat_gateway_vcn_id" {
  description = "The OCID of the VCN the NAT gateway belongs to."
  value       = element(concat(oci_core_nat_gateway.core_nat_gateway.*.vcn_id, [""]), 0)
}

output "core_nat_gateway_state" {
  description = "The NAT gateway's current state."
  value       = element(concat(oci_core_nat_gateway.core_nat_gateway.*.state, [""]), 0)
}

output "core_nat_gateway_route_table_id" {
  description = "The OCID of the route table used by the NAT gateway."
  value       = element(concat(oci_core_nat_gateway.core_nat_gateway.*.route_table_id, [""]), 0)
}

output "core_nat_gateway_nat_ip" {
  description = "The IP address associated with the NAT gateway."
  value       = element(concat(oci_core_nat_gateway.core_nat_gateway.*.nat_ip, [""]), 0)
}

output "core_nat_gateway_public_ip_id" {
  description = "The OCID of the public IP address associated with the NAT gateway."
  value       = element(concat(oci_core_nat_gateway.core_nat_gateway.*.public_ip_id, [""]), 0)
}

#-----------------------------------------------------------
# core internet gateway
#-----------------------------------------------------------
output "core_internet_gateway_id" {
  description = "The internet gateway's Oracle ID (OCID)."
  value       = element(concat(oci_core_internet_gateway.core_internet_gateway.*.id, [""]), 0)
}

output "core_internet_gateway_compartment_id" {
  description = "The OCID of the compartment containing the internet gateway."
  value       = element(concat(oci_core_internet_gateway.core_internet_gateway.*.compartment_id, [""]), 0)
}

output "core_internet_gateway_display_name" {
  description = "A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  value       = element(concat(oci_core_internet_gateway.core_internet_gateway.*.display_name, [""]), 0)
}

output "core_internet_gateway_enabled" {
  description = "Whether the gateway is enabled. When the gateway is disabled, traffic is not routed to/from the Internet, regardless of route rules."
  value       = element(concat(oci_core_internet_gateway.core_internet_gateway.*.enabled, [""]), 0)
}

output "core_internet_gateway_route_table_id" {
  description = "The OCID of the route table the Internet Gateway is using."
  value       = element(concat(oci_core_internet_gateway.core_internet_gateway.*.route_table_id, [""]), 0)
}

output "core_internet_gateway_state" {
  description = "The internet gateway's current state."
  value       = element(concat(oci_core_internet_gateway.core_internet_gateway.*.state, [""]), 0)
}

output "core_internet_gateway_vcn_id" {
  description = "The OCID of the VCN the Internet Gateway belongs to."
  value       = element(concat(oci_core_internet_gateway.core_internet_gateway.*.vcn_id, [""]), 0)
}

#-----------------------------------------------------------
# core ipv6
#-----------------------------------------------------------
output "core_ipv6_id" {
  description = "The OCID of the IPv6."
  value       = element(concat(oci_core_ipv6.core_ipv6.*.id, [""]), 0)
}

output "core_ipv6_compartment_id" {
  description = "The OCID of the compartment containing the IPv6. This is the same as the VNIC's compartment."
  value       = element(concat(oci_core_ipv6.core_ipv6.*.compartment_id, [""]), 0)
}

output "core_ipv6_display_name" {
  description = "A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  value       = element(concat(oci_core_ipv6.core_ipv6.*.display_name, [""]), 0)
}

output "core_ipv6_ip_address" {
  description = "The IPv6 address of the IPv6 object. The address is within the IPv6 prefix of the VNIC's subnet (see the ipv6CidrBlock attribute for the Subnet object. Example: 2001:0db8:0123:1111:abcd:ef01:2345:6789"
  value       = element(concat(oci_core_ipv6.core_ipv6.*.ip_address, [""]), 0)
}

output "core_ipv6_state" {
  description = "The IPv6's current state."
  value       = element(concat(oci_core_ipv6.core_ipv6.*.state, [""]), 0)
}

output "core_ipv6_subnet_id" {
  description = "The OCID of the subnet the VNIC is in."
  value       = element(concat(oci_core_ipv6.core_ipv6.*.subnet_id, [""]), 0)
}

output "core_ipv6_vnic_id" {
  description = "The OCID of the VNIC the IPv6 is assigned to. The VNIC and IPv6 must be in the same subnet."
  value       = element(concat(oci_core_ipv6.core_ipv6.*.vnic_id, [""]), 0)
}

#-----------------------------------------------------------
# core local peering gateway
#-----------------------------------------------------------
output "core_local_peering_gateway_id" {
  description = "The LPG's Oracle ID (OCID)."
  value       = element(concat(oci_core_local_peering_gateway.core_local_peering_gateway.*.id, [""]), 0)
}

output "core_local_peering_gateway_compartment_id" {
  description = "The OCID of the compartment containing the LPG."
  value       = element(concat(oci_core_local_peering_gateway.core_local_peering_gateway.*.compartment_id, [""]), 0)
}

output "core_local_peering_gateway_display_name" {
  description = "A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  value       = element(concat(oci_core_local_peering_gateway.core_local_peering_gateway.*.display_name, [""]), 0)
}

output "core_local_peering_gateway_is_cross_tenancy_peering" {
  description = "Whether the VCN at the other end of the peering is in a different tenancy. Example: false"
  value       = element(concat(oci_core_local_peering_gateway.core_local_peering_gateway.*.is_cross_tenancy_peering, [""]), 0)
}

output "core_local_peering_gateway_peer_advertised_cidr" {
  description = "The smallest aggregate CIDR that contains all the CIDR routes advertised by the VCN at the other end of the peering from this LPG. See peerAdvertisedCidrDetails for the individual CIDRs. The value is null if the LPG is not peered. Example: 192.168.0.0/16, or if aggregated with 172.16.0.0/24 then 128.0.0.0/1"
  value       = element(concat(oci_core_local_peering_gateway.core_local_peering_gateway.*.peer_advertised_cidr, [""]), 0)
}

output "core_local_peering_gateway_peer_advertised_cidr_details" {
  description = "The specific ranges of IP addresses available on or via the VCN at the other end of the peering from this LPG. The value is null if the LPG is not peered. You can use these as destination CIDRs for route rules to route a subnet's traffic to this LPG. Example: [192.168.0.0/16, 172.16.0.0/24]"
  value       = concat(oci_core_local_peering_gateway.core_local_peering_gateway.*.peer_advertised_cidr_details, [""])
}

output "core_local_peering_gateway_peer_id" {
  description = "The OCID of the peered LPG"
  value       = element(concat(oci_core_local_peering_gateway.core_local_peering_gateway.*.peer_id, [""]), 0)
}

output "core_local_peering_gateway_peering_status" {
  description = "Whether the LPG is peered with another LPG. NEW means the LPG has not yet been peered. PENDING means the peering is being established. REVOKED means the LPG at the other end of the peering has been deleted."
  value       = element(concat(oci_core_local_peering_gateway.core_local_peering_gateway.*.peering_status, [""]), 0)
}

output "core_local_peering_gateway_peering_status_details" {
  description = "Additional information regarding the peering status, if applicable."
  value       = concat(oci_core_local_peering_gateway.core_local_peering_gateway.*.peering_status_details, [""])
}

output "core_local_peering_gateway_route_table_id" {
  description = "The OCID of the route table the LPG is using."
  value       = element(concat(oci_core_local_peering_gateway.core_local_peering_gateway.*.route_table_id, [""]), 0)
}

output "core_local_peering_gateway_state" {
  description = "The LPG's current lifecycle state."
  value       = element(concat(oci_core_local_peering_gateway.core_local_peering_gateway.*.state, [""]), 0)
}

output "core_local_peering_gateway_vcn_id" {
  description = "The OCID of the VCN that uses the LPG."
  value       = element(concat(oci_core_local_peering_gateway.core_local_peering_gateway.*.vcn_id, [""]), 0)
}

