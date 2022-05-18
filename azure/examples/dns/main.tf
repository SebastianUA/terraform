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

module "dns" {
  source = "../../modules/dns"

  // dns zone
  enable_dns_zone              = true
  dns_zone_name                = "linux-notes.org"
  dns_zone_resource_group_name = module.base_resource_group.resource_group_name

  // dns txt record
  enable_dns_txt_record              = true
  dns_txt_record_name                = "txt"
  dns_txt_record_resource_group_name = module.base_resource_group.resource_group_name
  dns_txt_record_ttl                 = 300
  dns_txt_record_record = [
    {
      value = "more site information here"
    },
    {
      value = "google-site-authenticator"
    }
  ]

  // dns srv record
  enable_dns_srv_record              = true
  dns_srv_record_name                = "srv"
  dns_srv_record_resource_group_name = module.base_resource_group.resource_group_name
  dns_srv_record_ttl                 = 300
  dns_srv_record_record = [
    {
      priority = 1
      weight   = 5
      port     = 8080
      target   = "target1.contoso.com"
    }
  ]

  // dns ptr record
  enable_dns_ptr_record              = true
  dns_ptr_record_name                = "ptr"
  dns_ptr_record_resource_group_name = module.base_resource_group.resource_group_name
  dns_ptr_record_ttl                 = 300
  dns_ptr_record_records             = ["yourdomain.com"]

  // dns ns record
  enable_dns_ns_record              = true
  dns_ns_record_name                = "ns"
  dns_ns_record_resource_group_name = module.base_resource_group.resource_group_name
  dns_ns_record_ttl                 = 300
  dns_ns_record_records             = ["ns1.contoso.com", "ns2.contoso.com"]

  // dns mx record
  enable_dns_mx_record              = true
  dns_mx_record_name                = "mx"
  dns_mx_record_resource_group_name = module.base_resource_group.resource_group_name
  dns_mx_record_ttl                 = 300
  dns_mx_record_records = [
    {
      preference = 10
      exchange   = "mail1.contoso.com"
    },
    {
      preference = 20
      exchange   = "mail2.contoso.com"
    }
  ]

  // dns cname record
  enable_dns_cname_record              = true
  dns_cname_record_name                = "cname"
  dns_cname_record_resource_group_name = module.base_resource_group.resource_group_name
  dns_cname_record_ttl                 = 300
  dns_cname_record_record              = "contoso.com"

  // dns caa record
  enable_dns_caa_record              = true
  dns_caa_record_name                = "caa"
  dns_caa_record_resource_group_name = module.base_resource_group.resource_group_name
  dns_caa_record_ttl                 = 300
  dns_caa_record_record = [
    {
      flags = 0
      tag   = "issue"
      value = "example.com"
    },
    {
      flags = 0
      tag   = "issue"
      value = "example.net"
    },
    {
      flags = 0
      tag   = "issuewild"
      value = ";"
    },
    {
      flags = 0
      tag   = "iodef"
      value = "mailto:terraform@nonexisting.tld"
    }
  ]

  // dns aaaa record
  enable_dns_aaaa_record              = true
  dns_aaaa_record_name                = "aaaa"
  dns_aaaa_record_resource_group_name = module.base_resource_group.resource_group_name
  dns_aaaa_record_ttl                 = 300
  dns_aaaa_record_records             = ["2001:db8::1:0:0:1"]

  // dns a record
  enable_dns_a_record              = true
  dns_a_record_name                = "a"
  dns_a_record_resource_group_name = module.base_resource_group.resource_group_name
  dns_a_record_ttl                 = 300
  dns_a_record_records             = ["10.0.180.17"]

  tags = tomap({
    "Environment"   = "test",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

  depends_on = [
    module.base_resource_group
  ]
}