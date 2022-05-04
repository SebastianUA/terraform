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

module "private_dns" {
  source = "../../modules/private_dns"

  // private dns zone
  enable_private_dns_zone              = true
  private_dns_zone_name                = "linux-notes.org"
  private_dns_zone_resource_group_name = module.base_resource_group.resource_group_name

  // private dns txt record
  enable_private_dns_txt_record              = true
  private_dns_txt_record_name                = "txt"
  private_dns_txt_record_resource_group_name = module.base_resource_group.resource_group_name
  private_dns_txt_record_ttl                 = 300
  private_dns_txt_record_record = [
    {
      value = "more site information here"
    },
    {
      value = "google-site-authenticator"
    }
  ]

  // private dns srv record
  enable_private_dns_srv_record              = true
  private_dns_srv_record_name                = "srv"
  private_dns_srv_record_resource_group_name = module.base_resource_group.resource_group_name
  private_dns_srv_record_ttl                 = 300
  private_dns_srv_record_record = [
    {
      priority = 1
      weight   = 5
      port     = 8080
      target   = "target1.contoso.com"
    }
  ]

  // private dns ptr record
  enable_private_dns_ptr_record              = true
  private_dns_ptr_record_name                = "ptr"
  private_dns_ptr_record_resource_group_name = module.base_resource_group.resource_group_name
  private_dns_ptr_record_ttl                 = 300
  private_dns_ptr_record_records             = ["yourdomain.com"]

  // private dns mx record
  enable_private_dns_mx_record              = true
  private_dns_mx_record_name                = "mx"
  private_dns_mx_record_resource_group_name = module.base_resource_group.resource_group_name
  private_dns_mx_record_ttl                 = 300
  private_dns_mx_record_records = [
    {
      preference = 10
      exchange   = "mail1.contoso.com"
    },
    {
      preference = 20
      exchange   = "mail2.contoso.com"
    }
  ]

  // private dns cname record
  enable_private_dns_cname_record              = true
  private_dns_cname_record_name                = "cname"
  private_dns_cname_record_resource_group_name = module.base_resource_group.resource_group_name
  private_dns_cname_record_ttl                 = 300
  private_dns_cname_record_record              = "contoso.com"

  // private dns aaaa record
  enable_private_dns_aaaa_record              = true
  private_dns_aaaa_record_name                = "aaaa"
  private_dns_aaaa_record_resource_group_name = module.base_resource_group.resource_group_name
  private_dns_aaaa_record_ttl                 = 300
  private_dns_aaaa_record_records             = ["2001:db8::1:0:0:1"]

  // private dns a record
  enable_private_dns_a_record              = true
  private_dns_a_record_name                = "a"
  private_dns_a_record_resource_group_name = module.base_resource_group.resource_group_name
  private_dns_a_record_ttl                 = 300
  private_dns_a_record_records             = ["10.0.180.17"]

  // private dns zone virtual network link
  enable_private_dns_zone_virtual_network_link              = true
  private_dns_zone_virtual_network_link_name                = ""
  private_dns_zone_virtual_network_link_resource_group_name = module.base_resource_group.resource_group_name
  private_dns_zone_virtual_network_link_virtual_network_id  = "azurerm_virtual_network_id"

  tags = tomap({
    "Environment"   = "test",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

  depends_on = [
    module.base_resource_group
  ]
}