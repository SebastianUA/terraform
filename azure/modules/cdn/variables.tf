#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "this"
}

variable "environment" {
  description = "Environment for service"
  default     = "test"
}

variable "tags" {
  description = "Add additional tags"
  default     = {}
}

#-----------------------------------------------------------
# Azure cdn profile
#-----------------------------------------------------------
variable "enable_cdn_profile" {
  description = "Enable cdn profile usage"
  default     = false
}

variable "cdn_profile_name" {
  description = "Specifies the name of the CDN Profile. Changing this forces a new resource to be created."
  default     = ""
}

variable "cdn_profile_location" {
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  default     = null
}

variable "cdn_profile_resource_group_name" {
  description = "(Required) The name of the resource group in which to create the CDN Profile."
  default     = null
}

variable "cdn_profile_sku" {
  description = "(Required) The pricing related information of current CDN profile. Accepted values are Standard_Akamai, Standard_ChinaCdn, Standard_Microsoft, Standard_Verizon or Premium_Verizon"
  default     = null
}

variable "cdn_profile_timeouts" {
  description = "Set timeouts for cdn profile"
  default     = {}
}

#-----------------------------------------------------------
# Azure cdn endpoint
#-----------------------------------------------------------
variable "enable_cdn_endpoint" {
  description = "Enable cdn endpoint usage"
  default     = false
}

variable "cdn_endpoint_name" {
  description = "Specifies the name of the CDN Endpoint. Changing this forces a new resource to be created."
  default     = ""
}

variable "cdn_endpoint_profile_name" {
  description = "The CDN Profile to which to attach the CDN Endpoint."
  default     = ""
}

variable "cdn_endpoint_location" {
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  default     = null
}

variable "cdn_endpoint_resource_group_name" {
  description = "(Required) The name of the resource group in which to create the CDN Endpoint."
  default     = null
}

variable "cdn_endpoint_origin" {
  description = "(Required) The set of origins of the CDN endpoint. When multiple origins exist, the first origin will be used as primary and rest will be used as failover options."
  default     = {}
}

variable "cdn_endpoint_is_http_allowed" {
  description = "(Optional) Defaults to true."
  default     = null
}

variable "cdn_endpoint_is_https_allowed" {
  description = "(Optional) Defaults to true."
  default     = null
}

variable "cdn_endpoint_content_types_to_compress" {
  description = "(Optional) An array of strings that indicates a content types on which compression will be applied. The value for the elements should be MIME types."
  default     = null
}

variable "cdn_endpoint_is_compression_enabled" {
  description = "(Optional) Indicates whether compression is to be enabled."
  default     = null
}

variable "cdn_endpoint_querystring_caching_behaviour" {
  description = "(Optional) Sets query string caching behavior. Allowed values are IgnoreQueryString, BypassCaching and UseQueryString. NotSet value can be used for Premium Verizon CDN profile. Defaults to IgnoreQueryString"
  default     = null
}

variable "cdn_endpoint_optimization_type" {
  description = "(Optional) What types of optimization should this CDN Endpoint optimize for? Possible values include DynamicSiteAcceleration, GeneralMediaStreaming, GeneralWebDelivery, LargeFileDownload and VideoOnDemandMediaStreaming."
  default     = null
}

variable "cdn_endpoint_origin_host_header" {
  description = "(Optional) The host header CDN provider will send along with content requests to origins."
  default     = null
}

variable "cdn_endpoint_origin_path" {
  description = "(Optional) The path used at for origin requests."
  default     = null
}

variable "cdn_endpoint_probe_path" {
  description = "(Optional) the path to a file hosted on the origin which helps accelerate delivery of the dynamic content and calculate the most optimal routes for the CDN. This is relative to the origin_path"
  default     = null
}

variable "cdn_endpoint_timeouts" {
  description = "Set timeouts for cdn endpoint"
  default     = {}
}

variable "cdn_endpoint_geo_filter" {
  description = "(Optional) A set of Geo Filters for this CDN Endpoint. Each geo_filter"
  default     = []
}

variable "cdn_endpoint_global_delivery_rule" {
  description = "(Optional) Actions that are valid for all resources regardless of any conditions"
  default     = []
}

variable "cdn_endpoint_delivery_rule" {
  description = "(Optional) Rules for the rules engine. An endpoint can contain up until 4 of those rules that consist of conditions and actions"
  default     = []
}

#-----------------------------------------------------------
# Azure cdn endpoint custom domain
#-----------------------------------------------------------
variable "enable_cdn_endpoint_custom_domain" {
  description = "Enable cdn endpoint custom domain usage"
  default     = false
}

variable "cdn_endpoint_custom_domain_name" {
  description = "The name which should be used for this CDN Endpoint Custom Domain. Changing this forces a new CDN Endpoint Custom Domain to be created."
  default     = ""
}

variable "cdn_endpoint_custom_domain_cdn_endpoint_id" {
  description = "The ID of the CDN Endpoint. Changing this forces a new CDN Endpoint Custom Domain to be created."
  default     = ""
}

variable "cdn_endpoint_custom_domain_host_name" {
  description = "(Required) The host name of the custom domain. Changing this forces a new CDN Endpoint Custom Domain to be created."
  default     = null
}

variable "cdn_endpoint_custom_domain_cdn_managed_https" {
  description = "(Optional) - A cdn_managed_https"
  default     = {}
}

variable "cdn_endpoint_custom_domain_user_managed_https" {
  description = "(Optional) - A user_managed_https"
  default     = {}
}

variable "cdn_endpoint_custom_domain_timeouts" {
  description = "Set timeouts for cdn endpoint custom domain"
  default     = {}
}
