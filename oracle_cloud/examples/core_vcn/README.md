# Work with CORE_VCN via terraform

A terraform module for making CORE_VCN.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#

terraform {
  required_version = "~> 1.0"

  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "6.21.0"
    }
  }
}

provider "oci" {
  fingerprint      = var.provider_oci_fingerprint
  private_key_path = var.provider_oci_private_key_path
  region           = var.provider_oci_region
  tenancy_ocid     = var.provider_oci_tenancy_ocid
  user_ocid        = var.provider_oci_user_ocid
  alias            = var.provider_oci_alias
}

module "core_vcn" {
  source = "../../modules/core_vcn"

  # enable

}

```

## Module Input Variables
----------------------
- `name` - The name for resources (`default = test`)
- `environment` - The environment for resources (`default = dev`)
- `tags` - Add additional tags (`default = {}`)
- `enable_core_vcn` - Enable core vcn usages (`default = False`)
- `core_vcn_compartment_id` - (Required) (Updatable) The OCID of the compartment to contain the VCN. (`default = null`)
- `core_vcn_byoipv6cidr_details` - (Optional) The list of BYOIPv6 OCIDs and BYOIPv6 prefixes required to create a VCN that uses BYOIPv6 address ranges. (`default = []`)
- `core_vcn_display_name` - (Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information. (`default = null`)
- `core_vcn_cidr_blocks` - (Optional) (Updatable) The list of one or more IPv4 CIDR blocks for the VCN (`default = null`)
- `core_vcn_dns_label` - (Optional) A DNS label for the VCN, used in conjunction with the VNIC's hostname and subnet's DNS label to form a fully qualified domain name (FQDN) for each VNIC within this subnet (for example, bminstance1.subnet123.vcn1.oraclevcn.com). Not required to be unique, but it's a best practice to set unique DNS labels for VCNs in your tenancy. Must be an alphanumeric string that begins with a letter. The value cannot be changed. You must set this value if you want instances to be able to use hostnames to resolve other instances in the VCN. Otherwise the Internet and VCN Resolver will not work. (`default = null`)
- `core_vcn_ipv6private_cidr_blocks` - (Optional) The list of one or more ULA or Private IPv6 CIDR blocks for the vcn (`default = null`)
- `core_vcn_is_ipv6enabled` - (Optional) Whether IPv6 is enabled for the VCN. Default is false. If enabled, Oracle will assign the VCN a IPv6 /56 CIDR block. You may skip having Oracle allocate the VCN a IPv6 /56 CIDR block by setting isOracleGuaAllocationEnabled to false. For important details about IPv6 addressing in a VCN, see IPv6 Addresses. Example: true (`default = null`)
- `core_vcn_is_oracle_gua_allocation_enabled` - (Optional) Specifies whether to skip Oracle allocated IPv6 GUA. By default, Oracle will allocate one GUA of /56 size for an IPv6 enabled VCN. (`default = null`)
- `core_vcn_security_attributes` - (Optional) (Updatable) Security Attributes for this resource. This is unique to ZPR, and helps identify which resources are allowed to be accessed by what permission controls. Example: {'Oracle-DataSecurity-ZPR.MaxEgressCount.value': '42', 'Oracle-DataSecurity-ZPR.MaxEgressCount.mode': 'audit'} (`default = null`)
- `core_vcn_freeform_tags` - (Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. (`default = {}`)
- `core_vcn_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Vcn * update - (Defaults to 20 minutes), when updating the Vcn * delete - (Defaults to 20 minutes), when destroying the Vcn (`default = {}`)
- `enable_core_private_ip` - Enable core private ip usages (`default = False`)
- `core_private_ip_display_name` - (Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information. (`default = null`)
- `core_private_ip_hostname_label` - (Optional) (Updatable) The hostname for the private IP. Used for DNS. The value is the hostname portion of the private IP's fully qualified domain name (FQDN) (for example, bminstance1 in FQDN bminstance1.subnet123.vcn1.oraclevcn.com). Must be unique across all VNICs in the subnet and comply with RFC 952 and RFC 1123. (`default = null`)
- `core_private_ip_ip_address` - (Optional) A private IP address of your choice. Must be an available IP address within the subnet's CIDR. If you don't specify a value, Oracle automatically assigns a private IP address from the subnet. Example: 10.0.3.3 (`default = null`)
- `core_private_ip_vlan_id` - (Optional) Use this attribute only with the Oracle Cloud VMware Solution. The OCID of the VLAN from which the private IP is to be drawn. The IP address, if supplied, must be valid for the given VLAN. See Vlan. (`default = null`)
- `core_private_ip_vnic_id` - (Optional) (Updatable) The OCID of the VNIC to assign the private IP to. The VNIC and private IP must be in the same subnet. (`default = null`)
- `core_private_ip_freeform_tags` - (Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags (`default = {}`)
- `core_private_ip_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Private Ip * update - (Defaults to 20 minutes), when updating the Private Ip * delete - (Defaults to 20 minutes), when destroying the Private Ip (`default = {}`)
- `enable_core_public_ip_pool_capacity` - Enable core public ip pool capacity usages (`default = False`)
- `core_public_ip_pool_capacity_public_ip_pool_id` - (Required) The OCID of the pool object created by the current tenancy (`default = null`)
- `core_public_ip_pool_capacity_byoip_id` - (Required) The OCID of the Byoip Range Id object to which the cidr block belongs. (`default = null`)
- `core_public_ip_pool_capacity_cidr_block` - (Required) The CIDR IP address range to be added to the Public Ip Pool. Example: 10.0.1.0/24 (`default = null`)
- `enable_core_public_ip_pool` - Enable core public ip pool usages (`default = False`)
- `core_public_ip_pool_compartment_id` - (Required) (Updatable) The OCID of the compartment containing the public IP pool. (`default = null`)
- `core_public_ip_pool_display_name` - (Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information. (`default = null`)
- `core_public_ip_pool_freeform_tags` - (Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. (`default = {}`)
- `core_public_ip_pool_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Public Ip Pool * update - (Defaults to 20 minutes), when updating the Public Ip Pool * delete - (Defaults to 20 minutes), when destroying the Public Ip Pool (`default = {}`)
- `enable_core_public_ip` - Enable core public ip usages (`default = False`)
- `core_public_ip_compartment_id` - (Required) (Updatable) The OCID of the compartment to contain the public IP. For ephemeral public IPs, you must set this to the private IP's compartment OCID. (`default = null`)
- `core_public_ip_lifetime` - (Required) Defines when the public IP is deleted and released back to the Oracle Cloud Infrastructure public IP pool. For more information, see Public IP Addresses. (`default = null`)
- `core_public_ip_display_name` - (Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information. (`default = null`)
- `core_public_ip_private_ip_id` - (Optional) (Updatable) The OCID of the private IP to assign the public IP to. (`default = null`)
- `core_public_ip_public_ip_pool_id` - (Optional) The OCID of the public IP pool. (`default = null`)
- `core_public_ip_freeform_tags` - (Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags.  (`default = {}`)
- `core_public_ip_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Public Ip * update - (Defaults to 20 minutes), when updating the Public Ip * delete - (Defaults to 20 minutes), when destroying the Public Ip (`default = {}`)
- `enable_core_route_table` - Enable core route table usages (`default = False`)
- `core_route_table_compartment_id` - (Required) (Updatable) The OCID of the compartment to contain the route table. (`default = null`)
- `core_route_table_vcn_id` - (Required) The OCID of the VCN the route table belongs to. (`default = ""`)
- `core_route_table_display_name` - (Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information. (`default = null`)
- `core_route_table_route_rules` - (Optional) (Updatable) The collection of rules used for routing destination IPs to network devices. (`default = []`)
- `core_route_table_freeform_tags` - (Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags.  (`default = {}`)
- `core_route_table_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Route Table * update - (Defaults to 20 minutes), when updating the Route Table * delete - (Defaults to 20 minutes), when destroying the Route Table (`default = {}`)
- `enable_core_route_table_attachment` - Enable core route table attachment usages (`default = False`)
- `core_route_table_attachment_subnet_id` - (Required) The OCID of the subnet. (`default = ""`)
- `core_route_table_attachment_route_table_id` - (Required) The OCID of the route table. (`default = ""`)
- `enable_core_vlan` - Enable core vlan usages (`default = False`)
- `core_vlan_cidr_block` - (Required) (Updatable) The range of IPv4 addresses that will be used for layer 3 communication with hosts outside the VLAN (`default = null`)
- `core_vlan_compartment_id` - (Required) (Updatable) The OCID of the compartment to contain the VLAN. (`default = null`)
- `core_vlan_vcn_id` - (Required) The OCID of the VCN to contain the VLAN. (`default = ""`)
- `core_vlan_display_name` - (Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information. (`default = null`)
- `core_vlan_availability_domain` - (Optional) Controls whether the VLAN is regional or specific to an availability domain. A regional VLAN has the flexibility to implement failover across availability domains. Previously, all VLANs were AD-specific. (`default = null`)
- `core_vlan_nsg_ids` - (Optional) (Updatable) A list of the OCIDs of the network security groups (NSGs) to add all VNICs in the VLAN to. For more information about NSGs (`default = null`)
- `core_vlan_route_table_id` - (Optional) (Updatable) The OCID of the route table the VLAN will use. If you don't provide a value, the VLAN uses the VCN's default route table. (`default = null`)
- `core_vlan_vlan_tag` - (Optional) The IEEE 802.1Q VLAN tag for this VLAN. The value must be unique across all VLANs in the VCN. If you don't provide a value, Oracle assigns one. You cannot change the value later. VLAN tag 0 is reserved for use by Oracle. (`default = null`)
- `core_vlan_freeform_tags` - (Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. (`default = {}`)
- `core_vlan_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Vlan * update - (Defaults to 20 minutes), when updating the Vlan * delete - (Defaults to 20 minutes), when destroying the Vlan (`default = {}`)
- `enable_core_vnic_attachment` - Enable core vnic attachment usages (`default = False`)
- `core_vnic_attachment_create_vnic_details` - (Required) (Updatable) Contains properties for a VNIC. You use this object when creating the primary VNIC during instance launch or when creating a secondary VNIC. For more information about VNICs, see Virtual Network Interface Cards (VNICs). (`default = []`)
- `core_vnic_attachment_instance_id` - (Required) The OCID of the instance. (`default = null`)
- `core_vnic_attachment_display_name` - (Optional) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information. (`default = null`)
- `core_vnic_attachment_nic_index` - (Optional) Which physical network interface card (NIC) the VNIC will use. Defaults to 0. Certain bare metal instance shapes have two active physical NICs (0 and 1). If you add a secondary VNIC to one of these instances, you can specify which NIC the VNIC will use. For more information, see Virtual Network Interface Cards (VNICs). (`default = null`)
- `core_vnic_attachment_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Vnic Attachment * update - (Defaults to 20 minutes), when updating the Vnic Attachment * delete - (Defaults to 20 minutes), when destroying the Vnic Attachment (`default = {}`)
- `enable_core_subnet` - Enable core subnet usages (`default = False`)
- `core_subnet_cidr_block` - (Required) (Updatable) The CIDR IP address range of the subnet.  (`default = null`)
- `core_subnet_compartment_id` - (Required) (Updatable) The OCID of the compartment to contain the subnet. (`default = null`)
- `core_subnet_vcn_id` - (Required) The OCID of the VCN to contain the subnet. (`default = ""`)
- `core_subnet_availability_domain` -  (Optional) Controls whether the subnet is regional or specific to an availability domain. Oracle recommends creating regional subnets because they're more flexible and make it easier to implement failover across availability domains. Originally, AD-specific subnets were the only kind available to use. (`default = null`)
- `core_subnet_dhcp_options_id` - (Optional) (Updatable) The OCID of the set of DHCP options the subnet will use. If you don't provide a value, the subnet uses the VCN's default set of DHCP options. (`default = null`)
- `core_subnet_display_name` - (Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information. (`default = null`)
- `core_subnet_dns_label` - (Optional) A DNS label for the subnet, used in conjunction with the VNIC's hostname and VCN's DNS label to form a fully qualified domain name (FQDN) for each VNIC within this subnet (for example, bminstance1.subnet123.vcn1.oraclevcn.com). Must be an alphanumeric string that begins with a letter and is unique within the VCN. The value cannot be changed. (`default = null`)
- `core_subnet_ipv6cidr_block` - (Optional) (Updatable) Use this to enable IPv6 addressing for this subnet. The VCN must be enabled for IPv6. You can't change this subnet characteristic later. All subnets are /64 in size. The subnet portion of the IPv6 address is the fourth hextet from the left (1111 in the following example). (`default = null`)
- `core_subnet_ipv6cidr_blocks` - (Optional) (Updatable) The list of all IPv6 prefixes (Oracle allocated IPv6 GUA, ULA or private IPv6 prefixes, BYOIPv6 prefixes) for the subnet (`default = null`)
- `core_subnet_prohibit_internet_ingress` - (Optional) Whether to disallow ingress internet traffic to VNICs within this subnet. Defaults to false. (`default = null`)
- `core_subnet_prohibit_public_ip_on_vnic` - (Optional) Whether VNICs within this subnet can have public IP addresses. Defaults to false, which means VNICs created in this subnet will automatically be assigned public IP addresses unless specified otherwise during instance launch or VNIC creation (with the assignPublicIp flag in CreateVnicDetails). If prohibitPublicIpOnVnic is set to true, VNICs created in this subnet cannot have public IP addresses (that is, it's a private subnet). (`default = null`)
- `core_subnet_route_table_id` - (Optional) (Updatable) The OCID of the route table the subnet will use. If you don't provide a value, the subnet uses the VCN's default route table. (`default = null`)
- `core_subnet_security_list_ids` - (Optional) (Updatable) The OCIDs of the security list or lists the subnet will use. If you don't provide a value, the subnet uses the VCN's default security list. Remember that security lists are associated with the subnet, but the rules are applied to the individual VNICs in the subnet. (`default = null`)
- `core_subnet_freeform_tags` - (Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. (`default = {}`)
- `core_subnet_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Subnet * update - (Defaults to 20 minutes), when updating the Subnet * delete - (Defaults to 20 minutes), when destroying the Subnet (`default = {}`)
- `enable_core_dhcp_options` - Enablecore dhcp options usages (`default = False`)
- `core_dhcp_options_compartment_id` - (Required) (Updatable) The OCID of the compartment to contain the set of DHCP options. (`default = null`)
- `core_dhcp_options_options` - List of DHCP options configurations. (`default = []`)
- `core_dhcp_options_vcn_id` - The OCID of the VCN the set of DHCP options belongs to. (`default = ""`)
- `core_dhcp_options_display_name` - (Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information. (`default = null`)
- `core_dhcp_options_freeform_tags` - (Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. (`default = {}`)
- `core_dhcp_options_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Dhcp Options * update - (Defaults to 20 minutes), when updating the Dhcp Options * delete - (Defaults to 20 minutes), when destroying the Dhcp Options (`default = {}`)
- `enable_core_service_gateway` - Enable core service gateway usages (`default = False`)
- `core_service_gateway_compartment_id` - (Required) (Updatable) The OCID of the compartment to contain the service gateway. (`default = null`)
- `core_service_gateway_services` - (Required) (Updatable) List of the OCIDs of the Service objects to enable for the service gateway. This list can be empty if you don't want to enable any Service objects when you create the gateway. You can enable a Service object later by using either AttachServiceId or UpdateServiceGateway. (`default = []`)
- `core_service_gateway_vcn_id` - The OCID of the VCN. (`default = ""`)
- `core_service_gateway_display_name` - (Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information. (`default = null`)
- `core_service_gateway_route_table_id` - (Optional) (Updatable) The OCID of the route table the service gateway will use. (`default = null`)
- `core_service_gateway_freeform_tags` - (Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags (`default = {}`)
- `core_service_gateway_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Service Gateway * update - (Defaults to 20 minutes), when updating the Service Gateway * delete - (Defaults to 20 minutes), when destroying the Service Gateway (`default = {}`)
- `enable_core_nat_gateway` - Enable core nat gateway usages (`default = False`)
- `core_nat_gateway_compartment_id` - Required) (Updatable) The OCID of the compartment to contain the NAT gateway. (`default = null`)
- `core_nat_gateway_vcn_id` - (Required) The OCID of the VCN the gateway belongs to. (`default = ""`)
- `core_nat_gateway_block_traffic` - (Optional) (Updatable) Whether the NAT gateway blocks traffic through it. The default is false. Example: true (`default = null`)
- `core_nat_gateway_display_name` - (Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information. (`default = null`)
- `core_nat_gateway_public_ip_id` - (Optional) The OCID of the public IP address associated with the NAT gateway. (`default = null`)
- `core_nat_gateway_route_table_id` - (Optional) (Updatable) The OCID of the route table used by the NAT gateway. (`default = null`)
- `core_nat_gateway_freeform_tags` - (Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. (`default = {}`)
- `core_nat_gateway_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Nat Gateway * update - (Defaults to 20 minutes), when updating the Nat Gateway * delete - (Defaults to 20 minutes), when destroying the Nat Gateway (`default = {}`)
- `enable_core_internet_gateway` - Enable core internet gateway usages (`default = False`)
- `core_internet_gateway_compartment_id` - (Required) (Updatable) The OCID of the compartment to contain the internet gateway. (`default = null`)
- `core_internet_gateway_vcn_id` - The OCID of the VCN the Internet Gateway is attached to. (`default = ""`)
- `core_internet_gateway_enabled` - (Optional) (Updatable) Whether the gateway is enabled upon creation. (`default = null`)
- `core_internet_gateway_display_name` - (Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information. (`default = null`)
- `core_internet_gateway_route_table_id` - (Optional) (Updatable) The OCID of the route table the Internet Gateway is using. (`default = null`)
- `core_internet_gateway_freeform_tags` - (Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. (`default = {}`)
- `core_internet_gateway_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Internet Gateway * update - (Defaults to 20 minutes), when updating the Internet Gateway * delete - (Defaults to 20 minutes), when destroying the Internet Gateway (`default = {}`)
- `enable_core_ipv6` - Enable core ipv6 usages (`default = False`)
- `core_ipv6_vnic_id` - (Updatable) The OCID of the VNIC to assign the IPv6 to. The IPv6 will be in the VNIC's subnet. (`default = null`)
- `core_ipv6_display_name` - (Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information. (`default = null`)
- `core_ipv6_ip_address` - (Optional) An IPv6 address of your choice. Must be an available IP address within the subnet's CIDR. If you don't specify a value, Oracle automatically assigns an IPv6 address from the subnet. The subnet is the one that contains the VNIC you specify in vnicId. Example: 2001:DB8:: (`default = null`)
- `core_ipv6_ipv6subnet_cidr` - (Optional) The IPv6 prefix allocated to the subnet. This is required if more than one IPv6 prefix exists on the subnet. (`default = null`)
- `core_ipv6_freeform_tags` - (Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. (`default = {}`)
- `core_ipv6_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Ipv6 * update - (Defaults to 20 minutes), when updating the Ipv6 * delete - (Defaults to 20 minutes), when destroying the Ipv6 (`default = {}`)
- `enable_core_local_peering_gateway` - enable_core_local_peering_gateway usages (`default = False`)
- `core_local_peering_gateway_compartment_id` - (Required) (Updatable) The OCID of the compartment containing the local peering gateway (LPG). (`default = null`)
- `core_local_peering_gateway_vcn_id` - The OCID of the VCN the LPG belongs to. (`default = ""`)
- `core_local_peering_gateway_display_name` - (Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information. (`default = null`)
- `core_local_peering_gateway_peer_id` - (Optional) The OCID of the LPG you want to peer with. Specifying a peer_id connects this local peering gateway (LPG) to another one in the same region. This operation must be called by the VCN administrator who is designated as the requestor in the peering relationship. The acceptor must implement an Identity and Access Management (IAM) policy that gives the requestor permission to connect to LPGs in the acceptor's compartment. Without that permission, this operation will fail. For more information, see VCN Peering. (`default = null`)
- `core_local_peering_gateway_route_table_id` - (Optional) (Updatable) The OCID of the route table the LPG will use. (`default = ""`)
- `core_local_peering_gateway_freeform_tags` - (Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags.  (`default = {}`)
- `core_local_peering_gateway_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Local Peering Gateway * update - (Defaults to 20 minutes), when updating the Local Peering Gateway * delete - (Defaults to 20 minutes), when destroying the Local Peering Gateway (`default = {}`)

## Module Output Variables
----------------------
- `core_vcn_id` - The VCN's Oracle ID (OCID).
- `core_vcn_ipv6cidr_blocks` - For an IPv6-enabled VCN, this is the list of IPv6 prefixes for the VCN's IP address space. The prefixes are provided by Oracle and the sizes are always /56.
- `core_vcn_ipv6private_cidr_blocks` - For an IPv6-enabled VCN, this is the list of Private IPv6 prefixes for the VCN's IP address space.
- `core_vcn_security_attributes` - Security Attributes for this resource. This is unique to ZPR, and helps identify which resources are allowed to be accessed by what permission controls.
- `core_vcn_state` - The VCN's current state.
- `core_vcn_time_created` - The date and time the VCN was created, in the format defined by RFC3339. Example: 2016-08-25T21:10:29.600Z
- `core_vcn_vcn_domain_name` - The VCN's domain name, which consists of the VCN's DNS label, and the oraclevcn.com domain.
- `core_vcn_cidr_blocks` - The list of IPv4 CIDR blocks the VCN will use.
- `core_vcn_compartment_id` - The OCID of the compartment containing the VCN.
- `core_vcn_default_dhcp_options_id` - The OCID for the VCN's default set of DHCP options.
- `core_vcn_default_route_table_id` - The OCID for the VCN's default route table.
- `core_vcn_default_security_list_id` - The OCID for the VCN's default security list.
- `core_vcn_display_name` - A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information.
- `core_vcn_dns_label` - A DNS label for the VCN, used in conjunction with the VNIC's hostname and subnet's DNS label to form a fully qualified domain name (FQDN) for each VNIC within this subnet (for example, bminstance1.subnet123.vcn1.oraclevcn.com). Must be an alphanumeric string that begins with a letter. The value cannot be changed.
- `core_vcn_byoipv6cidr_blocks` - The list of BYOIPv6 prefixes required to create a VCN that uses BYOIPv6 ranges.
- `core_private_ip_id` - The private IP's Oracle ID (OCID).
- `core_private_ip_is_primary` - Whether this private IP is the primary one on the VNIC. Primary private IPs are unassigned and deleted automatically when the VNIC is terminated. Example: true
- `core_private_ip_is_reserved` - true if the IP is reserved and can exist detached from vnic
- `core_private_ip_subnet_id` - The OCID of the subnet the VNIC is in.
- `core_private_ip_vlan_id` - Applicable only if the PrivateIp object is being used with a VLAN as part of the Oracle Cloud VMware Solution. The vlanId is the OCID of the VLAN. See Vlan.
- `core_private_ip_vnic_id` - The OCID of the VNIC the private IP is assigned to. The VNIC and private IP must be in the same subnet. However, if the PrivateIp object is being used with a VLAN as part of the Oracle Cloud VMware Solution, the vnicId is null.
- `core_private_ip_hostname_label` - The hostname for the private IP. Used for DNS. The value is the hostname portion of the private IP's fully qualified domain name (FQDN) (for example, bminstance1 in FQDN bminstance1.subnet123.vcn1.oraclevcn.com). Must be unique across all VNICs in the subnet and comply with RFC 952 and RFC 1123.
- `core_private_ip_ip_address` - The private IP address of the privateIp object. The address is within the CIDR of the VNIC's subnet.
- `core_private_ip_availability_domain` - The private IP's availability domain. This attribute will be null if this is a secondary private IP assigned to a VNIC that is in a regional subnet. Example: Uocm:PHX-AD-1
- `core_private_ip_compartment_id` - The OCID of the compartment containing the private IP.
- `core_private_ip_display_name` - A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information.
- `core_public_ip_pool_capacity_public_ip_pool_id` - The OCID of the pool object
- `core_public_ip_pool_capacity_byoip_id` - The OCID of the Byoip Range Id object
- `core_public_ip_pool_capacity_cidr_block` - The CIDR IP address range to be added to the Public Ip Pool
- `core_public_ip_pool_id` - The OCID of the public IP pool.
- `core_public_ip_pool_state` - The public IP pool's current state.
- `core_public_ip_pool_cidr_blocks` - The CIDR blocks added to this pool. This could be all or a portion of a BYOIP CIDR block.
- `core_public_ip_pool_compartment_id` - The OCID of the compartment containing this pool.
- `core_public_ip_pool_display_name` - A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information.
- `core_public_ip_id` - The public IP's Oracle ID (OCID).
- `core_public_ip_assigned_entity_id` - The OCID of the entity the public IP is assigned to, or in the process of being assigned to.
- `core_public_ip_assigned_entity_type` - The type of entity the public IP is assigned to, or in the process of being assigned to.
- `core_public_ip_availability_domain` - The public IP's availability domain. This property is set only for ephemeral public IPs that are assigned to a private IP (that is, when the scope of the public IP is set to AVAILABILITY_DOMAIN). The value is the availability domain of the assigned private IP. Example: Uocm:PHX-AD-1
- `core_public_ip_compartment_id` - The OCID of the compartment containing the public IP. For an ephemeral public IP, this is the compartment of its assigned entity (which can be a private IP or a regional entity such as a NAT gateway). For a reserved public IP that is currently assigned, its compartment can be different from the assigned private IP's.
- `core_public_ip_ip_address` - The public IP address of the publicIp object. Example: 203.0.113.2
- `core_public_ip_lifetime` - Defines when the public IP is deleted and released back to Oracle's public IP pool.
- `core_public_ip_display_name` - A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information.
- `core_public_ip_state` - The public IP's current state.
- `core_public_ip_public_ip_pool_id` - The OCID of the pool object created in the current tenancy.
- `core_public_ip_scope` - Whether the public IP is regional or specific to a particular availability domain.
- `core_route_table_id` - ID of core route table
- `core_route_table_state` - The route table's current state.
- `core_route_table_vcn_id` - The OCID of the VCN the route table list belongs to.
- `core_route_table_route_rules` - The collection of rules for routing destination IPs to network devices.
- `core_route_table_compartment_id` - The OCID of the compartment containing the route table.
- `core_route_table_display_name` - A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information.
- `core_route_table_attachment_id` - ID of core route table attachment
- `core_route_table_attachment_subnet_id` - The OCID of the subnet.
- `core_route_table_attachment_route_table_id` - The OCID of the route table.
- `core_vlan_id` - The VLAN's Oracle ID (OCID).
- `core_vlan_availability_domain` - The VLAN's availability domain. This attribute will be null if this is a regional VLAN rather than an AD-specific VLAN. Example: Uocm:PHX-AD-1
- `core_vlan_cidr_block` - The range of IPv4 addresses that will be used for layer 3 communication with hosts outside the VLAN. Example: 192.168.1.0/24
- `core_vlan_compartment_id` - The OCID of the compartment containing the VLAN.
- `core_vlan_display_name` - A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information.
- `core_vlan_nsg_ids` - A list of the OCIDs of the network security groups (NSGs) to use with this VLAN. All VNICs in the VLAN belong to these NSGs. For more information about NSGs, see NetworkSecurityGroup.
- `core_vlan_route_table_id` - The OCID of the route table that the VLAN uses.
- `core_vlan_state` - The VLAN's current state.
- `core_vlan_vcn_id` - The OCID of the VCN the VLAN is in.
- `core_vlan_vlan_tag` - The IEEE 802.1Q VLAN tag of this VLAN. Example: 100
- `core_vnic_attachment_id` - The OCID of the VNIC attachment.
- `core_vnic_attachment_state` - The current state of the VNIC attachment.
- `core_vnic_attachment_subnet_id` - The OCID of the subnet to create the VNIC in.
- `core_vnic_attachment_vlan_id` - The OCID of the VLAN to create the VNIC in. Creating the VNIC in a VLAN (instead of a subnet) is possible only if you are an Oracle Cloud VMware Solution customer. See Vlan.
- `core_vnic_attachment_vlan_tag` - The Oracle-assigned VLAN tag of the attached VNIC. Available after the attachment process is complete.
- `core_vnic_attachment_vnic_id` - The OCID of the VNIC. Available after the attachment process is complete.
- `core_vnic_attachment_availability_domain` - The availability domain of the instance. Example: Uocm:PHX-AD-1
- `core_vnic_attachment_compartment_id` - The OCID of the compartment the VNIC attachment is in, which is the same compartment the instance is in.
- `core_vnic_attachment_display_name` - A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information.
- `core_vnic_attachment_instance_id` - The OCID of the instance.
- `core_vnic_attachment_nic_index` - Which physical network interface card (NIC) the VNIC uses. Certain bare metal instance shapes have two active physical NICs (0 and 1). If you add a secondary VNIC to one of these instances, you can specify which NIC the VNIC will use. For more information, see Virtual Network Interface Cards (VNICs).
- `core_subnet_id` - The subnet's Oracle ID (OCID).
- `core_subnet_availability_domain` - The subnet's availability domain. This attribute will be null if this is a regional subnet instead of an AD-specific subnet. Oracle recommends creating regional subnets. Example: Uocm:PHX-AD-1
- `core_subnet_cidr_block` - The subnet's CIDR block. Example: 10.0.1.0/24
- `core_subnet_compartment_id` - The OCID of the compartment containing the subnet.
- `core_subnet_dhcp_options_id` - The OCID of the set of DHCP options that the subnet uses.
- `core_subnet_display_name` - A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information.
- `core_subnet_dns_label` - A DNS label for the subnet, used in conjunction with the VNIC's hostname and VCN's DNS label to form a fully qualified domain name (FQDN) for each VNIC within this subnet (for example, bminstance1.subnet123.vcn1.oraclevcn.com). Must be an alphanumeric string that begins with a letter and is unique within the VCN. The value cannot be changed.
- `core_subnet_ipv6cidr_block` - For an IPv6-enabled subnet, this is the IPv6 prefix for the subnet's IP address space. The subnet size is always /64. See IPv6 Addresses. Example: 2001:0db8:0123:1111::/64
- `core_subnet_ipv6cidr_blocks` - The list of all IPv6 prefixes (Oracle allocated IPv6 GUA, ULA or private IPv6 prefixes, BYOIPv6 prefixes) for the subnet.
- `core_subnet_ipv6virtual_router_ip` - For an IPv6-enabled subnet, this is the IPv6 address of the virtual router. Example: 2001:0db8:0123:1111:89ab:cdef:1234:5678
- `core_subnet_prohibit_internet_ingress` - Whether to disallow ingress internet traffic to VNICs within this subnet. Defaults to false.
- `core_subnet_prohibit_public_ip_on_vnic` - Whether VNICs within this subnet can have public IP addresses. Defaults to false, which means VNICs created in this subnet will automatically be assigned public IP addresses unless specified otherwise during instance launch or VNIC creation (with the assignPublicIp flag in CreateVnicDetails). If prohibitPublicIpOnVnic is set to true, VNICs created in this subnet cannot have public IP addresses (that is, it's a private subnet). Example: true
- `core_subnet_route_table_id` - The OCID of the route table that the subnet uses.
- `core_subnet_security_list_ids` - The OCIDs of the security list or lists that the subnet uses. Remember that security lists are associated with the subnet, but the rules are applied to the individual VNICs in the subnet.
- `core_subnet_state` - The subnet's current state.
- `core_subnet_subnet_domain_name` - The subnet's domain name, which consists of the subnet's DNS label, the VCN's DNS label, and the oraclevcn.com domain.
- `core_subnet_vcn_id` - The OCID of the VCN the subnet is in.
- `core_subnet_virtual_router_ip` - The IP address of the virtual router. Example: 10.0.14.1
- `core_subnet_virtual_router_mac` - The MAC address of the virtual router. Example: 00:00:00:00:00:01
- `core_dhcp_options_id` - Oracle ID (OCID) for the set of DHCP options.
- `core_dhcp_options_compartment_id` - The OCID of the compartment containing the set of DHCP options.
- `core_dhcp_options_display_name` - A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information.
- `core_dhcp_options_domain_name_type` - The search domain name type of DHCP options
- `core_dhcp_options_options` - The collection of individual DHCP options.
- `core_dhcp_options_state` - The current state of the set of DHCP options.
- `core_dhcp_options_vcn_id` - The OCID of the VCN the set of DHCP options belongs to.
- `core_service_gateway_id` - The OCID of the service gateway.
- `core_service_gateway_block_traffic` - Whether the service gateway blocks all traffic through it. The default is false. When this is true, traffic is not routed to any services, regardless of route rules. Example: true
- `core_service_gateway_compartment_id` - The OCID of the compartment that contains the service gateway.
- `core_service_gateway_display_name` - A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information.
- `core_service_gateway_route_table_id` - The OCID of the route table the service gateway is using. For information about why you would associate a route table with a service gateway, see Transit Routing: Private Access to Oracle Services.
- `core_service_gateway_services` - List of the Service objects enabled for this service gateway. The list can be empty. You can enable a particular Service by using AttachServiceId or UpdateServiceGateway.
- `core_service_gateway_state` - The service gateway's current state.
- `core_service_gateway_vcn_id` - The OCID of the VCN the service gateway belongs to.
- `core_nat_gateway_id` - The OCID of the NAT gateway.
- `core_nat_gateway_display_name` - A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information.
- `core_nat_gateway_compartment_id` - The OCID of the compartment that contains the NAT gateway.
- `core_nat_gateway_block_traffic` - Whether the NAT gateway blocks traffic through it. The default is false. Example: true
- `core_nat_gateway_vcn_id` - The OCID of the VCN the NAT gateway belongs to.
- `core_nat_gateway_state` - The NAT gateway's current state.
- `core_nat_gateway_route_table_id` - The OCID of the route table used by the NAT gateway.
- `core_nat_gateway_nat_ip` - The IP address associated with the NAT gateway.
- `core_nat_gateway_public_ip_id` - The OCID of the public IP address associated with the NAT gateway.
- `core_internet_gateway_id` - The internet gateway's Oracle ID (OCID).
- `core_internet_gateway_compartment_id` - The OCID of the compartment containing the internet gateway.
- `core_internet_gateway_display_name` - A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information.
- `core_internet_gateway_enabled` - Whether the gateway is enabled. When the gateway is disabled, traffic is not routed to/from the Internet, regardless of route rules.
- `core_internet_gateway_route_table_id` - The OCID of the route table the Internet Gateway is using.
- `core_internet_gateway_state` - The internet gateway's current state.
- `core_internet_gateway_vcn_id` - The OCID of the VCN the Internet Gateway belongs to.
- `core_ipv6_id` - The OCID of the IPv6.
- `core_ipv6_compartment_id` - The OCID of the compartment containing the IPv6. This is the same as the VNIC's compartment.
- `core_ipv6_display_name` - A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information.
- `core_ipv6_ip_address` - The IPv6 address of the IPv6 object. The address is within the IPv6 prefix of the VNIC's subnet (see the ipv6CidrBlock attribute for the Subnet object. Example: 2001:0db8:0123:1111:abcd:ef01:2345:6789
- `core_ipv6_state` - The IPv6's current state.
- `core_ipv6_subnet_id` - The OCID of the subnet the VNIC is in.
- `core_ipv6_vnic_id` - The OCID of the VNIC the IPv6 is assigned to. The VNIC and IPv6 must be in the same subnet.
- `core_local_peering_gateway_id` - The LPG's Oracle ID (OCID).
- `core_local_peering_gateway_compartment_id` - The OCID of the compartment containing the LPG.
- `core_local_peering_gateway_display_name` - A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information.
- `core_local_peering_gateway_is_cross_tenancy_peering` - Whether the VCN at the other end of the peering is in a different tenancy. Example: false
- `core_local_peering_gateway_peer_advertised_cidr` - The smallest aggregate CIDR that contains all the CIDR routes advertised by the VCN at the other end of the peering from this LPG. See peerAdvertisedCidrDetails for the individual CIDRs. The value is null if the LPG is not peered. Example: 192.168.0.0/16, or if aggregated with 172.16.0.0/24 then 128.0.0.0/1
- `core_local_peering_gateway_peer_advertised_cidr_details` - The specific ranges of IP addresses available on or via the VCN at the other end of the peering from this LPG. The value is null if the LPG is not peered. You can use these as destination CIDRs for route rules to route a subnet's traffic to this LPG. Example: [192.168.0.0/16, 172.16.0.0/24]
- `core_local_peering_gateway_peer_id` - The OCID of the peered LPG
- `core_local_peering_gateway_peering_status` - Whether the LPG is peered with another LPG. NEW means the LPG has not yet been peered. PENDING means the peering is being established. REVOKED means the LPG at the other end of the peering has been deleted.
- `core_local_peering_gateway_peering_status_details` - Additional information regarding the peering status, if applicable.
- `core_local_peering_gateway_route_table_id` - The OCID of the route table the LPG is using.
- `core_local_peering_gateway_state` - The LPG's current lifecycle state.
- `core_local_peering_gateway_vcn_id` - The OCID of the VCN that uses the LPG.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
