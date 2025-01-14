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

module "identity_tag" {
  source = "../../modules/identity_tag"

  enable_identity_tag_namespace         = true
  identity_tag_namespace_compartment_id = ""
  identity_tag_namespace_name           = ""
  identity_tag_namespace_description    = ""

  enable_identity_tag           = true
  identity_tag_name             = ""
  identity_tag_description      = ""
  identity_tag_tag_namespace_id = ""

  tags = {}

}
