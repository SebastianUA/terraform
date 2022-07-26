# Work with CDN via terraform

A terraform module for making CDN.


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
```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = this`)
- `environment` - Environment for service (`default = test`)
- `tags` - Add additional tags (`default = {}`)
- `enable_cdn_profile` - Enable cdn profile usage (`default = False`)
- `cdn_profile_name` - Specifies the name of the CDN Profile. Changing this forces a new resource to be created. (`default = ""`)
- `cdn_profile_location` - (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. (`default = null`)
- `cdn_profile_resource_group_name` - (Required) The name of the resource group in which to create the CDN Profile. (`default = null`)
- `cdn_profile_sku` - (Required) The pricing related information of current CDN profile. Accepted values are Standard_Akamai, Standard_ChinaCdn, Standard_Microsoft, Standard_Verizon or Premium_Verizon (`default = null`)
- `cdn_profile_timeouts` - Set timeouts for cdn profile (`default = {}`)
- `enable_cdn_endpoint` - Enable cdn endpoint usage (`default = False`)
- `cdn_endpoint_name` - Specifies the name of the CDN Endpoint. Changing this forces a new resource to be created. (`default = ""`)
- `cdn_endpoint_profile_name` - The CDN Profile to which to attach the CDN Endpoint. (`default = ""`)
- `cdn_endpoint_location` - (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. (`default = null`)
- `cdn_endpoint_resource_group_name` - (Required) The name of the resource group in which to create the CDN Endpoint. (`default = null`)
- `cdn_endpoint_origin` - (Required) The set of origins of the CDN endpoint. When multiple origins exist, the first origin will be used as primary and rest will be used as failover options. (`default = {}`)
- `cdn_endpoint_is_http_allowed` - (Optional) Defaults to true. (`default = null`)
- `cdn_endpoint_is_https_allowed` - (Optional) Defaults to true. (`default = null`)
- `cdn_endpoint_content_types_to_compress` - (Optional) An array of strings that indicates a content types on which compression will be applied. The value for the elements should be MIME types. (`default = null`)
- `cdn_endpoint_is_compression_enabled` - (Optional) Indicates whether compression is to be enabled. (`default = null`)
- `cdn_endpoint_querystring_caching_behaviour` - (Optional) Sets query string caching behavior. Allowed values are IgnoreQueryString, BypassCaching and UseQueryString. NotSet value can be used for Premium Verizon CDN profile. Defaults to IgnoreQueryString (`default = null`)
- `cdn_endpoint_optimization_type` - (Optional) What types of optimization should this CDN Endpoint optimize for? Possible values include DynamicSiteAcceleration, GeneralMediaStreaming, GeneralWebDelivery, LargeFileDownload and VideoOnDemandMediaStreaming. (`default = null`)
- `cdn_endpoint_origin_host_header` - (Optional) The host header CDN provider will send along with content requests to origins. (`default = null`)
- `cdn_endpoint_origin_path` - (Optional) The path used at for origin requests. (`default = null`)
- `cdn_endpoint_probe_path` - (Optional) the path to a file hosted on the origin which helps accelerate delivery of the dynamic content and calculate the most optimal routes for the CDN. This is relative to the origin_path (`default = null`)
- `cdn_endpoint_timeouts` - Set timeouts for cdn endpoint (`default = {}`)
- `cdn_endpoint_geo_filter` - (Optional) A set of Geo Filters for this CDN Endpoint. Each geo_filter (`default = []`)
- `cdn_endpoint_global_delivery_rule` - (Optional) Actions that are valid for all resources regardless of any conditions (`default = []`)
- `cdn_endpoint_delivery_rule` - (Optional) Rules for the rules engine. An endpoint can contain up until 4 of those rules that consist of conditions and actions (`default = []`)
- `enable_cdn_endpoint_custom_domain` - Enable cdn endpoint custom domain usage (`default = False`)
- `cdn_endpoint_custom_domain_name` - The name which should be used for this CDN Endpoint Custom Domain. Changing this forces a new CDN Endpoint Custom Domain to be created. (`default = ""`)
- `cdn_endpoint_custom_domain_cdn_endpoint_id` - The ID of the CDN Endpoint. Changing this forces a new CDN Endpoint Custom Domain to be created. (`default = ""`)
- `cdn_endpoint_custom_domain_host_name` - (Required) The host name of the custom domain. Changing this forces a new CDN Endpoint Custom Domain to be created. (`default = null`)
- `cdn_endpoint_custom_domain_cdn_managed_https` - (Optional) - A cdn_managed_https (`default = {}`)
- `cdn_endpoint_custom_domain_user_managed_https` - (Optional) - A user_managed_https (`default = {}`)
- `cdn_endpoint_custom_domain_timeouts` - Set timeouts for cdn endpoint custom domain (`default = {}`)

## Module Output Variables
----------------------
- `cdn_profile_id` - The ID of the CDN Profile.
- `cdn_profile_name` - The name of the CDN Profile.
- `cdn_endpoint_id` - The ID of the CDN Endpoint.
- `cdn_endpoint_name` - The name of the CDN Endpoint.
- `cdn_endpoint_fqdn` - The Fully Qualified Domain Name of the CDN Endpoint.
- `cdn_endpoint_custom_domain_id` - The ID of the CDN Endpoint Custom Domain.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
