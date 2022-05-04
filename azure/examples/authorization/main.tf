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