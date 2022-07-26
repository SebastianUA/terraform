# Work with ACTIVE_DIRECTORY via terraform

A terraform module for making ACTIVE_DIRECTORY.


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
  resource_group_name     = ""
  resource_group_location = "West Europe"

  tags = tomap({
    "Environment"   = "test",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

}

module "ad" {
  source = "../../modules/active_directory"

  // active directory directory domain service
  enable_active_directory_domain_service              = true
  active_directory_domain_service_name                = ""
  active_directory_domain_service_location            = module.base_resource_group.resource_group_location
  active_directory_domain_service_resource_group_name = module.base_resource_group.resource_group_name

  active_directory_domain_service_domain_name           = "widgetslogin.net"
  active_directory_domain_service_sku                   = "Enterprise"
  active_directory_domain_service_filtered_sync_enabled = false

  active_directory_domain_service_initial_replica_set = {
    subnet_id = "subnet_id_here"
  }

  active_directory_domain_service_notifications = [
    {
      additional_recipients = ["notifyA@example.net", "notifyB@example.org"]
      notify_dc_admins      = true
      notify_global_admins  = true
    }
  ]

  active_directory_domain_service_security = {
    sync_kerberos_passwords = true
    sync_ntlm_passwords     = true
    sync_on_prem_passwords  = true
  }

  // active directory domain service replica set
  enable_active_directory_domain_service_replica_set    = false
  active_directory_domain_service_replica_set_location  = module.base_resource_group.resource_group_location
  active_directory_domain_service_replica_set_subnet_id = "subnet_id_here"

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
- `enable_active_directory_domain_service` - Enable active directory domain service usage (`default = False`)
- `active_directory_domain_service_name` - The display name for your managed Active Directory Domain Service resource. Changing this forces a new resource to be created. (`default = ""`)
- `active_directory_domain_service_location` - (Required) The Azure location where the Domain Service exists. Changing this forces a new resource to be created. (`default = null`)
- `active_directory_domain_service_resource_group_name` - (Required) The name of the Resource Group in which the Domain Service should exist. Changing this forces a new resource to be created. (`default = null`)
- `active_directory_domain_service_sku` - (Required) The SKU to use when provisioning the Domain Service resource. One of Standard, Enterprise or Premium (`default = null`)
- `active_directory_domain_service_domain_name` - (Required) The Active Directory domain to use. See official documentation for constraints and recommendations. (`default = null`)
- `active_directory_domain_service_filtered_sync_enabled` - Whether to enable group-based filtered sync (also called scoped synchronisation). Defaults to false (`default = null`)
- `active_directory_domain_service_secure_ldap` - (Optional) A secure_ldap block (`default = []`)
- `active_directory_domain_service_initial_replica_set` - (Required) An initial_replica_set block. The initial replica set inherits the same location as the Domain Service resource. (`default = []`)
- `user_assigned_identity_notifications` - (Optional) A notifications block (`default = []`)
- `user_assigned_identity_security` - (Optional) A security block (`default = {}`)
- `user_assigned_identity_timeouts` - Set timeouts for user assigned identity (`default = {}`)
- `enable_active_directory_domain_service_replica_set` - Enable active directory domain service replica set usage (`default = False`)
- `active_directory_domain_service_replica_set_domain_service_id` - The ID of the Domain Service for which to create this Replica Set. Changing this forces a new resource to be created. (`default = ""`)
- `active_directory_domain_service_replica_set_location` - (Required) The Azure location where this Replica Set should exist. Changing this forces a new resource to be created. (`default = null`)
- `active_directory_domain_service_replica_set_subnet_id` - (Required) The ID of the subnet in which to place this Replica Set. (`default = null`)
- `active_directory_domain_service_replica_set_timeouts` - Set timeouts active directory domain service replica set (`default = {}`)

## Module Output Variables
----------------------
- `active_directory_domain_service_id` - The ID of the Domain Service.
- `active_directory_domain_service_deployment_id` - A unique ID for the managed domain deployment.
- `active_directory_domain_service_resource_id` - The Azure resource ID for the domain service.
- `active_directory_domain_service_replica_set_id` - The ID of the Domain Service Replica Set.
- `active_directory_domain_service_replica_set_domain_controller_ip_addresses` - A list of subnet IP addresses for the domain controllers in this Replica Set, typically two.
- `active_directory_domain_service_replica_set_external_access_ip_address` - The publicly routable IP address for the domain controllers in this Replica Set.
- `active_directory_domain_service_replica_set_service_status` - The current service status for the replica set.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
