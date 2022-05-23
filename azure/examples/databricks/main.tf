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