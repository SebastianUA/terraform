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

module "cdn" {
  source = "../../modules/sdn"

  // CDN profile
  enable_cdn_profile              = true
  cdn_profile_name                = ""
  cdn_profile_location            = module.base_resource_group.resource_group_location
  cdn_profile_resource_group_name = module.base_resource_group.resource_group_name
  cdn_profile_sku                 = "Standard_Verizon"

  // CDN endpoint
  enable_cdn_endpoint              = true
  cdn_endpoint_name                = ""
  cdn_endpoint_location            = module.base_resource_group.resource_group_location
  cdn_endpoint_resource_group_name = module.base_resource_group.resource_group_name
  cdn_endpoint_origin = {
    name      = "example"
    host_name = "www.contoso.com"
  }

  // CDN endpoint custom domain
  enable_cdn_endpoint_custom_domain    = false
  cdn_endpoint_custom_domain_name      = ""
  cdn_endpoint_custom_domain_host_name = "linux-notes"

  tags = tomap({
    "Environment"   = "test",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

  depends_on = [
    module.base_resource_group
  ]

}