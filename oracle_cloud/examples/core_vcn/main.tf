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
  source = "../../modules/core_vcn"

  compartment_id = "ocid1.tenancy.oc1..aaaaaaaaepggbbn72sgkuxbmx2ifwpjuy2dx5kzhsveteiagrbwasjahdrxa"

  # VCN:
  enable_core_vcn       = true
  core_vcn_display_name = "main-vcn-1"

  # DHCP:
  enable_core_dhcp_options = true
  core_vcn_cidr_blocks     = ["10.0.0.0/16"]
  core_dhcp_options_options = [
    {
      type                = "DomainNameServer"
      server_type         = "VcnLocalPlusInternet"
      search_domain_names = ["main-vcn-1.oraclevcn.com"]
    },
  ]

  //core_subnet_privates_display_name = "private"
  core_subnet_privates_cidr_blocks = ["10.0.0.0/24", "10.0.1.0/24"]
  //core_subnet_publics_display_name = "public"
  core_subnet_publics_cidr_blocks = ["10.0.10.0/24", "10.0.11.0/24"]

  # RT
  core_route_table_publics_display_name  = "public-rt"
  core_route_table_privates_display_name = "private-rt"

  # internet gateway 
  enable_core_internet_gateway       = true
  core_internet_gateway_display_name = "my-igtw"
  core_internet_gateway_enabled      = true

  # nat gateway
  enable_core_nat_gateway        = true
  core_nat_gateway_display_name  = "my-natgtw"
  core_nat_gateway_block_traffic = null
}
