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