# Work with MANAGEMENT via terraform

A terraform module for making MANAGEMENT.


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
      version = "3.1.0"
    }
  }
}


provider "azurerm" {
  # Configuration options
}

data "azurerm_subscription" "current" {
}

data "azurerm_management_group" "example" {
  name = "exampleManagementGroup"
}

data "azurerm_subscription" "example" {
  subscription_id = "12345678-1234-1234-1234-123456789012"
}

module "management_group_parent" {
  source = "../../modules/management_group"

  enable_management_group = true
  management_group_name   = "test-parent-group"

  # management group (parent usage)
  management_group_subscription_ids = [
    data.azurerm_subscription.current.subscription_id
  ]

  # management lock
  enable_management_lock     = true
  management_lock_name       = ""
  management_lock_scope      = data.azurerm_subscription.current.id
  management_lock_lock_level = "CanNotDelete"

  # 
  enable_management_group_subscription_association              = true
  management_group_subscription_association_management_group_id = data.azurerm_management_group.example.id
  management_group_subscription_association_subscription_id     = data.azurerm_subscription.example.id

  tags = tomap({
    "Environment"   = "test",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

  depends_on = [
    data.azurerm_subscription.current
  ]
}

module "management_group_child" {
  source = "../../modules/management_group"

  enable_management_group = true
  management_group_name   = "test-child-group"

  # management group (child usage)
  management_group_parent_management_group_id = module.management_group_parent.management_group_id

  tags = tomap({
    "Environment"   = "test",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

  depends_on = [
    module.management_group_parent,
    data.azurerm_subscription.current
  ]
}
```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = this`)
- `environment` - Environment for service (`default = test`)
- `tags` - Add additional tags (`default = {}`)
- `enable_management_group` - Enable management group usage (`default = False`)
- `management_group_name` - The name or UUID for this Management Group, which needs to be unique across your tenant. A new UUID will be generated if not provided. Changing this forces a new resource to be created. (`default = ""`)
- `management_group_display_name` - (Optional) A friendly name for this Management Group. If not specified, this will be the same as the name (`default = null`)
- `management_group_parent_management_group_id` - (Optional) The ID of the Parent Management Group. Changing this forces a new resource to be created. (`default = null`)
- `management_group_subscription_ids` - (Optional) A list of Subscription GUIDs which should be assigned to the Management Group. (`default = null`)
- `management_group_timeouts` - Set timeouts for management group (`default = {}`)
- `enable_management_lock` - Enable management lock usage (`default = False`)
- `management_lock_name` - Specifies the name of the Management Lock. Changing this forces a new resource to be created. (`default = ""`)
- `management_lock_scope` - (Required) Specifies the scope at which the Management Lock should be created. Changing this forces a new resource to be created. (`default = null`)
- `management_lock_lock_level` - (Required) Specifies the Level to be used for this Lock. Possible values are CanNotDelete and ReadOnly. Changing this forces a new resource to be created. (`default = null`)
- `management_lock_notes` - (Optional) Specifies some notes about the lock. Maximum of 512 characters. Changing this forces a new resource to be created. (`default = null`)
- `management_lock_timeouts` - Set timeouts management lock (`default = {}`)
- `enable_management_group_subscription_association` - Enable management group subscription association usage (`default = False`)
- `management_group_subscription_association_management_group_id` - (Required) The ID of the Management Group to associate the Subscription with. Changing this forces a new Management to be created. (`default = null`)
- `management_group_subscription_association_subscription_id` - (Required) The ID of the Subscription to be associated with the Management Group. Changing this forces a new Management to be created. (`default = null`)
- `management_group_subscription_association_timeouts` - Set timeouts for management group subscription association (`default = {}`)

## Module Output Variables
----------------------
- `management_group_id` - The ID of the Management Group.
- `management_lock_id` - The ID of the Management Lock.
- `management_group_subscription_association_id` - The ID of the Management Group Subscription Association.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
