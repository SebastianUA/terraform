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