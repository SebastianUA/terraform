#-----------------------------------------------------------
# network firewall
#-----------------------------------------------------------
output "network_firewall_network_firewall_id" {
  description = "The OCID of the Network Firewall resource."
  value       = element(concat(oci_network_firewall_network_firewall.network_firewall_network_firewall.*.id, [""]), 0)
}

output "network_firewall_network_firewall_availability_domain" {
  description = "Availability Domain where Network Firewall instance is created. To get a list of availability domains for a tenancy, use the ListAvailabilityDomains operation. Example: kIdk:PHX-AD-1"
  value       = element(concat(oci_network_firewall_network_firewall.network_firewall_network_firewall.*.availability_domain, [""]), 0)
}

output "network_firewall_network_firewall_compartment_id" {
  description = "The OCID of the compartment containing the Network Firewall."
  value       = element(concat(oci_network_firewall_network_firewall.network_firewall_network_firewall.*.compartment_id, [""]), 0)
}

output "network_firewall_network_firewall_display_name" {
  description = "A user-friendly name for the Network Firewall. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  value       = element(concat(oci_network_firewall_network_firewall.network_firewall_network_firewall.*.display_name, [""]), 0)
}

output "network_firewall_network_firewall_ipv4address" {
  description = "IPv4 address for the Network Firewall."
  value       = element(concat(oci_network_firewall_network_firewall.network_firewall_network_firewall.*.ipv4address, [""]), 0)
}

output "network_firewall_network_firewall_ipv6address" {
  description = "IPv6 address for the Network Firewall."
  value       = element(concat(oci_network_firewall_network_firewall.network_firewall_network_firewall.*.ipv6address, [""]), 0)
}

output "network_firewall_network_firewall_lifecycle_details" {
  description = "A message describing the current state in more detail. For example, it can be used to provide actionable information for a resource in 'FAILED' state."
  value       = concat(oci_network_firewall_network_firewall.network_firewall_network_firewall.*.lifecycle_details, [""])
}

output "network_firewall_network_firewall_network_firewall_policy_id" {
  description = "The OCID of the Network Firewall Policy."
  value       = element(concat(oci_network_firewall_network_firewall.network_firewall_network_firewall.*.network_firewall_policy_id, [""]), 0)
}

output "network_firewall_network_firewall_network_security_group_ids" {
  description = "An array of network security groups OCID associated with the Network Firewall."
  value       = concat(oci_network_firewall_network_firewall.network_firewall_network_firewall.*.network_security_group_ids, [""])
}

output "network_firewall_network_firewall_state" {
  description = "The current state of the Network Firewall."
  value       = element(concat(oci_network_firewall_network_firewall.network_firewall_network_firewall.*.state, [""]), 0)
}

output "network_firewall_network_firewall_subnet_id" {
  description = "The OCID of the subnet associated with the Network Firewall."
  value       = element(concat(oci_network_firewall_network_firewall.network_firewall_network_firewall.*.subnet_id, [""]), 0)
}

output "network_firewall_network_firewall_system_tags" {
  description = "Usage of system tag keys. These predefined keys are scoped to namespaces"
  value       = concat(oci_network_firewall_network_firewall.network_firewall_network_firewall.*.system_tags, [""])
}

output "network_firewall_network_firewall_time_created" {
  description = "The time at which the Network Firewall was created in the format defined by RFC3339. Example: 2016-08-25T21:10:29.600Z"
  value       = element(concat(oci_network_firewall_network_firewall.network_firewall_network_firewall.*.time_created, [""]), 0)
}

output "network_firewall_network_firewall_time_updated" {
  description = "The time at which the Network Firewall was updated in the format defined by RFC3339. Example: 2016-08-25T21:10:29.600Z"
  value       = element(concat(oci_network_firewall_network_firewall.network_firewall_network_firewall.*.time_updated, [""]), 0)
}

#-----------------------------------------------------------
# network firewall policy
#-----------------------------------------------------------
output "network_firewall_network_firewall_policy_id" {
  description = "The OCID of the resource - Network Firewall Policy."
  value       = element(concat(oci_network_firewall_network_firewall_policy.network_firewall_network_firewall_policy.*.id, [""]), 0)
}

output "network_firewall_network_firewall_policy_attached_network_firewall_count" {
  description = "Count of number of Network Firewall attached to the Policy."
  value       = element(concat(oci_network_firewall_network_firewall_policy.network_firewall_network_firewall_policy.*.attached_network_firewall_count, [""]), 0)
}

output "network_firewall_network_firewall_policy_compartment_id" {
  description = "The OCID of the compartment containing the NetworkFirewall Policy."
  value       = element(concat(oci_network_firewall_network_firewall_policy.network_firewall_network_firewall_policy.*.compartment_id, [""]), 0)
}

output "network_firewall_network_firewall_policy_display_name" {
  description = "A user-friendly optional name for the firewall policy. Avoid entering confidential information."
  value       = element(concat(oci_network_firewall_network_firewall_policy.network_firewall_network_firewall_policy.*.display_name, [""]), 0)
}

output "network_firewall_network_firewall_policy_lifecycle_details" {
  description = "A message describing the current state in more detail. For example, can be used to provide actionable information for a resource in Failed state."
  value       = concat(oci_network_firewall_network_firewall_policy.network_firewall_network_firewall_policy.*.lifecycle_details, [""])
}

output "network_firewall_network_firewall_policy_state" {
  description = "The current state of the Network Firewall Policy."
  value       = element(concat(oci_network_firewall_network_firewall_policy.network_firewall_network_firewall_policy.*.state, [""]), 0)
}

output "network_firewall_network_firewall_policy_system_tags" {
  description = "Usage of system tag keys. These predefined keys are scoped to namespaces."
  value       = concat(oci_network_firewall_network_firewall_policy.network_firewall_network_firewall_policy.*.system_tags, [""])
}

output "network_firewall_network_firewall_policy_time_created" {
  description = "The time instant at which the Network Firewall Policy was created in the format defined by RFC3339. Example: 2016-08-25T21:10:29.600Z"
  value       = element(concat(oci_network_firewall_network_firewall_policy.network_firewall_network_firewall_policy.*.time_created, [""]), 0)
}

output "network_firewall_network_firewall_policy_time_updated" {
  description = "The time instant at which the Network Firewall Policy was updated in the format defined by RFC3339. Example: 2016-08-25T21:10:29.600Z"
  value       = element(concat(oci_network_firewall_network_firewall_policy.network_firewall_network_firewall_policy.*.time_updated, [""]), 0)
}

#-----------------------------------------------------------
# network firewall network firewall policy url list
#-----------------------------------------------------------
output "network_firewall_network_firewall_policy_url_list_name" {
  description = "Unique name identifier for the URL list."
  value       = element(concat(oci_network_firewall_network_firewall_policy_url_list.network_firewall_network_firewall_policy_url_list.*.name, [""]), 0)
}

output "network_firewall_network_firewall_policy_url_list_parent_resource_id" {
  description = "OCID of the Network Firewall Policy this URL List belongs to."
  value       = element(concat(oci_network_firewall_network_firewall_policy_url_list.network_firewall_network_firewall_policy_url_list.*.parent_resource_id, [""]), 0)
}

output "network_firewall_network_firewall_policy_url_list_total_urls" {
  description = "Total count of URLs in the URL List"
  value       = concat(oci_network_firewall_network_firewall_policy_url_list.network_firewall_network_firewall_policy_url_list.*.total_urls, [""])
}

output "network_firewall_network_firewall_policy_url_list_urls" {
  description = "List of urls."
  value       = concat(oci_network_firewall_network_firewall_policy_url_list.network_firewall_network_firewall_policy_url_list.*.urls, [""])
}

#-----------------------------------------------------------
# network firewall policy address list
#-----------------------------------------------------------
output "network_firewall_network_firewall_policy_address_list_addresses" {
  description = "List of addresses."
  value       = concat(oci_network_firewall_network_firewall_policy_address_list.network_firewall_network_firewall_policy_address_list.*.addresses, [""])
}

output "network_firewall_network_firewall_policy_address_list_name" {
  description = "Unique name to identify the group of addresses to be used in the policy rules."
  value       = element(concat(oci_network_firewall_network_firewall_policy_address_list.network_firewall_network_firewall_policy_address_list.*.name, [""]), 0)
}

output "network_firewall_network_firewall_policy_address_list_parent_resource_id" {
  description = "OCID of the Network Firewall Policy this Address List belongs to."
  value       = element(concat(oci_network_firewall_network_firewall_policy_address_list.network_firewall_network_firewall_policy_address_list.*.parent_resource_id, [""]), 0)
}

output "network_firewall_network_firewall_policy_address_list_total_addresses" {
  description = "Count of total addresses in the AddressList"
  value       = concat(oci_network_firewall_network_firewall_policy_address_list.network_firewall_network_firewall_policy_address_list.*.total_addresses, [""])
}

output "network_firewall_network_firewall_policy_address_list_type" {
  description = "Type of address list. The accepted values are - * FQDN * IP. The usage FQDN is disabled by default. To get access to use FQDNs (only public FQDNs allowed) please contact support."
  value       = element(concat(oci_network_firewall_network_firewall_policy_address_list.network_firewall_network_firewall_policy_address_list.*.type, [""]), 0)
}

#-----------------------------------------------------------
# network firewall policy application group
#-----------------------------------------------------------
output "network_firewall_network_firewall_policy_application_group_apps" {
  description = "List of apps in the group."
  value       = concat(oci_network_firewall_network_firewall_policy_application_group.network_firewall_network_firewall_policy_application_group.*.apps, [""])
}

output "network_firewall_network_firewall_policy_application_group_name" {
  description = " Name of the application group."
  value       = element(concat(oci_network_firewall_network_firewall_policy_application_group.network_firewall_network_firewall_policy_application_group.*.name, [""]), 0)
}

output "network_firewall_network_firewall_policy_application_group_parent_resource_id" {
  description = "OCID of the Network Firewall Policy this application group belongs to."
  value       = element(concat(oci_network_firewall_network_firewall_policy_application_group.network_firewall_network_firewall_policy_application_group.*.parent_resource_id, [""]), 0)
}

output "network_firewall_network_firewall_policy_application_group_total_apps" {
  description = "Count of total applications in the given application group."
  value       = concat(oci_network_firewall_network_firewall_policy_application_group.network_firewall_network_firewall_policy_application_group.*.total_apps, [""])
}

#-----------------------------------------------------------
# network firewall policy application
#-----------------------------------------------------------
output "network_firewall_network_firewall_policy_application_icmp_code" {
  description = "The value of the ICMP/ICMP_V6 message Code (subtype) field as defined by RFC 4443."
  value       = element(concat(oci_network_firewall_network_firewall_policy_application.network_firewall_network_firewall_policy_application.*.icmp_code, [""]), 0)
}

output "network_firewall_network_firewall_policy_application_icmp_type" {
  description = "The value of the ICMP/ICMP_V6 message Type field as defined by RFC 4443."
  value       = element(concat(oci_network_firewall_network_firewall_policy_application.network_firewall_network_firewall_policy_application.*.icmp_type, [""]), 0)
}

output "network_firewall_network_firewall_policy_application_name" {
  description = " Name of the application."
  value       = element(concat(oci_network_firewall_network_firewall_policy_application.network_firewall_network_firewall_policy_application.*.name, [""]), 0)
}

output "network_firewall_network_firewall_policy_application_parent_resource_id" {
  description = "OCID of the Network Firewall Policy this application belongs to."
  value       = element(concat(oci_network_firewall_network_firewall_policy_application.network_firewall_network_firewall_policy_application.*.parent_resource_id, [""]), 0)
}

output "network_firewall_network_firewall_policy_application_type" {
  description = "Describes the type of application."
  value       = element(concat(oci_network_firewall_network_firewall_policy_application.network_firewall_network_firewall_policy_application.*.type, [""]), 0)
}

#-----------------------------------------------------------
# network firewall policy decryption profile
#-----------------------------------------------------------
output "network_firewall_network_firewall_policy_decryption_profile_name" {
  description = "Unique Name of the decryption profile."
  value       = element(concat(oci_network_firewall_network_firewall_policy_decryption_profile.network_firewall_network_firewall_policy_decryption_profile.*.name, [""]), 0)
}

output "network_firewall_network_firewall_policy_decryption_profile_type" {
  description = "Describes the type of decryption profile."
  value       = element(concat(oci_network_firewall_network_firewall_policy_decryption_profile.network_firewall_network_firewall_policy_decryption_profile.*.type, [""]), 0)
}

output "network_firewall_network_firewall_policy_decryption_profile_parent_resource_id" {
  description = "OCID of the Network Firewall Policy this decryption profile belongs to."
  value       = element(concat(oci_network_firewall_network_firewall_policy_decryption_profile.network_firewall_network_firewall_policy_decryption_profile.*.parent_resource_id, [""]), 0)
}

output "network_firewall_network_firewall_policy_decryption_profile_are_certificate_extensions_restricted" {
  description = "Whether to block sessions if the server's certificate uses extensions other than key usage and/or extended key usage."
  value       = element(concat(oci_network_firewall_network_firewall_policy_decryption_profile.network_firewall_network_firewall_policy_decryption_profile.*.are_certificate_extensions_restricted, [""]), 0)
}

output "network_firewall_network_firewall_policy_decryption_profile_is_auto_include_alt_name" {
  description = "Whether to automatically append SAN to impersonating certificate if server certificate is missing SAN."
  value       = element(concat(oci_network_firewall_network_firewall_policy_decryption_profile.network_firewall_network_firewall_policy_decryption_profile.*.is_auto_include_alt_name, [""]), 0)
}

output "network_firewall_network_firewall_policy_decryption_profile_is_expired_certificate_blocked" {
  description = "Whether to block sessions if server's certificate is expired."
  value       = element(concat(oci_network_firewall_network_firewall_policy_decryption_profile.network_firewall_network_firewall_policy_decryption_profile.*.is_expired_certificate_blocked, [""]), 0)
}

output "network_firewall_network_firewall_policy_decryption_profile_is_out_of_capacity_blocked" {
  description = "Whether to block sessions if the firewall is temporarily unable to decrypt their traffic."
  value       = element(concat(oci_network_firewall_network_firewall_policy_decryption_profile.network_firewall_network_firewall_policy_decryption_profile.*.is_out_of_capacity_blocked, [""]), 0)
}

output "network_firewall_network_firewall_policy_decryption_profile_is_revocation_status_timeout_blocked" {
  description = "Whether to block sessions if the revocation status check for server's certificate does not succeed within the maximum allowed time (defaulting to 5 seconds)."
  value       = element(concat(oci_network_firewall_network_firewall_policy_decryption_profile.network_firewall_network_firewall_policy_decryption_profile.*.is_revocation_status_timeout_blocked, [""]), 0)
}

output "network_firewall_network_firewall_policy_decryption_profile_is_unknown_revocation_status_blocked" {
  description = "Whether to block sessions if the revocation status check for server's certificate results in 'unknown'."
  value       = element(concat(oci_network_firewall_network_firewall_policy_decryption_profile.network_firewall_network_firewall_policy_decryption_profile.*.is_unknown_revocation_status_blocked, [""]), 0)
}

output "network_firewall_network_firewall_policy_decryption_profile_is_unsupported_cipher_blocked" {
  description = "Whether to block sessions if SSL cipher suite is not supported."
  value       = element(concat(oci_network_firewall_network_firewall_policy_decryption_profile.network_firewall_network_firewall_policy_decryption_profile.*.is_unsupported_cipher_blocked, [""]), 0)
}

output "network_firewall_network_firewall_policy_decryption_profile_is_unsupported_version_blocked" {
  description = "Whether to block sessions if SSL version is not supported."
  value       = element(concat(oci_network_firewall_network_firewall_policy_decryption_profile.network_firewall_network_firewall_policy_decryption_profile.*.is_unsupported_version_blocked, [""]), 0)
}

output "network_firewall_network_firewall_policy_decryption_profile_is_untrusted_issuer_blocked" {
  description = "Whether to block sessions if server's certificate is issued by an untrusted certificate authority (CA)."
  value       = element(concat(oci_network_firewall_network_firewall_policy_decryption_profile.network_firewall_network_firewall_policy_decryption_profile.*.is_untrusted_issuer_blocked, [""]), 0)
}

#-----------------------------------------------------------
# network firewall policy decryption rule
#-----------------------------------------------------------
output "network_firewall_network_firewall_policy_decryption_rule_action" {
  description = "Get action"
  value       = element(concat(oci_network_firewall_network_firewall_policy_decryption_rule.network_firewall_network_firewall_policy_decryption_rule.*.action, [""]), 0)
}

output "network_firewall_network_firewall_policy_decryption_rule_condition" {
  description = "Match criteria used in Decryption Rule used on the firewall policy rules."
  value       = element(concat(oci_network_firewall_network_firewall_policy_decryption_rule.network_firewall_network_firewall_policy_decryption_rule.*.condition, [""]), 0)
}

output "network_firewall_network_firewall_policy_decryption_rule_decryption_profile" {
  description = "The name of the decryption profile to use."
  value       = element(concat(oci_network_firewall_network_firewall_policy_decryption_rule.network_firewall_network_firewall_policy_decryption_rule.*.decryption_profile, [""]), 0)
}

output "network_firewall_network_firewall_policy_decryption_rule_secret" {
  description = "The name of a mapped secret. Its type must match that of the specified decryption profile."
  value       = element(concat(oci_network_firewall_network_firewall_policy_decryption_rule.network_firewall_network_firewall_policy_decryption_rule.*.secret, [""]), 0)
}

output "network_firewall_network_firewall_policy_decryption_rule_name" {
  description = "Name for the decryption rule, must be unique within the policy."
  value       = element(concat(oci_network_firewall_network_firewall_policy_decryption_rule.network_firewall_network_firewall_policy_decryption_rule.*.name, [""]), 0)
}

output "network_firewall_network_firewall_policy_decryption_rule_parent_resource_id" {
  description = "OCID of the Network Firewall Policy this decryption rule belongs to."
  value       = element(concat(oci_network_firewall_network_firewall_policy_decryption_rule.network_firewall_network_firewall_policy_decryption_rule.*.parent_resource_id, [""]), 0)
}

output "network_firewall_network_firewall_policy_decryption_rule_position" {
  description = "An object which defines the position of the rule."
  value       = element(concat(oci_network_firewall_network_firewall_policy_decryption_rule.network_firewall_network_firewall_policy_decryption_rule.*.position, [""]), 0)
}

#-----------------------------------------------------------
# network firewall policy mapped secret
#-----------------------------------------------------------
output "network_firewall_network_firewall_policy_mapped_secret_name" {
  description = "Name of the secret."
  value       = element(concat(oci_network_firewall_network_firewall_policy_mapped_secret.network_firewall_network_firewall_policy_mapped_secret.*.name, [""]), 0)
}

output "network_firewall_network_firewall_policy_mapped_secret_parent_resource_id" {
  description = "OCID of the Network Firewall Policy this Mapped Secret belongs to."
  value       = element(concat(oci_network_firewall_network_firewall_policy_mapped_secret.network_firewall_network_firewall_policy_mapped_secret.*.parent_resource_id, [""]), 0)
}

output "network_firewall_network_firewall_policy_mapped_secret_source" {
  description = "Source of the secrets, where the secrets are stored."
  value       = element(concat(oci_network_firewall_network_firewall_policy_mapped_secret.network_firewall_network_firewall_policy_mapped_secret.*.source, [""]), 0)
}

output "network_firewall_network_firewall_policy_mapped_secret_type" {
  description = "Type of the secrets mapped based on the policy."
  value       = element(concat(oci_network_firewall_network_firewall_policy_mapped_secret.network_firewall_network_firewall_policy_mapped_secret.*.type, [""]), 0)
}

output "network_firewall_network_firewall_policy_mapped_secret_vault_secret_id" {
  description = "OCID for the Vault Secret to be used."
  value       = element(concat(oci_network_firewall_network_firewall_policy_mapped_secret.network_firewall_network_firewall_policy_mapped_secret.*.vault_secret_id, [""]), 0)
}

output "network_firewall_network_firewall_policy_mapped_secret_version_number" {
  description = "Version number of the secret to be used."
  value       = element(concat(oci_network_firewall_network_firewall_policy_mapped_secret.network_firewall_network_firewall_policy_mapped_secret.*.version_number, [""]), 0)
}

#-----------------------------------------------------------
# network firewall policy service list
#-----------------------------------------------------------
output "network_firewall_network_firewall_policy_service_list_name" {
  description = "Name of the service Group."
  value       = element(concat(oci_network_firewall_network_firewall_policy_service_list.network_firewall_network_firewall_policy_service_list.*.name, [""]), 0)
}

output "network_firewall_network_firewall_policy_service_list_parent_resource_id" {
  description = "OCID of the Network Firewall Policy this serviceList belongs to."
  value       = element(concat(oci_network_firewall_network_firewall_policy_service_list.network_firewall_network_firewall_policy_service_list.*.parent_resource_id, [""]), 0)
}

output "network_firewall_network_firewall_policy_service_list_services" {
  description = "List of services in the group."
  value       = element(concat(oci_network_firewall_network_firewall_policy_service_list.network_firewall_network_firewall_policy_service_list.*.services, [""]), 0)
}

output "network_firewall_network_firewall_policy_service_list_total_services" {
  description = "Count of total services in the given service List."
  value       = element(concat(oci_network_firewall_network_firewall_policy_service_list.network_firewall_network_firewall_policy_service_list.*.total_services, [""]), 0)
}

#-----------------------------------------------------------
# network firewall policy service
#-----------------------------------------------------------
output "network_firewall_network_firewall_policy_service_name" {
  description = "Name of the service."
  value       = element(concat(oci_network_firewall_network_firewall_policy_service.network_firewall_network_firewall_policy_service.*.name, [""]), 0)
}

output "network_firewall_network_firewall_policy_service_parent_resource_id" {
  description = "OCID of the Network Firewall Policy this service belongs to."
  value       = element(concat(oci_network_firewall_network_firewall_policy_service.network_firewall_network_firewall_policy_service.*.parent_resource_id, [""]), 0)
}

output "network_firewall_network_firewall_policy_service_port_ranges" {
  description = "List of port-ranges used."
  value       = element(concat(oci_network_firewall_network_firewall_policy_service.network_firewall_network_firewall_policy_service.*.port_ranges, [""]), 0)
}

output "network_firewall_network_firewall_policy_service_type" {
  description = "Describes the type of service."
  value       = element(concat(oci_network_firewall_network_firewall_policy_service.network_firewall_network_firewall_policy_service.*.type, [""]), 0)
}

#-----------------------------------------------------------
# network firewall policy tunnel inspection rule
#-----------------------------------------------------------
output "network_firewall_network_firewall_policy_tunnel_inspection_rule_action" {
  description = "Types of Inspect Action on the Traffic flow."
  value       = element(concat(oci_network_firewall_network_firewall_policy_tunnel_inspection_rule.network_firewall_network_firewall_policy_tunnel_inspection_rule.*.action, [""]), 0)
}

output "network_firewall_network_firewall_policy_tunnel_inspection_rule_condition" {
  description = "Criteria to evaluate against incoming network traffic. A match occurs when at least one item in the array associated with each specified property corresponds with the relevant aspect of the traffic."
  value       = element(concat(oci_network_firewall_network_firewall_policy_tunnel_inspection_rule.network_firewall_network_firewall_policy_tunnel_inspection_rule.*.condition, [""]), 0)
}

output "network_firewall_network_firewall_policy_tunnel_inspection_rule_name" {
  description = "Name for the Tunnel Inspection Rule, must be unique within the policy."
  value       = element(concat(oci_network_firewall_network_firewall_policy_tunnel_inspection_rule.network_firewall_network_firewall_policy_tunnel_inspection_rule.*.name, [""]), 0)
}

output "network_firewall_network_firewall_policy_tunnel_inspection_rule_parent_resource_id" {
  description = "OCID of the Network Firewall Policy this Tunnel Inspection Rule belongs to."
  value       = element(concat(oci_network_firewall_network_firewall_policy_tunnel_inspection_rule.network_firewall_network_firewall_policy_tunnel_inspection_rule.*.parent_resource_id, [""]), 0)
}

output "network_firewall_network_firewall_policy_tunnel_inspection_rule_position" {
  description = "An object which defines the position of the rule."
  value       = element(concat(oci_network_firewall_network_firewall_policy_tunnel_inspection_rule.network_firewall_network_firewall_policy_tunnel_inspection_rule.*.position, [""]), 0)
}

output "network_firewall_network_firewall_policy_tunnel_inspection_rule_priority_order" {
  description = "The priority order in which this rule should be evaluated"
  value       = element(concat(oci_network_firewall_network_firewall_policy_tunnel_inspection_rule.network_firewall_network_firewall_policy_tunnel_inspection_rule.*.priority_order, [""]), 0)
}

output "network_firewall_network_firewall_policy_tunnel_inspection_rule_profile" {
  description = "Vxlan Inspect profile used in Vxlan Tunnel Inspection Rules."
  value       = element(concat(oci_network_firewall_network_firewall_policy_tunnel_inspection_rule.network_firewall_network_firewall_policy_tunnel_inspection_rule.*.profile, [""]), 0)
}

#-----------------------------------------------------------
# network firewall policy security rule
#-----------------------------------------------------------
output "network_firewall_network_firewall_policy_security_rule_inspection" {
  description = "Type of inspection to affect the Traffic flow. This is only applicable if action is INSPECT."
  value       = element(concat(oci_network_firewall_network_firewall_policy_security_rule.network_firewall_network_firewall_policy_security_rule.*.inspection, [""]), 0)
}

output "network_firewall_network_firewall_policy_security_rule_name" {
  description = "Name for the Security rule, must be unique within the policy."
  value       = element(concat(oci_network_firewall_network_firewall_policy_security_rule.network_firewall_network_firewall_policy_security_rule.*.name, [""]), 0)
}

output "network_firewall_network_firewall_policy_security_rule_parent_resource_id" {
  description = "OCID of the Network Firewall Policy this security rule belongs to."
  value       = element(concat(oci_network_firewall_network_firewall_policy_security_rule.network_firewall_network_firewall_policy_security_rule.*.parent_resource_id, [""]), 0)
}

output "network_firewall_network_firewall_policy_security_rule_position" {
  description = "An object which defines the position of the rule"
  value       = element(concat(oci_network_firewall_network_firewall_policy_security_rule.network_firewall_network_firewall_policy_security_rule.*.position, [""]), 0)
}

output "network_firewall_network_firewall_policy_security_rule_condition" {
  description = "Criteria to evaluate against network traffic. A match occurs when at least one item in the array associated with each specified property corresponds with the relevant aspect of the traffic."
  value       = element(concat(oci_network_firewall_network_firewall_policy_security_rule.network_firewall_network_firewall_policy_security_rule.*.condition, [""]), 0)
}

output "network_firewall_network_firewall_policy_security_rule_action" {
  description = "Types of Action on the Traffic flow."
  value       = element(concat(oci_network_firewall_network_firewall_policy_security_rule.network_firewall_network_firewall_policy_security_rule.*.action, [""]), 0)
}
