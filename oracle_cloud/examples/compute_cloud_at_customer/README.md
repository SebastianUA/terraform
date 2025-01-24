# Work with COMPUTE_CLOUD_AT_CUSTOMER via terraform

A terraform module for making COMPUTE_CLOUD_AT_CUSTOMER.


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

module "compute_cloud_at_customer" {
  source = "../../modules/compute_cloud_at_customer"

  enable_ccc_infrastructure = true

  ccc_infrastructure_compartment_id = ""
  ccc_infrastructure_display_name   = ""
  ccc_infrastructure_subnet_id      = ""

  tags = {}
}

```

## Module Input Variables
----------------------
- `name` - The name for resources (`default = test`)
- `environment` - The environment for resources (`default = dev`)
- `tags` - Add additional tags (`default = {}`)
- `enable_ccc_infrastructure` - Enable ccc infrastructure usage (`default = False`)
- `ccc_infrastructure_compartment_id` - (Required) (Updatable) The compartment OCID associated with the infrastructure. (`default = null`)
- `ccc_infrastructure_display_name` - (Required) (Updatable) The name that will be used to display the Compute Cloud@Customer infrastructure in the Oracle Cloud Infrastructure console. Does not have to be unique and can be changed. Avoid entering confidential information. (`default = ""`)
- `ccc_infrastructure_subnet_id` - (Required) (Updatable) Identifier for network subnet that will be used to communicate with Compute Cloud@Customer infrastructure. (`default = null`)
- `ccc_infrastructure_description` - (Optional) (Updatable) A mutable client-meaningful text description of the Compute Cloud@Customer infrastructure. Avoid entering confidential information. (`default = null`)
- `ccc_infrastructure_ccc_upgrade_schedule_id` - (Optional) (Updatable) Schedule used for upgrades. If no schedule is associated with the infrastructure, it can be upgraded at any time. (`default = null`)
- `ccc_infrastructure_connection_details` - (Optional) (Updatable) A message describing the current connection state in more detail. (`default = null`)
- `ccc_infrastructure_connection_state` - (Optional) (Updatable) The current connection state of the Compute Cloud@Customer infrastructure. This value will default to REJECT if the value is not provided. The only valid value at creation time is REJECT. (`default = null`)
- `ccc_infrastructure_freeform_tags` - (Optional) (Updatable) Simple key-value pair that is applied without any predefined name, type or scope. Exists for cross-compatibility only. Example: {'bar-key': 'value'} (`default = {}`)
- `ccc_infrastructure_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Ccc Infrastructure * update - (Defaults to 20 minutes), when updating the Ccc Infrastructure * delete - (Defaults to 20 minutes), when destroying the Ccc Infrastructure (`default = {}`)
- `enable_ccc_upgrade_schedule` - Enable ccc upgrade schedule usages (`default = False`)
- `ccc_upgrade_schedule_compartment_id` - (Required) (Updatable) Compartment OCID for the Compute Cloud@Customer Upgrade Schedule. (`default = null`)
- `ccc_upgrade_schedule_display_name` - (Updatable) Compute Cloud@Customer upgrade schedule display name. Avoid entering confidential information. (`default = ""`)
- `ccc_upgrade_schedule_events` - (Required) (Updatable) List of preferred times for Compute Cloud@Customer infrastructure to be upgraded. (`default = []`)
- `ccc_upgrade_schedule_descriptions` - (Optional) (Updatable) An optional description of the Compute Cloud@Customer upgrade schedule. Avoid entering confidential information. (`default = null`)
- `ccc_upgrade_schedule_freeform_tags` - (Optional) (Updatable) Simple key-value pair that is applied without any predefined name, type or scope. Exists for cross-compatibility only. Example: {'bar-key': 'value'} (`default = {}`)
- `ccc_upgrade_schedule_timeouts` - The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Ccc Upgrade Schedule * update - (Defaults to 20 minutes), when updating the Ccc Upgrade Schedule * delete - (Defaults to 20 minutes), when destroying the Ccc Upgrade Schedule (`default = {}`)

## Module Output Variables
----------------------
- `ccc_infrastructure_id` - The Compute Cloud@Customer infrastructure OCID. This cannot be changed once created.
- `ccc_infrastructure_display_name` - The name that will be used to display the Compute Cloud@Customer infrastructure in the Oracle Cloud Infrastructure console. Does not have to be unique and can be changed. Avoid entering confidential information.
- `ccc_infrastructure_description` - A mutable client-meaningful text description of the Compute Cloud@Customer infrastructure. Avoid entering confidential information.
- `ccc_infrastructure_ccc_upgrade_schedule_id` - Schedule used for upgrades. If no schedule is associated with the infrastructure, it can be updated at any time.
- `ccc_infrastructure_compartment_id` - The infrastructure compartment OCID.
- `ccc_infrastructure_connection_state` - The current connection state of the infrastructure. A user can only update it from REQUEST to READY or from any state back to REJECT. The system automatically handles the REJECT to REQUEST, READY to CONNECTED, or CONNECTED to DISCONNECTED transitions.
- `ccc_upgrade_schedule_id` - Upgrade schedule OCID. This cannot be changed once created.
- `ccc_upgrade_schedule_infrastructure_ids` - List of Compute Cloud@Customer infrastructure OCIDs that are using this upgrade schedule.
- `ccc_upgrade_schedule_state` - Lifecycle state of the resource.
- `ccc_upgrade_schedule_compartment_id` - Compartment OCID for the Compute Cloud@Customer upgrade schedule.
- `ccc_upgrade_schedule_description` - An optional description of the Compute Cloud@Customer upgrade schedule. Avoid entering confidential information.
- `ccc_upgrade_schedule_display_name` - Compute Cloud@Customer upgrade schedule display name. Avoid entering confidential information.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
