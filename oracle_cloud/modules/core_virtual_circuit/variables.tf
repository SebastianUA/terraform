#-----------------------------------------------------------
# Global
#-----------------------------------------------------------
variable "name" {
  description = "The name for resources"
  default     = "test"
}

variable "environment" {
  description = "The environment for resources"
  default     = "dev"
}

variable "tags" {
  description = "Add additional tags"
  default     = {}
}

#-----------------------------------------------------------
# core virtual circuit
#-----------------------------------------------------------
variable "enable_core_virtual_circuit" {
  description = "Enable core virtual circuit usages"
  default     = false
}

variable "core_virtual_circuit_compartment_id" {
  description = "(Required) (Updatable) The OCID of the compartment to contain the virtual circuit."
  default     = null
}

variable "core_virtual_circuit_type" {
  description = "(Required) The type of IP addresses used in this virtual circuit. PRIVATE means RFC 1918 addresses (10.0.0.0/8, 172.16/12, and 192.168/16)."
  default     = null
}

variable "core_virtual_circuit_bandwidth_shape_name" {
  description = "(Optional) (Updatable) The provisioned data rate of the connection. To get a list of the available bandwidth levels (that is, shapes), see ListFastConnectProviderServiceVirtualCircuitBandwidthShapes. Example: 10 Gbps"
  default     = null
}

variable "core_virtual_circuit_bgp_admin_state" {
  description = "(Optional) (Updatable) Set to ENABLED (the default) to activate the BGP session of the virtual circuit, set to DISABLED to deactivate the virtual circuit."
  default     = null
}

variable "core_virtual_circuit_cross_connect_mappings" {
  description = "Optional) (Updatable) Create a CrossConnectMapping for each cross-connect or cross-connect group this virtual circuit will run on."
  default     = []
}

variable "core_virtual_circuit_customer_asn" {
  description = "(Optional) (Updatable) Your BGP ASN (either public or private). Provide this value only if there's a BGP session that goes from your edge router to Oracle. Otherwise, leave this empty or null. Can be a 2-byte or 4-byte ASN. Uses 'asplain' format. Example: 12345 (2-byte) or 1587232876 (4-byte)"
  default     = null
}

variable "core_virtual_circuit_customer_bgp_asn" {
  description = "(Optional) (Updatable) Deprecated. Instead use customerAsn. If you specify values for both, the request will be rejected."
  default     = null
}

variable "core_virtual_circuit_display_name" {
  description = "(Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  default     = null
}

variable "core_virtual_circuit_ip_mtu" {
  description = "(Optional) (Updatable) The layer 3 IP MTU to use with this virtual circuit."
  default     = null
}

variable "core_virtual_circuit_is_bfd_enabled" {
  description = "(Optional) (Updatable) Set to true to enable BFD for IPv4 BGP peering, or set to false to disable BFD. If this is not set, the default is false."
  default     = null
}

variable "core_virtual_circuit_is_transport_mode" {
  description = "(Optional) (Updatable) Set to true for the virtual circuit to carry only encrypted traffic, or set to false for the virtual circuit to carry unencrypted traffic. If this is not set, the default is false."
  default     = null
}

variable "core_virtual_circuit_gateway_id" {
  description = "(Optional) (Updatable) For private virtual circuits only. The OCID of the dynamic routing gateway (DRG) that this virtual circuit uses."
  default     = null
}

variable "core_virtual_circuit_provider_service_id" {
  description = "(Optional) The OCID of the service offered by the provider (if you're connecting via a provider). To get a list of the available service offerings, see ListFastConnectProviderServices."
  default     = null
}

variable "core_virtual_circuit_provider_service_key_name" {
  description = "(Optional) (Updatable) The service key name offered by the provider (if the customer is connecting via a provider)."
  default     = null
}

variable "core_virtual_circuit_region" {
  description = "(Optional) The Oracle Cloud Infrastructure region where this virtual circuit is located. Example: phx"
  default     = null
}

variable "core_virtual_circuit_routing_policy" {
  description = "(Optional) (Updatable) The routing policy sets how routing information about the Oracle cloud is shared over a public virtual circuit. Policies available are: ORACLE_SERVICE_NETWORK, REGIONAL, MARKET_LEVEL, and GLOBAL. See Route Filtering for details. By default, routing information is shared for all routes in the same market."
  default     = null
}

variable "core_virtual_circuit_public_prefixes" {
  description = "(Optional) (Updatable) For a public virtual circuit. The public IP prefixes (CIDRs) the customer wants to advertise across the connection."
  default     = []
}

variable "core_virtual_circuit_freeform_tags" {
  description = "(Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags."
  default     = {}
}

variable "core_virtual_circuit_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Virtual Circuit * update - (Defaults to 20 minutes), when updating the Virtual Circuit * delete - (Defaults to 20 minutes), when destroying the Virtual Circuit"
  default     = {}
}