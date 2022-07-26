# Work with DATABRICKS via terraform

A terraform module for making DATABRICKS.


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

module "databricks" {
  source = "../../modules/databricks"

  // databricks workspace
  enable_databricks_workspace              = true
  databricks_workspace_name                = "databricks-test"
  databricks_workspace_location            = module.base_resource_group.resource_group_location
  databricks_workspace_resource_group_name = module.base_resource_group.resource_group_name
  databricks_workspace_sku                 = "premium"

  databricks_workspace_customer_managed_key_enabled = true

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
- `enable_databricks_workspace` - Enable databricks workspace usage (`default = False`)
- `databricks_workspace_name` - Specifies the name of the Databricks Workspace resource. Changing this forces a new resource to be created. (`default = ""`)
- `databricks_workspace_resource_group_name` - (Required) The name of the Resource Group in which the Databricks Workspace should exist. Changing this forces a new resource to be created. (`default = null`)
- `databricks_workspace_location` - (Required) Specifies the supported Azure location where the resource has to be created. Changing this forces a new resource to be created. (`default = null`)
- `databricks_workspace_load_balancer_backend_address_pool_id` - (Optional) Resource ID of the Outbound Load balancer Backend Address Pool for Secure Cluster Connectivity (No Public IP) workspace. Changing this forces a new resource to be created. (`default = null`)
- `databricks_workspace_sku` - (Required) The sku to use for the Databricks Workspace. Possible values are standard, premium, or trial. Changing this can force a new resource to be created in some circumstances. (`default = null`)
- `databricks_workspace_managed_services_cmk_key_vault_key_id` - (Optional) Customer managed encryption properties for the Databricks Workspace managed resources(e.g. Notebooks and Artifacts). Changing this forces a new resource to be created. (`default = null`)
- `databricks_workspace_managed_resource_group_name` - (Optional) The name of the resource group where Azure should place the managed Databricks resources. Changing this forces a new resource to be created. (`default = null`)
- `databricks_workspace_customer_managed_key_enabled` - (Optional) Is the workspace enabled for customer managed key encryption? If true this enables the Managed Identity for the managed storage account. Possible values are true or false. Defaults to false. This field is only valid if the Databricks Workspace sku is set to premium. Changing this forces a new resource to be created. (`default = null`)
- `databricks_workspace_infrastructure_encryption_enabled` - Optional) Is the Databricks File System root file system enabled with a secondary layer of encryption with platform managed keys? Possible values are true or false. Defaults to false. This field is only valid if the Databricks Workspace sku is set to premium. Changing this forces a new resource to be created. (`default = null`)
- `databricks_workspace_public_network_access_enabled` - (Optional) Allow public access for accessing workspace. Set value to false to access workspace only via private link endpoint. Possible values include true or false. Defaults to true. Changing this forces a new resource to be created. (`default = null`)
- `databricks_workspace_network_security_group_rules_required` - (Optional) Does the data plane (clusters) to control plane communication happen over private link endpoint only or publicly? Possible values AllRules, NoAzureDatabricksRules or NoAzureServiceRules. Required when public_network_access_enabled is set to false. Changing this forces a new resource to be created. (`default = null`)
- `databricks_workspace_custom_parameters` - (Optional) A custom_parameters block  (`default = {}`)
- `databricks_workspace_timeouts` - Set timeouts for databricks workspace (`default = {}`)
- `enable_databricks_workspace_customer_managed_key` - Enable databricks workspace customer managed key usage (`default = False`)
- `databricks_workspace_customer_managed_key_workspace_id` - The ID of the Databricks workspace. (`default = ""`)
- `databricks_workspace_customer_managed_key_key_vault_key_id` - (Required) The ID of the Key Vault. (`default = null`)
- `databricks_workspace_customer_managed_key_timeouts` - Set timeouts for databricks workspace customer managed key (`default = {}`)

## Module Output Variables
----------------------
- `databricks_workspace_id` - The ID of the Databricks Workspace in the Azure management plane.
- `databricks_workspace_managed_resource_group_id` - The ID of the Managed Resource Group created by the Databricks Workspace.
- `databricks_workspace_workspace_url` - The workspace URL which is of the format 'adb-{workspaceId}.{random}.azuredatabricks.net'
- `databricks_workspace_workspace_id` - The unique identifier of the databricks workspace in Databricks control plane.
- `databricks_workspace_storage_account_identity` - A storage_account_identity block
- `databricks_workspace_customer_managed_key_id` - The ID of the Databricks Customer Managed Key.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
