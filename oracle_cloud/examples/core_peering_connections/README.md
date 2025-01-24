# Work with CORE_PEERING_CONNECTIONS via terraform

A terraform module for making CORE_PEERING_CONNECTIONS.


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
  # config_file = var.provider_oci_config_file
  # profile     = var.provider_oci_profile

  fingerprint      = var.provider_oci_fingerprint
  private_key_path = var.provider_oci_private_key_path
  region           = var.provider_oci_region
  tenancy_ocid     = var.provider_oci_tenancy_ocid
  user_ocid        = var.provider_oci_user_ocid
}

module "core_vcn" {
  source = "../../modules/core_peering_connections"

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

## Module Output Variables
----------------------
