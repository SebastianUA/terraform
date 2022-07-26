# Work with DISK via terraform

A terraform module for making DISK.


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
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.1.0"
    }
  }
}

provider "azurerm" {
  # The AzureRM Provider supports authenticating using via the Azure CLI, a Managed Identity
  # and a Service Principal. More information on the authentication methods supported by
  # the AzureRM Provider can be found here:
  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs#authenticating-to-azure

  # The features block allows changing the behaviour of the Azure Provider, more
  # information can be found here:
  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/features-block
  features {}

  // subscription_id = ""
  // tenant_id       = ""
}

module "base_resource_group" {
  source = "../../modules/base"

  enable_resource_group   = true
  resource_group_name     = "res-group"
  resource_group_location = "West Europe"

  tags = tomap({
    "Environment"   = "test",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

}

module "disk_pool" {
  source = "../../modules/disk_pool"

  // disk pool
  enable_disk_pool              = true
  disk_pool_name                = "disk-pool"
  disk_pool_location            = module.base_resource_group.resource_group_location
  disk_pool_resource_group_name = module.base_resource_group.resource_group_name
  disk_pool_subnet_id           = "sub-net-id"
  disk_pool_sku_name            = "Standard_1vCores"
  disk_pool_zones               = ["1"]

  tags = tomap({
    "Environment"   = "test",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

  depends_on = [
    module.base_resource_group
  ]

}
```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = this`)
- `environment` - Environment for service (`default = test`)
- `tags` - Add additional tags (`default = {}`)
- `enable_disk_pool` - Enable disk pool usage (`default = False`)
- `disk_pool_name` - The name of the Disk Pool. Changing this forces a new Disk Pool to be created. (`default = ""`)
- `disk_pool_resource_group_name` - (Required) The name of the Resource Group where the Disk Pool should exist. Changing this forces a new Disk Pool to be created. (`default = null`)
- `disk_pool_location` - (Required) The Azure Region where the Disk Pool should exist. Changing this forces a new Disk Pool to be created. (`default = null`)
- `disk_pool_sku_name` - (Required) The SKU of the Disk Pool. Possible values are Basic_B1, Standard_S1 and Premium_P1. Changing this forces a new Disk Pool to be created. (`default = null`)
- `disk_pool_subnet_id` - (Required) The ID of the Subnet where the Disk Pool should be created. Changing this forces a new Disk Pool to be created. (`default = null`)
- `disk_pool_zones` - (Required) Specifies a list of Availability Zones in which this Disk Pool should be located. Changing this forces a new Disk Pool to be created. (`default = null`)
- `disk_pool_timeouts` - Set timeouts disk pool (`default = {}`)
- `enable_disk_pool_managed_disk_attachment` - Enable disk pool managed disk attachment usage (`default = False`)
- `disk_pool_managed_disk_attachment_disk_pool_id` - The ID of the Disk Pool. Changing this forces a new Disk Pool Managed Disk Attachment to be created. (`default = ""`)
- `disk_pool_managed_disk_attachment_managed_disk_id` - (Required) The ID of the Managed Disk. Changing this forces a new Disks Pool Managed Disk Attachment to be created. (`default = null`)
- `disk_pool_managed_disk_attachment_timeouts` - Set timeouts for disk pool managed disk attachment (`default = {}`)
- `enable_disk_pool_iscsi_target` - Enable disk pool iscsi target usage (`default = False`)
- `disk_pool_iscsi_target_name` - (Required) The name of the iSCSI Target. The name can only contain lowercase letters, numbers, periods, or hyphens, and length should between [5-223]. Changing this forces a new iSCSI Target to be created. (`default = ""`)
- `disk_pool_iscsi_target_acl_mode` - (Required) Mode for Target connectivity. The only supported value is Dynamic for now. Changing this forces a new iSCSI Target to be created. (`default = null`)
- `disk_pool_iscsi_target_disks_pool_id` - The ID of the Disk Pool. Changing this forces a new iSCSI Target to be created. (`default = ""`)
- `disk_pool_iscsi_target_target_iqn` - (Optional) ISCSI Target IQN (iSCSI Qualified Name); example: iqn.2005-03.org.iscsi:server. IQN should follow the format iqn.yyyy-mm.<abc>.<pqr>[:xyz]; supported characters include alphanumeric characters in lower case, hyphen, dot and colon, and the length should between 4 and 223. Changing this forces a new iSCSI Target to be created. (`default = null`)
- `disk_pool_iscsi_target_timeouts` - Set timeouts for disk pool iscsi target (`default = {}`)
- `enable_disk_pool_iscsi_target_lun` - Enable disk pool iscsi target lun usage (`default = False`)
- `disk_pool_iscsi_target_lun_name` - User defined name for iSCSI LUN. Supported characters include uppercase letters, lowercase letters, numbers, periods, underscores or hyphens. Name should end with an alphanumeric character. The length must be between 1 and 90. Changing this forces a new iSCSI Target LUN to be created. (`default = ""`)
- `disk_pool_iscsi_target_lun_iscsi_target_id` - The ID of the iSCSI Target. Changing this forces a new iSCSI Target LUN to be created. (`default = ""`)
- `disk_pool_iscsi_target_lun_disk_pool_managed_disk_attachment_id` - The ID of the azurerm_disk_pool_managed_disk_attachment. Changing this forces a new iSCSI Target LUN to be created. (`default = ""`)
- `disk_pool_iscsi_target_lun_timeouts` - Set timeouts for disk pool iscsi target lun (`default = {}`)

## Module Output Variables
----------------------
- `disk_pool_id` - The ID of the Disk Pool.
- `disk_pool_name` - The name of the Disk Pool.
- `disk_pool_managed_disk_attachment_id` - The ID of the Disk Pool Managed Disk Attachment.
- `disk_pool_iscsi_target_id` - The ID of the iSCSI Target.
- `disk_pool_iscsi_target_endpoints` - List of private IPv4 addresses to connect to the iSCSI Target.
- `disk_pool_iscsi_target_port` - The port used by iSCSI Target portal group.
- `disk_pool_iscsi_target_lun_id` - The ID of the iSCSI Target LUN.
- `disk_pool_iscsi_target_lun_lun` - The Logical Unit Number of the iSCSI Target LUN.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
