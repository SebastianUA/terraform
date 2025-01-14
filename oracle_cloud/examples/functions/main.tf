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

module "functions" {
  source = "../../modules/functions"

  enable_functions_application         = true
  functions_application_compartment_id = ""
  functions_application_display_name   = ""
  functions_application_subnet_ids     = []

  enable_functions_function = true
  # functions_function_application_id = ""
  functions_function_display_name  = ""
  functions_function_memory_in_mbs = 128

  functions_function_image        = null
  functions_function_image_digest = null

  tags = {}
}
