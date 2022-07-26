# Work with PRIVATE_DNS via terraform

A terraform module for making PRIVATE_DNS.


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
```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = this`)
- `environment` - Environment for service (`default = test`)
- `tags` - Add additional tags (`default = {}`)
- `enable_private_dns_zone` - Enable private dns zone usage (`default = False`)
- `private_dns_zone_name` - The name of the private DNS Zone. Must be a valid domain name. (`default = ""`)
- `private_dns_zone_resource_group_name` - (Required) Specifies the resource group where the resource exists. Changing this forces a new resource to be created. (`default = null`)
- `private_dns_zone_soa_record` - (Optional) An soa_record block as defined below. Changing this forces a new resource to be created. (`default = {}`)
- `private_dns_zone_timeouts` - Set timeouts for private dns zone (`default = {}`)
- `enable_private_dns_txt_record` - Enable dns txt record usage (`default = False`)
- `private_dns_txt_record_name` - The name of the DNS TXT Record. (`default = ""`)
- `private_dns_txt_record_zone_name` - Specifies the DNS Zone where the DNS Zone (parent resource) exists. Changing this forces a new resource to be created. (`default = ""`)
- `private_dns_txt_record_resource_group_name` - (Required) Specifies the resource group where the resource exists. Changing this forces a new resource to be created. (`default = null`)
- `private_dns_txt_record_ttl` - (Required) The Time To Live (TTL) of the DNS record in seconds. (`default = null`)
- `private_dns_txt_record_record` - (Required) A list of values that make up the txt record. (`default = []`)
- `private_dns_txt_record_timeouts` - Set timeouts for dns txt record (`default = {}`)
- `enable_private_dns_srv_record` - Enable private dns txt record usage (`default = False`)
- `private_dns_srv_record_name` - The name of the DNS SRV Record. (`default = ""`)
- `private_dns_srv_record_zone_name` - Specifies the DNS Zone where the DNS Zone (parent resource) exists. Changing this forces a new resource to be created. (`default = ""`)
- `private_dns_srv_record_resource_group_name` - (Required) Specifies the resource group where the resource exists. Changing this forces a new resource to be created. (`default = null`)
- `private_dns_srv_record_ttl` - (Required) The Time To Live (TTL) of the DNS record in seconds. (`default = null`)
- `private_dns_srv_record_record` - (Required) A list of values that make up the srv record. (`default = []`)
- `private_dns_srv_record_timeouts` - Set timeouts for private dns srv record (`default = {}`)
- `enable_private_dns_ptr_record` - Enable private dns ptr record usage (`default = False`)
- `private_dns_ptr_record_name` - The name of the DNS PTR Record. (`default = ""`)
- `private_dns_ptr_record_zone_name` - Specifies the DNS Zone where the DNS Zone (parent resource) exists. Changing this forces a new resource to be created. (`default = ""`)
- `private_dns_ptr_record_resource_group_name` - (Required) Specifies the resource group where the resource exists. Changing this forces a new resource to be created. (`default = null`)
- `private_dns_ptr_record_ttl` - (Required) The Time To Live (TTL) of the DNS record in seconds. (`default = null`)
- `private_dns_ptr_record_records` - (Required) List of Fully Qualified Domain Names. (`default = []`)
- `private_dns_ptr_record_timeouts` - Set timeouts for private dns ptr record (`default = {}`)
- `enable_private_dns_mx_record` - Enable private dns MX record usage (`default = False`)
- `private_dns_mx_record_name` - The name of the DNS NS Record. (`default = ""`)
- `private_dns_mx_record_zone_name` - Specifies the DNS Zone where the DNS Zone (parent resource) exists. Changing this forces a new resource to be created. (`default = ""`)
- `private_dns_mx_record_resource_group_name` - (Required) Specifies the resource group where the resource exists. Changing this forces a new resource to be created. (`default = null`)
- `private_dns_mx_record_ttl` - (Required) The Time To Live (TTL) of the DNS record in seconds. (`default = null`)
- `private_dns_mx_record_records` - (Required) List of Fully Qualified Domain Names. (`default = []`)
- `private_dns_mx_record_timeouts` - Set timeouts for private dns MX record (`default = {}`)
- `enable_private_dns_cname_record` - Enable private dns cname record usage (`default = False`)
- `private_dns_cname_record_name` - The name of the DNS cname Record. (`default = ""`)
- `private_dns_cname_record_zone_name` - Specifies the DNS Zone where the DNS Zone (parent resource) exists. Changing this forces a new resource to be created. (`default = ""`)
- `private_dns_cname_record_resource_group_name` - (Required) Specifies the resource group where the resource exists. Changing this forces a new resource to be created. (`default = null`)
- `private_dns_cname_record_ttl` - (Required) The Time To Live (TTL) of the DNS record in seconds. (`default = null`)
- `private_dns_cname_record_record` - (Required) The target of the CNAME. (`default = ""`)
- `private_dns_cname_record_timeouts` - Set timeouts for private dns MX record (`default = {}`)
- `enable_private_dns_aaaa_record` - Enable private dns CAA record usage (`default = False`)
- `private_dns_aaaa_record_name` - The name of the DNS CAA Record. (`default = ""`)
- `private_dns_aaaa_record_zone_name` - Specifies the DNS Zone where the DNS Zone (parent resource) exists. Changing this forces a new resource to be created. (`default = ""`)
- `private_dns_aaaa_record_resource_group_name` - (Required) Specifies the resource group where the resource exists. Changing this forces a new resource to be created. (`default = null`)
- `private_dns_aaaa_record_ttl` - (Required) The Time To Live (TTL) of the DNS record in seconds. (`default = null`)
- `private_dns_aaaa_record_records` - (Optional) List of IPv6 Addresses. Conflicts with target_resource_id (`default = []`)
- `private_dns_aaaa_record_timeouts` - Set timeouts for private dns CAA record (`default = {}`)
- `enable_private_dns_a_record` - Enable private dns A record usage (`default = False`)
- `private_dns_a_record_name` - The name of the DNS A Record. (`default = ""`)
- `private_dns_a_record_zone_name` - Specifies the DNS Zone where the DNS Zone (parent resource) exists. Changing this forces a new resource to be created. (`default = ""`)
- `private_dns_a_record_resource_group_name` - (Required) Specifies the resource group where the resource exists. Changing this forces a new resource to be created. (`default = null`)
- `private_dns_a_record_ttl` - (Required) The Time To Live (TTL) of the DNS record in seconds. (`default = null`)
- `private_dns_a_record_records` - (Optional) List of IPv4 Addresses. Conflicts with target_resource_id. (`default = []`)
- `private_dns_a_record_target_resource_id` - (Optional) The Azure resource id of the target object. Conflicts with records (`default = null`)
- `private_dns_a_record_timeouts` - Set timeouts for private dns A record (`default = {}`)
- `enable_private_dns_zone_virtual_network_link` - Enable private dns zone virtual network link usage (`default = False`)
- `private_dns_zone_virtual_network_link_name` - The name of the Private DNS Zone Virtual Network Link. Changing this forces a new resource to be created. (`default = ""`)
- `private_dns_zone_virtual_network_link_resource_group_name` - (Required) Specifies the resource group where the Private DNS Zone exists. Changing this forces a new resource to be created. (`default = null`)
- `private_dns_zone_virtual_network_link_private_dns_zone_name` - (Required) The name of the Private DNS zone (without a terminating dot). Changing this forces a new resource to be created. (`default = ""`)
- `private_dns_zone_virtual_network_link_virtual_network_id` - (Required) The ID of the Virtual Network that should be linked to the DNS Zone. Changing this forces a new resource to be created. (`default = null`)
- `private_dns_zone_virtual_network_link_registration_enabled` - (Optional) Is auto-registration of virtual machine records in the virtual network in the Private DNS zone enabled? Defaults to false (`default = null`)
- `private_dns_zone_virtual_network_link_timeouts` - Set timeouts for private dns zone virtual network link (`default = {}`)

## Module Output Variables
----------------------
- `private_dns_zone_id` - The Private DNS Zone ID.
- `private_dns_zone_soa_record` - A soa_record block.
- `private_dns_zone_number_of_record_sets` - The current number of record sets in this Private DNS zone.
- `private_dns_zone_max_number_of_record_sets` - The maximum number of record sets that can be created in this Private DNS zone.
- `private_dns_zone_max_number_of_virtual_network_links` - The maximum number of virtual networks that can be linked to this Private DNS zone.
- `private_dns_zone_max_number_of_virtual_network_links_with_registration` - The maximum number of virtual networks that can be linked to this Private DNS zone with registration enabled.
- `private_dns_txt_record_id` - The DNS TXT Record ID.
- `private_dns_txt_record_fqdn` - The FQDN of the DNS TXT Record.
- `private_dns_srv_record_id` - The DNS SRV Record ID.
- `private_dns_srv_record_fqdn` - The FQDN of the DNS SRV Record.
- `private_dns_ptr_record_id` - The DNS PTR Record ID.
- `private_dns_ptr_record_fqdn` - The FQDN of the DNS PTR Record.
- `private_dns_mx_record_id` - The DNS MX Record ID.
- `private_dns_mx_record_fqdn` - The FQDN of the DNS MX Record.
- `private_dns_cname_record_id` - The DNS CName Record ID.
- `private_dns_cname_record_fqdn` - The FQDN of the DNS CName Record.
- `private_dns_aaaa_record_id` - The DNS AAAA Record ID.
- `private_dns_aaaa_record_fqdn` - The FQDN of the DNS AAAA Record.
- `private_dns_a_record_id` - The DNS A Record ID.
- `private_dns_a_record_fqdn` - The FQDN of the DNS A Record.
- `private_dns_zone_virtual_network_link_id` - The ID of the Private DNS Zone Virtual Network Link.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
