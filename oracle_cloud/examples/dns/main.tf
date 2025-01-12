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

module "dns" {
  source = "../../modules/dns"

  enable_dns_record = true
  # dns_record_zone_name_or_id = ""
  dns_record_domain = ""
  dns_record_rtype  = ""

  dns_record_rdata = ""
  dns_record_ttl   = ""
}
