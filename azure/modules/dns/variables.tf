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
# Azure dns zone
#-----------------------------------------------------------
variable "enable_dns_zone" {
  description = "Enable dns zone usage"
  default     = false
}

variable "dns_zone_name" {
  description = "The name of the DNS Zone. Must be a valid domain name."
  default     = ""
}

variable "dns_zone_resource_group_name" {
  description = "(Required) Specifies the resource group where the resource exists. Changing this forces a new resource to be created."
  default     = null
}

variable "dns_zone_soa_record" {
  description = "(Optional) An soa_record block as defined below. Changing this forces a new resource to be created."
  default     = {}
}

variable "dns_zone_timeouts" {
  description = "Set timeouts for dns zone"
  default     = {}
}

#-----------------------------------------------------------
# Azure dns txt record
#-----------------------------------------------------------
variable "enable_dns_txt_record" {
  description = "Enable dns txt record usage"
  default     = false
}

variable "dns_txt_record_name" {
  description = "The name of the DNS TXT Record."
  default     = ""
}

variable "dns_txt_record_zone_name" {
  description = "Specifies the DNS Zone where the DNS Zone (parent resource) exists. Changing this forces a new resource to be created."
  default     = ""
}

variable "dns_txt_record_resource_group_name" {
  description = "(Required) Specifies the resource group where the resource exists. Changing this forces a new resource to be created."
  default     = null
}

variable "dns_txt_record_ttl" {
  description = "(Required) The Time To Live (TTL) of the DNS record in seconds."
  default     = null
}

variable "dns_txt_record_record" {
  description = "(Required) A list of values that make up the txt record."
  default     = []
}

variable "dns_txt_record_timeouts" {
  description = "Set timeouts for dns txt record"
  default     = {}
}

#-----------------------------------------------------------
# Azure dns srv record
#-----------------------------------------------------------
variable "enable_dns_srv_record" {
  description = "Enable dns txt record usage"
  default     = false
}

variable "dns_srv_record_name" {
  description = "The name of the DNS SRV Record."
  default     = ""
}

variable "dns_srv_record_zone_name" {
  description = "Specifies the DNS Zone where the DNS Zone (parent resource) exists. Changing this forces a new resource to be created."
  default     = ""
}

variable "dns_srv_record_resource_group_name" {
  description = "(Required) Specifies the resource group where the resource exists. Changing this forces a new resource to be created."
  default     = null
}

variable "dns_srv_record_ttl" {
  description = "(Required) The Time To Live (TTL) of the DNS record in seconds."
  default     = null
}

variable "dns_srv_record_record" {
  description = "(Required) A list of values that make up the srv record."
  default     = []
}

variable "dns_srv_record_timeouts" {
  description = "Set timeouts for dns srv record"
  default     = {}
}

#-----------------------------------------------------------
# Azure dns ptr record
#-----------------------------------------------------------
variable "enable_dns_ptr_record" {
  description = "Enable dns ptr record usage"
  default     = false
}

variable "dns_ptr_record_name" {
  description = "The name of the DNS PTR Record."
  default     = ""
}

variable "dns_ptr_record_zone_name" {
  description = "Specifies the DNS Zone where the DNS Zone (parent resource) exists. Changing this forces a new resource to be created."
  default     = ""
}

variable "dns_ptr_record_resource_group_name" {
  description = "(Required) Specifies the resource group where the resource exists. Changing this forces a new resource to be created."
  default     = null
}

variable "dns_ptr_record_ttl" {
  description = "(Required) The Time To Live (TTL) of the DNS record in seconds."
  default     = null
}

variable "dns_ptr_record_records" {
  description = "(Required) List of Fully Qualified Domain Names."
  default     = []
}

variable "dns_ptr_record_timeouts" {
  description = "Set timeouts for dns ptr record"
  default     = {}
}

#-----------------------------------------------------------
# Azure dns ns record
#-----------------------------------------------------------
variable "enable_dns_ns_record" {
  description = "Enable dns ns record usage"
  default     = false
}

variable "dns_ns_record_name" {
  description = "The name of the DNS NS Record."
  default     = ""
}

variable "dns_ns_record_zone_name" {
  description = "Specifies the DNS Zone where the DNS Zone (parent resource) exists. Changing this forces a new resource to be created."
  default     = ""
}

variable "dns_ns_record_resource_group_name" {
  description = "(Required) Specifies the resource group where the resource exists. Changing this forces a new resource to be created."
  default     = null
}

variable "dns_ns_record_ttl" {
  description = "(Required) The Time To Live (TTL) of the DNS record in seconds."
  default     = null
}

variable "dns_ns_record_records" {
  description = "(Required) List of Fully Qualified Domain Names."
  default     = []
}

variable "dns_ns_record_timeouts" {
  description = "Set timeouts for dns NS record"
  default     = {}
}

#-----------------------------------------------------------
# Azure dns mx record
#-----------------------------------------------------------
variable "enable_dns_mx_record" {
  description = "Enable dns MX record usage"
  default     = false
}

variable "dns_mx_record_name" {
  description = "The name of the DNS NS Record."
  default     = ""
}

variable "dns_mx_record_zone_name" {
  description = "Specifies the DNS Zone where the DNS Zone (parent resource) exists. Changing this forces a new resource to be created."
  default     = ""
}

variable "dns_mx_record_resource_group_name" {
  description = "(Required) Specifies the resource group where the resource exists. Changing this forces a new resource to be created."
  default     = null
}

variable "dns_mx_record_ttl" {
  description = "(Required) The Time To Live (TTL) of the DNS record in seconds."
  default     = null
}

variable "dns_mx_record_records" {
  description = "(Required) List of Fully Qualified Domain Names."
  default     = []
}

variable "dns_mx_record_timeouts" {
  description = "Set timeouts for dns MX record"
  default     = {}
}

#-----------------------------------------------------------
# Azure dns cname record
#-----------------------------------------------------------
variable "enable_dns_cname_record" {
  description = "Enable dns cname record usage"
  default     = false
}

variable "dns_cname_record_name" {
  description = "The name of the DNS cname Record."
  default     = ""
}

variable "dns_cname_record_zone_name" {
  description = "Specifies the DNS Zone where the DNS Zone (parent resource) exists. Changing this forces a new resource to be created."
  default     = ""
}

variable "dns_cname_record_resource_group_name" {
  description = "(Required) Specifies the resource group where the resource exists. Changing this forces a new resource to be created."
  default     = null
}

variable "dns_cname_record_ttl" {
  description = "(Required) The Time To Live (TTL) of the DNS record in seconds."
  default     = null
}

variable "dns_cname_record_record" {
  description = "(Required) The target of the CNAME."
  default     = ""
}

variable "dns_cname_record_target_resource_id" {
  description = "(Optional) The Azure resource id of the target object. Conflicts with records"
  default     = null
}

variable "dns_cname_record_timeouts" {
  description = "Set timeouts for dns MX record"
  default     = {}
}

#-----------------------------------------------------------
# Azure dns caa record
#-----------------------------------------------------------
variable "enable_dns_caa_record" {
  description = "Enable dns CAA record usage"
  default     = false
}

variable "dns_caa_record_name" {
  description = "The name of the DNS CAA Record."
  default     = ""
}

variable "dns_caa_record_zone_name" {
  description = "Specifies the DNS Zone where the DNS Zone (parent resource) exists. Changing this forces a new resource to be created."
  default     = ""
}

variable "dns_caa_record_resource_group_name" {
  description = "(Required) Specifies the resource group where the resource exists. Changing this forces a new resource to be created."
  default     = null
}

variable "dns_caa_record_ttl" {
  description = "(Required) The Time To Live (TTL) of the DNS record in seconds."
  default     = null
}

variable "dns_caa_record_record" {
  description = "(Required) A list of values that make up the CAA record"
  default     = []
}

variable "dns_caa_record_timeouts" {
  description = "Set timeouts for dns CAA record"
  default     = {}
}

#-----------------------------------------------------------
# Azure dns aaaa record
#-----------------------------------------------------------
variable "enable_dns_aaaa_record" {
  description = "Enable dns CAA record usage"
  default     = false
}

variable "dns_aaaa_record_name" {
  description = "The name of the DNS CAA Record."
  default     = ""
}

variable "dns_aaaa_record_zone_name" {
  description = "Specifies the DNS Zone where the DNS Zone (parent resource) exists. Changing this forces a new resource to be created."
  default     = ""
}

variable "dns_aaaa_record_resource_group_name" {
  description = "(Required) Specifies the resource group where the resource exists. Changing this forces a new resource to be created."
  default     = null
}

variable "dns_aaaa_record_ttl" {
  description = "(Required) The Time To Live (TTL) of the DNS record in seconds."
  default     = null
}

variable "dns_aaaa_record_records" {
  description = "(Optional) List of IPv6 Addresses. Conflicts with target_resource_id"
  default     = []
}

variable "dns_aaaa_record_timeouts" {
  description = "Set timeouts for dns CAA record"
  default     = {}
}

#-----------------------------------------------------------
# Azure dns a record
#-----------------------------------------------------------
variable "enable_dns_a_record" {
  description = "Enable dns A record usage"
  default     = false
}

variable "dns_a_record_name" {
  description = "The name of the DNS A Record."
  default     = ""
}

variable "dns_a_record_zone_name" {
  description = "Specifies the DNS Zone where the DNS Zone (parent resource) exists. Changing this forces a new resource to be created."
  default     = ""
}

variable "dns_a_record_resource_group_name" {
  description = "(Required) Specifies the resource group where the resource exists. Changing this forces a new resource to be created."
  default     = null
}

variable "dns_a_record_ttl" {
  description = "(Required) The Time To Live (TTL) of the DNS record in seconds."
  default     = null
}

variable "dns_a_record_records" {
  description = "(Optional) List of IPv4 Addresses. Conflicts with target_resource_id."
  default     = []
}

variable "dns_a_record_target_resource_id" {
  description = "(Optional) The Azure resource id of the target object. Conflicts with records"
  default     = null
}

variable "dns_a_record_timeouts" {
  description = "Set timeouts for dns A record"
  default     = {}
}