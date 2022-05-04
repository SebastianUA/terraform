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
# Azure private dns zone
#-----------------------------------------------------------
variable "enable_private_dns_zone" {
  description = "Enable private dns zone usage"
  default     = false
}

variable "private_dns_zone_name" {
  description = "The name of the private DNS Zone. Must be a valid domain name."
  default     = ""
}

variable "private_dns_zone_resource_group_name" {
  description = "(Required) Specifies the resource group where the resource exists. Changing this forces a new resource to be created."
  default     = null
}

variable "private_dns_zone_soa_record" {
  description = "(Optional) An soa_record block as defined below. Changing this forces a new resource to be created."
  default     = {}
}

variable "private_dns_zone_timeouts" {
  description = "Set timeouts for private dns zone"
  default     = {}
}

#-----------------------------------------------------------
# Azure private dns txt record
#-----------------------------------------------------------
variable "enable_private_dns_txt_record" {
  description = "Enable dns txt record usage"
  default     = false
}

variable "private_dns_txt_record_name" {
  description = "The name of the DNS TXT Record."
  default     = ""
}

variable "private_dns_txt_record_zone_name" {
  description = "Specifies the DNS Zone where the DNS Zone (parent resource) exists. Changing this forces a new resource to be created."
  default     = ""
}

variable "private_dns_txt_record_resource_group_name" {
  description = "(Required) Specifies the resource group where the resource exists. Changing this forces a new resource to be created."
  default     = null
}

variable "private_dns_txt_record_ttl" {
  description = "(Required) The Time To Live (TTL) of the DNS record in seconds."
  default     = null
}

variable "private_dns_txt_record_record" {
  description = "(Required) A list of values that make up the txt record."
  default     = []
}

variable "private_dns_txt_record_timeouts" {
  description = "Set timeouts for dns txt record"
  default     = {}
}

#-----------------------------------------------------------
# Azure private dns srv record
#-----------------------------------------------------------
variable "enable_private_dns_srv_record" {
  description = "Enable private dns txt record usage"
  default     = false
}

variable "private_dns_srv_record_name" {
  description = "The name of the DNS SRV Record."
  default     = ""
}

variable "private_dns_srv_record_zone_name" {
  description = "Specifies the DNS Zone where the DNS Zone (parent resource) exists. Changing this forces a new resource to be created."
  default     = ""
}

variable "private_dns_srv_record_resource_group_name" {
  description = "(Required) Specifies the resource group where the resource exists. Changing this forces a new resource to be created."
  default     = null
}

variable "private_dns_srv_record_ttl" {
  description = "(Required) The Time To Live (TTL) of the DNS record in seconds."
  default     = null
}

variable "private_dns_srv_record_record" {
  description = "(Required) A list of values that make up the srv record."
  default     = []
}

variable "private_dns_srv_record_timeouts" {
  description = "Set timeouts for private dns srv record"
  default     = {}
}

#-----------------------------------------------------------
# Azure private dns ptr record
#-----------------------------------------------------------
variable "enable_private_dns_ptr_record" {
  description = "Enable private dns ptr record usage"
  default     = false
}

variable "private_dns_ptr_record_name" {
  description = "The name of the DNS PTR Record."
  default     = ""
}

variable "private_dns_ptr_record_zone_name" {
  description = "Specifies the DNS Zone where the DNS Zone (parent resource) exists. Changing this forces a new resource to be created."
  default     = ""
}

variable "private_dns_ptr_record_resource_group_name" {
  description = "(Required) Specifies the resource group where the resource exists. Changing this forces a new resource to be created."
  default     = null
}

variable "private_dns_ptr_record_ttl" {
  description = "(Required) The Time To Live (TTL) of the DNS record in seconds."
  default     = null
}

variable "private_dns_ptr_record_records" {
  description = "(Required) List of Fully Qualified Domain Names."
  default     = []
}

variable "private_dns_ptr_record_timeouts" {
  description = "Set timeouts for private dns ptr record"
  default     = {}
}

#-----------------------------------------------------------
# Azure private dns mx record
#-----------------------------------------------------------
variable "enable_private_dns_mx_record" {
  description = "Enable private dns MX record usage"
  default     = false
}

variable "private_dns_mx_record_name" {
  description = "The name of the DNS NS Record."
  default     = ""
}

variable "private_dns_mx_record_zone_name" {
  description = "Specifies the DNS Zone where the DNS Zone (parent resource) exists. Changing this forces a new resource to be created."
  default     = ""
}

variable "private_dns_mx_record_resource_group_name" {
  description = "(Required) Specifies the resource group where the resource exists. Changing this forces a new resource to be created."
  default     = null
}

variable "private_dns_mx_record_ttl" {
  description = "(Required) The Time To Live (TTL) of the DNS record in seconds."
  default     = null
}

variable "private_dns_mx_record_records" {
  description = "(Required) List of Fully Qualified Domain Names."
  default     = []
}

variable "private_dns_mx_record_timeouts" {
  description = "Set timeouts for private dns MX record"
  default     = {}
}

#-----------------------------------------------------------
# Azure private dns cname record
#-----------------------------------------------------------
variable "enable_private_dns_cname_record" {
  description = "Enable private dns cname record usage"
  default     = false
}

variable "private_dns_cname_record_name" {
  description = "The name of the DNS cname Record."
  default     = ""
}

variable "private_dns_cname_record_zone_name" {
  description = "Specifies the DNS Zone where the DNS Zone (parent resource) exists. Changing this forces a new resource to be created."
  default     = ""
}

variable "private_dns_cname_record_resource_group_name" {
  description = "(Required) Specifies the resource group where the resource exists. Changing this forces a new resource to be created."
  default     = null
}

variable "private_dns_cname_record_ttl" {
  description = "(Required) The Time To Live (TTL) of the DNS record in seconds."
  default     = null
}

variable "private_dns_cname_record_record" {
  description = "(Required) The target of the CNAME."
  default     = ""
}

variable "private_dns_cname_record_timeouts" {
  description = "Set timeouts for private dns MX record"
  default     = {}
}

#-----------------------------------------------------------
# Azure private dns aaaa record
#-----------------------------------------------------------
variable "enable_private_dns_aaaa_record" {
  description = "Enable private dns CAA record usage"
  default     = false
}

variable "private_dns_aaaa_record_name" {
  description = "The name of the DNS CAA Record."
  default     = ""
}

variable "private_dns_aaaa_record_zone_name" {
  description = "Specifies the DNS Zone where the DNS Zone (parent resource) exists. Changing this forces a new resource to be created."
  default     = ""
}

variable "private_dns_aaaa_record_resource_group_name" {
  description = "(Required) Specifies the resource group where the resource exists. Changing this forces a new resource to be created."
  default     = null
}

variable "private_dns_aaaa_record_ttl" {
  description = "(Required) The Time To Live (TTL) of the DNS record in seconds."
  default     = null
}

variable "private_dns_aaaa_record_records" {
  description = "(Optional) List of IPv6 Addresses. Conflicts with target_resource_id"
  default     = []
}

variable "private_dns_aaaa_record_timeouts" {
  description = "Set timeouts for private dns CAA record"
  default     = {}
}

#-----------------------------------------------------------
# Azure private dns a record
#-----------------------------------------------------------
variable "enable_private_dns_a_record" {
  description = "Enable private dns A record usage"
  default     = false
}

variable "private_dns_a_record_name" {
  description = "The name of the DNS A Record."
  default     = ""
}

variable "private_dns_a_record_zone_name" {
  description = "Specifies the DNS Zone where the DNS Zone (parent resource) exists. Changing this forces a new resource to be created."
  default     = ""
}

variable "private_dns_a_record_resource_group_name" {
  description = "(Required) Specifies the resource group where the resource exists. Changing this forces a new resource to be created."
  default     = null
}

variable "private_dns_a_record_ttl" {
  description = "(Required) The Time To Live (TTL) of the DNS record in seconds."
  default     = null
}

variable "private_dns_a_record_records" {
  description = "(Optional) List of IPv4 Addresses. Conflicts with target_resource_id."
  default     = []
}

variable "private_dns_a_record_target_resource_id" {
  description = "(Optional) The Azure resource id of the target object. Conflicts with records"
  default     = null
}

variable "private_dns_a_record_timeouts" {
  description = "Set timeouts for private dns A record"
  default     = {}
}

#-----------------------------------------------------------
# Azure private dns zone virtual network link
#-----------------------------------------------------------
variable "enable_private_dns_zone_virtual_network_link" {
  description = "Enable private dns zone virtual network link usage"
  default     = false
}

variable "private_dns_zone_virtual_network_link_name" {
  description = "The name of the Private DNS Zone Virtual Network Link. Changing this forces a new resource to be created."
  default     = ""
}

variable "private_dns_zone_virtual_network_link_resource_group_name" {
  description = "(Required) Specifies the resource group where the Private DNS Zone exists. Changing this forces a new resource to be created."
  default     = null
}

variable "private_dns_zone_virtual_network_link_private_dns_zone_name" {
  description = "(Required) The name of the Private DNS zone (without a terminating dot). Changing this forces a new resource to be created."
  default     = ""
}

variable "private_dns_zone_virtual_network_link_virtual_network_id" {
  description = "(Required) The ID of the Virtual Network that should be linked to the DNS Zone. Changing this forces a new resource to be created."
  default     = null
}

variable "private_dns_zone_virtual_network_link_registration_enabled" {
  description = "(Optional) Is auto-registration of virtual machine records in the virtual network in the Private DNS zone enabled? Defaults to false"
  default     = null
}

variable "private_dns_zone_virtual_network_link_timeouts" {
  description = "Set timeouts for private dns zone virtual network link"
  default     = {}
}