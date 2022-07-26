# Work with DNS via terraform

A terraform module for making DNS.


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
```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = this`)
- `environment` - Environment for service (`default = test`)
- `tags` - Add additional tags (`default = {}`)
- `enable_dns_zone` - Enable dns zone usage (`default = False`)
- `dns_zone_name` - The name of the DNS Zone. Must be a valid domain name. (`default = ""`)
- `dns_zone_resource_group_name` - (Required) Specifies the resource group where the resource exists. Changing this forces a new resource to be created. (`default = null`)
- `dns_zone_soa_record` - (Optional) An soa_record block as defined below. Changing this forces a new resource to be created. (`default = {}`)
- `dns_zone_timeouts` - Set timeouts for dns zone (`default = {}`)
- `enable_dns_txt_record` - Enable dns txt record usage (`default = False`)
- `dns_txt_record_name` - The name of the DNS TXT Record. (`default = ""`)
- `dns_txt_record_zone_name` - Specifies the DNS Zone where the DNS Zone (parent resource) exists. Changing this forces a new resource to be created. (`default = ""`)
- `dns_txt_record_resource_group_name` - (Required) Specifies the resource group where the resource exists. Changing this forces a new resource to be created. (`default = null`)
- `dns_txt_record_ttl` - (Required) The Time To Live (TTL) of the DNS record in seconds. (`default = null`)
- `dns_txt_record_record` - (Required) A list of values that make up the txt record. (`default = []`)
- `dns_txt_record_timeouts` - Set timeouts for dns txt record (`default = {}`)
- `enable_dns_srv_record` - Enable dns txt record usage (`default = False`)
- `dns_srv_record_name` - The name of the DNS SRV Record. (`default = ""`)
- `dns_srv_record_zone_name` - Specifies the DNS Zone where the DNS Zone (parent resource) exists. Changing this forces a new resource to be created. (`default = ""`)
- `dns_srv_record_resource_group_name` - (Required) Specifies the resource group where the resource exists. Changing this forces a new resource to be created. (`default = null`)
- `dns_srv_record_ttl` - (Required) The Time To Live (TTL) of the DNS record in seconds. (`default = null`)
- `dns_srv_record_record` - (Required) A list of values that make up the srv record. (`default = []`)
- `dns_srv_record_timeouts` - Set timeouts for dns srv record (`default = {}`)
- `enable_dns_ptr_record` - Enable dns ptr record usage (`default = False`)
- `dns_ptr_record_name` - The name of the DNS PTR Record. (`default = ""`)
- `dns_ptr_record_zone_name` - Specifies the DNS Zone where the DNS Zone (parent resource) exists. Changing this forces a new resource to be created. (`default = ""`)
- `dns_ptr_record_resource_group_name` - (Required) Specifies the resource group where the resource exists. Changing this forces a new resource to be created. (`default = null`)
- `dns_ptr_record_ttl` - (Required) The Time To Live (TTL) of the DNS record in seconds. (`default = null`)
- `dns_ptr_record_records` - (Required) List of Fully Qualified Domain Names. (`default = []`)
- `dns_ptr_record_timeouts` - Set timeouts for dns ptr record (`default = {}`)
- `enable_dns_ns_record` - Enable dns ns record usage (`default = False`)
- `dns_ns_record_name` - The name of the DNS NS Record. (`default = ""`)
- `dns_ns_record_zone_name` - Specifies the DNS Zone where the DNS Zone (parent resource) exists. Changing this forces a new resource to be created. (`default = ""`)
- `dns_ns_record_resource_group_name` - (Required) Specifies the resource group where the resource exists. Changing this forces a new resource to be created. (`default = null`)
- `dns_ns_record_ttl` - (Required) The Time To Live (TTL) of the DNS record in seconds. (`default = null`)
- `dns_ns_record_records` - (Required) List of Fully Qualified Domain Names. (`default = []`)
- `dns_ns_record_timeouts` - Set timeouts for dns NS record (`default = {}`)
- `enable_dns_mx_record` - Enable dns MX record usage (`default = False`)
- `dns_mx_record_name` - The name of the DNS NS Record. (`default = ""`)
- `dns_mx_record_zone_name` - Specifies the DNS Zone where the DNS Zone (parent resource) exists. Changing this forces a new resource to be created. (`default = ""`)
- `dns_mx_record_resource_group_name` - (Required) Specifies the resource group where the resource exists. Changing this forces a new resource to be created. (`default = null`)
- `dns_mx_record_ttl` - (Required) The Time To Live (TTL) of the DNS record in seconds. (`default = null`)
- `dns_mx_record_records` - (Required) List of Fully Qualified Domain Names. (`default = []`)
- `dns_mx_record_timeouts` - Set timeouts for dns MX record (`default = {}`)
- `enable_dns_cname_record` - Enable dns cname record usage (`default = False`)
- `dns_cname_record_name` - The name of the DNS cname Record. (`default = ""`)
- `dns_cname_record_zone_name` - Specifies the DNS Zone where the DNS Zone (parent resource) exists. Changing this forces a new resource to be created. (`default = ""`)
- `dns_cname_record_resource_group_name` - (Required) Specifies the resource group where the resource exists. Changing this forces a new resource to be created. (`default = null`)
- `dns_cname_record_ttl` - (Required) The Time To Live (TTL) of the DNS record in seconds. (`default = null`)
- `dns_cname_record_record` - (Required) The target of the CNAME. (`default = ""`)
- `dns_cname_record_target_resource_id` - (Optional) The Azure resource id of the target object. Conflicts with records (`default = null`)
- `dns_cname_record_timeouts` - Set timeouts for dns MX record (`default = {}`)
- `enable_dns_caa_record` - Enable dns CAA record usage (`default = False`)
- `dns_caa_record_name` - The name of the DNS CAA Record. (`default = ""`)
- `dns_caa_record_zone_name` - Specifies the DNS Zone where the DNS Zone (parent resource) exists. Changing this forces a new resource to be created. (`default = ""`)
- `dns_caa_record_resource_group_name` - (Required) Specifies the resource group where the resource exists. Changing this forces a new resource to be created. (`default = null`)
- `dns_caa_record_ttl` - (Required) The Time To Live (TTL) of the DNS record in seconds. (`default = null`)
- `dns_caa_record_record` - (Required) A list of values that make up the CAA record (`default = []`)
- `dns_caa_record_timeouts` - Set timeouts for dns CAA record (`default = {}`)
- `enable_dns_aaaa_record` - Enable dns CAA record usage (`default = False`)
- `dns_aaaa_record_name` - The name of the DNS CAA Record. (`default = ""`)
- `dns_aaaa_record_zone_name` - Specifies the DNS Zone where the DNS Zone (parent resource) exists. Changing this forces a new resource to be created. (`default = ""`)
- `dns_aaaa_record_resource_group_name` - (Required) Specifies the resource group where the resource exists. Changing this forces a new resource to be created. (`default = null`)
- `dns_aaaa_record_ttl` - (Required) The Time To Live (TTL) of the DNS record in seconds. (`default = null`)
- `dns_aaaa_record_records` - (Optional) List of IPv6 Addresses. Conflicts with target_resource_id (`default = []`)
- `dns_aaaa_record_timeouts` - Set timeouts for dns CAA record (`default = {}`)
- `enable_dns_a_record` - Enable dns A record usage (`default = False`)
- `dns_a_record_name` - The name of the DNS A Record. (`default = ""`)
- `dns_a_record_zone_name` - Specifies the DNS Zone where the DNS Zone (parent resource) exists. Changing this forces a new resource to be created. (`default = ""`)
- `dns_a_record_resource_group_name` - (Required) Specifies the resource group where the resource exists. Changing this forces a new resource to be created. (`default = null`)
- `dns_a_record_ttl` - (Required) The Time To Live (TTL) of the DNS record in seconds. (`default = null`)
- `dns_a_record_records` - (Optional) List of IPv4 Addresses. Conflicts with target_resource_id. (`default = []`)
- `dns_a_record_target_resource_id` - (Optional) The Azure resource id of the target object. Conflicts with records (`default = null`)
- `dns_a_record_timeouts` - Set timeouts for dns A record (`default = {}`)

## Module Output Variables
----------------------
- `dns_zone_id` - The DNS Zone ID.
- `dns_zone_max_number_of_record_sets` - (Optional) Maximum number of Records in the zone. Defaults to 1000.
- `dns_zone_number_of_record_sets` - (Optional) The number of records already in the zone.
- `dns_zone_name_servers` - (Optional) A list of values that make up the NS record for the zone.
- `dns_txt_record_id` - The DNS TXT Record ID.
- `dns_txt_record_fqdn` - The FQDN of the DNS TXT Record.
- `dns_srv_record_id` - The DNS SRV Record ID.
- `dns_srv_record_fqdn` - The FQDN of the DNS SRV Record.
- `dns_ptr_record_id` - The DNS PTR Record ID.
- `dns_ptr_record_fqdn` - The FQDN of the DNS PTR Record.
- `dns_ns_record_id` - The DNS NS Record ID.
- `dns_ns_record_fqdn` - The FQDN of the DNS NS Record.
- `dns_mx_record_id` - The DNS MX Record ID.
- `dns_mx_record_fqdn` - The FQDN of the DNS MX Record.
- `dns_cname_record_id` - The DNS CName Record ID.
- `dns_cname_record_fqdn` - The FQDN of the DNS CName Record.
- `dns_caa_record_id` - The DNS CAA Record ID.
- `dns_caa_record_fqdn` - The FQDN of the DNS CAA Record.
- `dns_aaaa_record_id` - The DNS AAAA Record ID.
- `dns_aaaa_record_fqdn` - The FQDN of the DNS AAAA Record.
- `dns_a_record_id` - The DNS A Record ID.
- `dns_a_record_fqdn` - The FQDN of the DNS A Record.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
