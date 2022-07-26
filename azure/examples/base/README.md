# Work with BASE via terraform

A terraform module for making BASE.


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

module "base_subscription" {
  source = "../../modules/base"

  enable_subscription = true
  subscription_name   = "My Example MPA Subscription"
  subscription_alias  = "examplesub"
  subscription_id     = "12345678-12234-5678-9012-123456789012"


  tags = tomap({
    "Environment"   = "test",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

}

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = this`)
- `environment` - Environment for service (`default = test`)
- `tags` - Add additional tags (`default = {}`)
- `enable_resource_group` - Enable resource group usage (`default = False`)
- `resource_group_name` - The Name which should be used for this Resource Group. Changing this forces a new Resource Group to be created. (`default = ""`)
- `resource_group_location` - (Required) The Azure Region where the Resource Group should exist. Changing this forces a new Resource Group to be created. (`default = null`)
- `resource_group_timeouts` - Set timeouts for resource group (`default = {}`)
- `enable_resource_provider_registration` - Enable resource provider registration usage (`default = False`)
- `resource_provider_registration_name` - (Required) The namespace of the Resource Provider which should be registered. Changing this forces a new resource to be created. (`default = null`)
- `resource_provider_registration_feature` - (Optional) A list of feature blocks (`default = []`)
- `resource_provider_registration_timeouts` - Set timeouts for resource provider registration (`default = {}`)
- `enable_subscription` - Enable subscription usage (`default = False`)
- `subscription_name` - The Name of the Subscription. This is the Display Name in the portal. (`default = ""`)
- `subscription_alias` - (Optional) The Alias name for the subscription. Terraform will generate a new GUID if this is not supplied. Changing this forces a new Subscription to be created. (`default = null`)
- `subscription_billing_scope_id` - (Optional) The Azure Billing Scope ID. Can be a Microsoft Customer Account Billing Scope ID, a Microsoft Partner Account Billing Scope ID or an Enrollment Billing Scope ID. (`default = null`)
- `subscription_id` - (Optional) The ID of the Subscription. Changing this forces a new Subscription to be created. (`default = null`)
- `subscription_workload` - (Optional) The workload type of the Subscription. Possible values are Production (default) and DevTest. Changing this forces a new Subscription to be created. (`default = null`)
- `subscription_timeouts` - Set timeouts for resource provider registration (`default = {}`)

## Module Output Variables
----------------------
- `resource_group_id` - The ID of the Resource Group.
- `resource_group_name` - The name of the Resource Group.
- `resource_group_location` - The location of the Resource Group.
- `resource_provider_registration_id` - The ID of the Resource provider registration.
- `subscription_id` - The Resource ID of the Alias.
- `subscription_tenant_id` - The ID of the Tenant to which the subscription belongs.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
