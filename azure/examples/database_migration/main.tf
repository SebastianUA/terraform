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