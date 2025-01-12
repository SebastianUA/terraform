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

module "container_instances" {
  source = "../../modules/container_instances"

  enable_container_instance              = true
  container_instance_availability_domain = ""
  container_instance_compartment_id      = ""
  container_instance_shape               = ""

  container_instance_containers = [
    {

    }
  ]

  container_instance_shape_config = {}

  container_instance_vnics = []

  container_instance_display_name = ""

  tags = {}
}
