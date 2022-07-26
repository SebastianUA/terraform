# Work with AUTHORIZATION via terraform

A terraform module for making AUTHORIZATION.


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

data "azurerm_subscription" "primary" {}
data "azurerm_client_config" "primary" {}
data "azurerm_management_group" "primary" {}

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

module "authorization" {
  source = "../../modules/authorization"

  // role definition
  enable_role_definition      = true
  role_definition_name        = ""
  role_definition_scope       = data.azurerm_subscription.primary.id
  role_definition_description = "test role"

  role_definition_permissions = [
    {
      actions     = ["*"]
      not_actions = []
    }
  ]

  role_definition_assignable_scopes = [
    data.azurerm_subscription.primary.id, # /subscriptions/00000000-0000-0000-0000-000000000000
  ]

  // role assignment
  enable_role_assignment       = true
  role_assignment_name         = ""
  role_assignment_scope        = data.azurerm_management_group.primary.id
  role_assignment_principal_id = data.azurerm_client_config.primary.object_id

  // user assigned identity
  enable_user_assigned_identity              = true
  user_assigned_identity_name                = ""
  user_assigned_identity_resource_group_name = module.base_resource_group.resource_group_name
  user_assigned_identity_location            = module.base_resource_group.resource_group_location

  tags = tomap({
    "Environment"   = "test",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

  depends_on = [
    data.azurerm_subscription,
    module.base_resource_group
  ]
}
```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = this`)
- `environment` - Environment for service (`default = test`)
- `tags` - Add additional tags (`default = {}`)
- `enable_role_definition` - Enable role definition usage (`default = False`)
- `role_definition_name` - The name of the Role Definition. Changing this forces a new resource to be created. (`default = ""`)
- `role_definition_scope` - (Required) The scope at which the Role Definition applies to, such as /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333, /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333/resourceGroups/myGroup, or /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333/resourceGroups/myGroup/providers/Microsoft.Compute/virtualMachines/myVM. It is recommended to use the first entry of the assignable_scopes. Changing this forces a new resource to be created. (`default = null`)
- `role_definition_description` - (Optional) A description of the Role Definition. (`default = null`)
- `role_definition_role_definition_id` - (Optional) A unique UUID/GUID which identifies this role - one will be generated if not specified. Changing this forces a new resource to be created. (`default = null`)
- `role_definition_assignable_scopes` - (Optional) One or more assignable scopes for this Role Definition, such as /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333, /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333/resourceGroups/myGroup, or /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333/resourceGroups/myGroup/providers/Microsoft.Compute/virtualMachines/myVM (`default = null`)
- `role_definition_permissions` - (Optional) A permissions block (`default = []`)
- `role_definition_timeouts` - Set timeouts for role definition (`default = {}`)
- `enable_role_assignment` - Enable role assignment usage (`default = False`)
- `role_assignment_name` - (Optional) A unique UUID/GUID for this Role Assignment - one will be generated if not specified. Changing this forces a new resource to be created. (`default = null`)
- `role_assignment_scope` - (Required) The scope at which the Role Assignment applies to, such as /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333, /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333/resourceGroups/myGroup, or /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333/resourceGroups/myGroup/providers/Microsoft.Compute/virtualMachines/myVM, or /providers/Microsoft.Management/managementGroups/myMG. Changing this forces a new resource to be created. (`default = null`)
- `role_assignment_principal_id` -  (Required) The ID of the Principal (User, Group or Service Principal) to assign the Role Definition to. Changing this forces a new resource to be created. (`default = null`)
- `role_assignment_description` - (Optional) The description for this Role Assignment. Changing this forces a new resource to be created. (`default = null`)
- `role_assignment_role_definition_id` - (Optional) The Scoped-ID of the Role Definition. Changing this forces a new resource to be created. Conflicts with role_definition_name (`default = null`)
- `role_assignment_role_definition_name` - (Optional) The name of a built-in Role. Changing this forces a new resource to be created. Conflicts with role_definition_id (`default = null`)
- `role_assignment_condition` - (Optional) The condition that limits the resources that the role can be assigned to. Changing this forces a new resource to be created. (`default = null`)
- `role_assignment_condition_version` - (Optional) The version of the condition. Possible values are 1.0 or 2.0. Changing this forces a new resource to be created. (`default = null`)
- `role_assignment_delegated_managed_identity_resource_id` - (Optional) The delegated Azure Resource Id which contains a Managed Identity. Changing this forces a new resource to be created. (`default = null`)
- `role_assignment_skip_service_principal_aad_check` - (Optional) If the principal_id is a newly provisioned Service Principal set this value to true to skip the Azure Active Directory check which may fail due to replication lag. This argument is only valid if the principal_id is a Service Principal identity. If it is not a Service Principal identity it will cause the role assignment to fail. Defaults to false (`default = null`)
- `role_assignment_timeouts` - Set timeouts for role assignment (`default = {}`)
- `enable_user_assigned_identity` - Enable user assigned identity usage (`default = False`)
- `user_assigned_identity_name` - The name of the user assigned identity. Changing this forces a new identity to be created. (`default = ""`)
- `user_assigned_identity_resource_group_name` - (Required) The name of the resource group in which to create the user assigned identity. (`default = null`)
- `user_assigned_identity_location` - (Required) The location/region where the user assigned identity is created. (`default = null`)
- `user_assigned_identity_timeouts` - Set timeouts for user assigned identity (`default = {}`)

## Module Output Variables
----------------------
- `role_definition_id` - This ID is specific to Terraform - and is of the format {roleDefinitionId}|{scope}.
- `role_definition_role_definition_id` - The Role Definition ID.
- `role_definition_role_definition_resource_id` - The Azure Resource Manager ID for the resource.
- `role_assignment_id` - The Role Assignment ID.
- `role_assignment_principal_type` - The type of the principal_id, e.g. User, Group, Service Principal, Application, etc.
- `user_assigned_identity_id` - The user assigned identity ID.
- `user_assigned_identity_principal_id` - Service Principal ID associated with the user assigned identity.
- `user_assigned_identity_client_id` - Client ID associated with the user assigned identity.
- `user_assigned_identity_tenant_id` - Tenant ID associated with the user assigned identity.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
