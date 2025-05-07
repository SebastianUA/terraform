#-----------------------------------------------------------
# core virtual circuit
#-----------------------------------------------------------
output "core_virtual_circuit_bandwidth_shape_name" {
  description = "The provisioned data rate of the connection. To get a list of the available bandwidth levels (that is, shapes)"
  value       = element(concat(oci_core_virtual_circuit.core_virtual_circuit.*.bandwidth_shape_name, [""]), 0)
}

output "core_virtual_circuit_bgp_admin_state" {
  description = "Set to ENABLED (the default) to activate the BGP session of the virtual circuit, set to DISABLED to deactivate the virtual circuit."
  value       = element(concat(oci_core_virtual_circuit.core_virtual_circuit.*.bgp_admin_state, [""]), 0)
}

output "core_virtual_circuit_bgp_ipv6session_state" {
  description = "The state of the Ipv6 BGP session associated with the virtual circuit."
  value       = element(concat(oci_core_virtual_circuit.core_virtual_circuit.*.bgp_ipv6session_state, [""]), 0)
}

output "core_virtual_circuit_bgp_session_state" {
  description = "The state of the Ipv4 BGP session associated with the virtual circuit."
  value       = element(concat(oci_core_virtual_circuit.core_virtual_circuit.*.bgp_session_state, [""]), 0)
}

output "core_virtual_circuit_compartment_id" {
  description = "The OCID of the compartment containing the virtual circuit."
  value       = element(concat(oci_core_virtual_circuit.core_virtual_circuit.*.compartment_id, [""]), 0)
}

output "core_virtual_circuit_cross_connect_mappings" {
  description = "An array of mappings, each containing properties for a cross-connect or cross-connect group that is associated with this virtual circuit."
  value       = concat(oci_core_virtual_circuit.core_virtual_circuit.*.cross_connect_mappings, [""])
}

output "core_virtual_circuit_customer_asn" {
  description = "The BGP ASN of the network at the other end of the BGP session from Oracle. If the session is between the customer's edge router and Oracle, the value is the customer's ASN. If the BGP session is between the provider's edge router and Oracle, the value is the provider's ASN. Can be a 2-byte or 4-byte ASN. Uses 'asplain' format."
  value       = element(concat(oci_core_virtual_circuit.core_virtual_circuit.*.customer_asn, [""]), 0)
}

output "core_virtual_circuit_display_name" {
  description = "A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  value       = element(concat(oci_core_virtual_circuit.core_virtual_circuit.*.display_name, [""]), 0)
}

output "core_virtual_circuit_gateway_id" {
  description = "The OCID of the customer's dynamic routing gateway (DRG) that this virtual circuit uses. Applicable only to private virtual circuits."
  value       = element(concat(oci_core_virtual_circuit.core_virtual_circuit.*.gateway_id, [""]), 0)
}

output "core_virtual_circuit_id" {
  description = "The virtual circuit's Oracle ID (OCID)."
  value       = element(concat(oci_core_virtual_circuit.core_virtual_circuit.*.id, [""]), 0)
}

output "core_virtual_circuit_ip_mtu" {
  description = "The layer 3 IP MTU to use on this virtual circuit."
  value       = element(concat(oci_core_virtual_circuit.core_virtual_circuit.*.ip_mtu, [""]), 0)
}

output "core_virtual_circuit_is_bfd_enabled" {
  description = "Set to true to enable BFD for IPv4 BGP peering, or set to false to disable BFD. If this is not set, the default is false."
  value       = element(concat(oci_core_virtual_circuit.core_virtual_circuit.*.is_bfd_enabled, [""]), 0)
}

output "core_virtual_circuit_is_transport_mode" {
  description = "Set to true for the virtual circuit to carry only encrypted traffic, or set to false for the virtual circuit to carry unencrypted traffic. If this is not set, the default is false."
  value       = element(concat(oci_core_virtual_circuit.core_virtual_circuit.*.is_transport_mode, [""]), 0)
}

output "core_virtual_circuit_oracle_bgp_asn" {
  description = "The Oracle BGP ASN."
  value       = element(concat(oci_core_virtual_circuit.core_virtual_circuit.*.oracle_bgp_asn, [""]), 0)
}

output "core_virtual_circuit_provider_service_id" {
  description = "The OCID of the service offered by the provider (if the customer is connecting via a provider)."
  value       = element(concat(oci_core_virtual_circuit.core_virtual_circuit.*.provider_service_id, [""]), 0)
}

output "core_virtual_circuit_provider_service_key_name" {
  description = "The service key name offered by the provider (if the customer is connecting via a provider)."
  value       = element(concat(oci_core_virtual_circuit.core_virtual_circuit.*.provider_service_key_name, [""]), 0)
}

output "core_virtual_circuit_provider_state" {
  description = "The provider's state in relation to this virtual circuit (if the customer is connecting via a provider). ACTIVE means the provider has provisioned the virtual circuit from their end. INACTIVE means the provider has not yet provisioned the virtual circuit, or has de-provisioned it."
  value       = element(concat(oci_core_virtual_circuit.core_virtual_circuit.*.provider_state, [""]), 0)
}

output "core_virtual_circuit_public_prefixes" {
  description = "For a public virtual circuit. The public IP prefixes (CIDRs) the customer wants to advertise across the connection. All prefix sizes are allowed."
  value       = concat(oci_core_virtual_circuit.core_virtual_circuit.*.public_prefixes, [""])
}

output "core_virtual_circuit_reference_comment" {
  description = "Provider-supplied reference information about this virtual circuit (if the customer is connecting via a provider)."
  value       = element(concat(oci_core_virtual_circuit.core_virtual_circuit.*.reference_comment, [""]), 0)
}

output "core_virtual_circuit_region" {
  description = "The Oracle Cloud Infrastructure region where this virtual circuit is located."
  value       = element(concat(oci_core_virtual_circuit.core_virtual_circuit.*.region, [""]), 0)
}

output "core_virtual_circuit_routing_policy" {
  description = "The routing policy sets how routing information about the Oracle cloud is shared over a public virtual circuit. Policies available are: ORACLE_SERVICE_NETWORK, REGIONAL, MARKET_LEVEL, and GLOBAL. See Route Filtering for details. By default, routing information is shared for all routes in the same market."
  value       = element(concat(oci_core_virtual_circuit.core_virtual_circuit.*.routing_policy, [""]), 0)
}

output "core_virtual_circuit_service_type" {
  description = "Provider service type."
  value       = element(concat(oci_core_virtual_circuit.core_virtual_circuit.*.service_type, [""]), 0)
}

output "core_virtual_circuit_state" {
  description = "The virtual circuit's current state. For information about the different states, see FastConnect Overview."
  value       = element(concat(oci_core_virtual_circuit.core_virtual_circuit.*.state, [""]), 0)
}

output "core_virtual_circuit_type" {
  description = "Whether the virtual circuit supports private or public peering. For more information, see FastConnect Overview."
  value       = element(concat(oci_core_virtual_circuit.core_virtual_circuit.*.type, [""]), 0)
}
