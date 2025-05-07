#-----------------------------------------------------------
# bastion bastion
#-----------------------------------------------------------
output "bastion_id" {
  description = "The unique identifier (OCID) of the bastion, which can't be changed after creation."
  value       = element(concat(oci_bastion_bastion.bastion.*.id, [""]), 0)
}

output "bastion_bastion_type" {
  description = "The type of bastion."
  value       = element(concat(oci_bastion_bastion.bastion.*.bastion_type, [""]), 0)
}

output "bastion_compartment_id" {
  description = "The unique identifier (OCID) of the compartment where the bastion is located."
  value       = element(concat(oci_bastion_bastion.bastion.*.compartment_id, [""]), 0)
}

output "bastion_dns_proxy_status" {
  description = "Flag to enable FQDN and SOCKS5 Proxy Support. Example: ENABLED, DISABLED"
  value       = element(concat(oci_bastion_bastion.bastion.*.dns_proxy_status, [""]), 0)
}

output "bastion_max_session_ttl_in_seconds" {
  description = "The maximum amount of time that any session on the bastion can remain active."
  value       = element(concat(oci_bastion_bastion.bastion.*.max_session_ttl_in_seconds, [""]), 0)
}

output "bastion_max_sessions_allowed" {
  description = "The maximum number of active sessions allowed on the bastion."
  value       = element(concat(oci_bastion_bastion.bastion.*.max_sessions_allowed, [""]), 0)
}

output "bastion_name" {
  description = "The name of the bastion, which can't be changed after creation."
  value       = element(concat(oci_bastion_bastion.bastion.*.name, [""]), 0)
}

output "bastion_phone_book_entry" {
  description = "The phonebook entry of the customer's team, which can't be changed after creation. Not applicable to standard bastions."
  value       = element(concat(oci_bastion_bastion.bastion.*.phone_book_entry, [""]), 0)
}

output "bastion_private_endpoint_ip_address" {
  description = "The private IP address of the created private endpoint."
  value       = element(concat(oci_bastion_bastion.bastion.*.private_endpoint_ip_address, [""]), 0)
}

output "bastion_state" {
  description = "The current state of the bastion."
  value       = element(concat(oci_bastion_bastion.bastion.*.state, [""]), 0)
}

output "bastion_static_jump_host_ip_addresses" {
  description = "A list of IP addresses of the hosts that the bastion has access to. Not applicable to standard bastions."
  value       = element(concat(oci_bastion_bastion.bastion.*.static_jump_host_ip_addresses, [""]), 0)
}

output "bastion_target_subnet_id" {
  description = "The unique identifier (OCID) of the subnet that the bastion connects to."
  value       = element(concat(oci_bastion_bastion.bastion.*.target_subnet_id, [""]), 0)
}

output "bastion_target_vcn_id" {
  description = "The unique identifier (OCID) of the virtual cloud network (VCN) that the bastion connects to."
  value       = element(concat(oci_bastion_bastion.bastion.*.target_vcn_id, [""]), 0)
}

#-----------------------------------------------------------
# bastion session
#-----------------------------------------------------------
output "session_id" {
  description = "The unique identifier (OCID) of the session, which can't be changed after creation."
  value       = element(concat(oci_bastion_session.session.*.id, [""]), 0)
}

output "session_display_name" {
  description = "The name of the session."
  value       = element(concat(oci_bastion_session.session.*.display_name, [""]), 0)
}

output "session_bastion_user_name" {
  description = "The username that the session uses to connect to the target resource."
  value       = element(concat(oci_bastion_session.session.*.bastion_user_name, [""]), 0)
}

output "session_bastion_public_host_key_info" {
  description = "The public key of the bastion host. You can use this to verify that you're connecting to the correct bastion."
  value       = element(concat(oci_bastion_session.session.*.bastion_public_host_key_info, [""]), 0)
}

output "session_bastion_name" {
  description = "The name of the bastion that is hosting this session."
  value       = element(concat(oci_bastion_session.session.*.bastion_name, [""]), 0)
}

output "session_bastion_id" {
  description = "The unique identifier (OCID) of the bastion that is hosting this session."
  value       = element(concat(oci_bastion_session.session.*.bastion_id, [""]), 0)
}

output "session_key_type" {
  description = "The type of the key used to connect to the session. PUB is a standard public key in OpenSSH format."
  value       = element(concat(oci_bastion_session.session.*.key_type, [""]), 0)
}

output "session_lifecycle_details" {
  description = "A message describing the current session state in more detail."
  value       = element(concat(oci_bastion_session.session.*.lifecycle_details, [""]), 0)
}

output "session_session_ttl_in_seconds" {
  description = "The amount of time the session can remain active."
  value       = element(concat(oci_bastion_session.session.*.session_ttl_in_seconds, [""]), 0)
}

output "session_ssh_metadata" {
  description = "The connection message for the session."
  value       = element(concat(oci_bastion_session.session.*.ssh_metadata, [""]), 0)
}

output "session_state" {
  description = "The current state of the session."
  value       = element(concat(oci_bastion_session.session.*.state, [""]), 0)
}
