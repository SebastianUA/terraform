# Work with DATABASE_MIGRATION via terraform

A terraform module for making DATABASE_MIGRATION.


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

module "database_migration" {
  source = "../../modules/database_migration"

  // DB migration service
  enable_database_migration_service              = true
  database_migration_service_name                = ""
  database_migration_service_location            = module.base_resource_group.resource_group_location
  database_migration_service_resource_group_name = module.base_resource_group.resource_group_name
  database_migration_service_subnet_id           = "sub-net-id"
  database_migration_service_sku_name            = "Standard_1vCores"

  // BD migration project
  enable_database_migration_project              = true
  database_migration_project_name                = ""
  database_migration_project_resource_group_name = module.base_resource_group.resource_group_name
  database_migration_project_location            = module.base_resource_group.resource_group_location
  database_migration_project_source_platform     = "SQL"
  database_migration_project_target_platform     = "SQLDB"

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
- `enable_database_migration_service` - Enable database migration service usage (`default = False`)
- `database_migration_service_name` - Specify the name of the database migration service. Changing this forces a new resource to be created. (`default = ""`)
- `database_migration_service_location` - (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. (`default = null`)
- `database_migration_service_resource_group_name` - (Required) Name of the resource group in which to create the database migration service. Changing this forces a new resource to be created. (`default = null`)
- `database_migration_service_subnet_id` - (Required) The ID of the virtual subnet resource to which the database migration service should be joined. Changing this forces a new resource to be created. (`default = null`)
- `database_migration_service_sku_name` - (Required) The SKU name of the database migration service. Possible values are Premium_4vCores, Standard_1vCores, Standard_2vCores and Standard_4vCores. Changing this forces a new resource to be created. (`default = null`)
- `database_migration_service_timeouts` - Set timeouts for database migration service (`default = {}`)
- `enable_database_migration_project` - Enable database migration project usage (`default = False`)
- `database_migration_project_name` - Specify the name of the database migration project. Changing this forces a new resource to be created. (`default = ""`)
- `database_migration_project_service_name` - Name of the database migration service where resource belongs to. Changing this forces a new resource to be created. (`default = ""`)
- `database_migration_project_resource_group_name` - (Required) Name of the resource group in which to create the database migration project. Changing this forces a new resource to be created. (`default = null`)
- `database_migration_project_location` - (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. (`default = null`)
- `database_migration_project_source_platform` - (Required) The platform type of the migration source. Currently only support: SQL(on-premises SQL Server). Changing this forces a new resource to be created. (`default = null`)
- `database_migration_project_target_platform` - (Required) The platform type of the migration target. Currently only support: SQLDB(Azure SQL Database). Changing this forces a new resource to be created. (`default = null`)
- `database_migration_project_timeouts` - Set timeouts for database migration project (`default = {}`)

## Module Output Variables
----------------------
- `database_migration_service_id` - The ID of Database Migration Service.
- `database_migration_service_name` - The name of Database Migration Service.
- `database_migration_project_id` - The ID of Database Migration Project.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
