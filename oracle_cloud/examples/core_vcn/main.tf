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

  enable_core_vcn         = true
  core_vcn_compartment_id = "captainua"
  core_vcn_display_name   = "main-vcn-1"

  # DHCP:
  enable_core_dhcp_options         = true
  core_dhcp_options_compartment_id = "captainua"
  core_dhcp_options_options = [
    {
      type                = "DomainNameServer"
      server_type         = "CustomDnsServer"
      custom_dns_servers  = ["10.0.0.1", "10.0.0.2"]
      search_domain_names = ["example.com", "subdomain.example.com"]
    },
    {
      type                = "SearchDomain"
      server_type         = null
      custom_dns_servers  = null
      search_domain_names = ["anotherdomain.com"]
    },
    {
      type        = "DomainNameServer"
      server_type = "VcnLocalPlusInternet"
    }
  ]

}
