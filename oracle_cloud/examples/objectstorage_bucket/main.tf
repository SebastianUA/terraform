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

module "objectstorage_bucket" {
  source = "../../modules/objectstorage_bucket"

  enable_objectstorage_bucket = true

  objectstorage_bucket_name           = "ibucket-1"
  objectstorage_bucket_namespace      = "deploys"
  objectstorage_bucket_compartment_id = "ocid1.compartment.oc1..exampleuniqueID"


  objectstorage_bucket_retention_rules = [
    {
      display_name = "RetentionRule1"
      duration = {
        time_amount = 30
        time_unit   = "DAYS"
      }
      time_rule_locked = true
    },
    {
      # No display_name provided; defaults to "rule-2"
      duration = {
        time_amount = 365
        time_unit   = "DAYS"
      }
      # time_rule_locked not provided; defaults to false
    }
    # Add up to 100 retention rules
  ]

  tags = {}
}
