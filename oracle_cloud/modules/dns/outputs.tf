#-----------------------------------------------------------
# dns record
#-----------------------------------------------------------
output "dns_record_id" {
  description = "The ID of DNS record"
  value       = element(concat(oci_dns_record.dns_record.*.id, [""]), 0)
}

output "dns_record_domain" {
  description = "The fully qualified domain name where the record can be located."
  value       = element(concat(oci_dns_record.dns_record.*.domain, [""]), 0)
}

output "dns_record_compartment_id" {
  description = "The OCID of the compartment the resource belongs to."
  value       = element(concat(oci_dns_record.dns_record.*.compartment_id, [""]), 0)
}

output "dns_record_zone_name_or_id" {
  description = "The name or OCID of the target zone."
  value       = element(concat(oci_dns_record.dns_record.*.zone_name_or_id, [""]), 0)
}

output "dns_record_ttl" {
  description = "The Time To Live for the record, in seconds. Using a TTL lower than 30 seconds is not recommended."
  value       = element(concat(oci_dns_record.dns_record.*.ttl, [""]), 0)
}

output "dns_record_rtype" {
  description = "The canonical name for the record's type, such as A or CNAME. For more information, see Resource Record (RR) TYPEs."
  value       = element(concat(oci_dns_record.dns_record.*.rtype, [""]), 0)
}

output "dns_record_is_protected" {
  description = "A Boolean flag indicating whether or not parts of the record are unable to be explicitly managed."
  value       = element(concat(oci_dns_record.dns_record.*.is_protected, [""]), 0)
}

output "dns_record_rdata" {
  description = "The record's data, as whitespace-delimited tokens in type-specific presentation format. All RDATA is normalized and the returned presentation of your RDATA may differ from its initial input. For more information about RDATA, see Supported DNS Resource Record Types"
  value       = element(concat(oci_dns_record.dns_record.*.rdata, [""]), 0)
}

output "dns_record_record_hash" {
  description = "A unique identifier for the record within its zone."
  value       = element(concat(oci_dns_record.dns_record.*.record_hash, [""]), 0)
}

output "dns_record_rrset_version" {
  description = "The latest version of the record's zone in which its RRSet differs from the preceding version."
  value       = element(concat(oci_dns_record.dns_record.*.rrset_version, [""]), 0)
}

#-----------------------------------------------------------
# dns zone
#-----------------------------------------------------------
output "dns_zone_id" {
  description = "ID of DNS zone"
  value       = element(concat(oci_dns_zone.dns_zone.*.id, [""]), 0)
}

output "dns_zone_compartment_id" {
  description = "The OCID of the compartment containing the zone."
  value       = element(concat(oci_dns_zone.dns_zone.*.compartment_id, [""]), 0)
}

output "dns_zone_dnssec_state" {
  description = "The state of DNSSEC on the zone."
  value       = element(concat(oci_dns_zone.dns_zone.*.dnssec_state, [""]), 0)
}

output "dns_zone_external_downstreams" {
  description = "External secondary servers for the zone. This field is currently not supported when zoneType is SECONDARY or scope is PRIVATE."
  value       = concat(oci_dns_zone.dns_zone.*.external_downstreams, [""])
}

output "dns_zone_external_masters" {
  description = "External master servers for the zone. externalMasters becomes a required parameter when the zoneType value is SECONDARY."
  value       = element(concat(oci_dns_zone.dns_zone.*.external_masters, [""]), 0)
}

output "dns_zone_is_protected" {
  description = "A Boolean flag indicating whether or not parts of the resource are unable to be explicitly managed."
  value       = element(concat(oci_dns_zone.dns_zone.*.is_protected, [""]), 0)
}

output "dns_zone_name" {
  description = "The name of the zone."
  value       = element(concat(oci_dns_zone.dns_zone.*.name, [""]), 0)
}

output "dns_zone_nameservers" {
  description = "The authoritative nameservers for the zone."
  value       = concat(oci_dns_zone.dns_zone.*.nameservers, [""])
}

output "dns_zone_scope" {
  description = "The scope of the zone."
  value       = element(concat(oci_dns_zone.dns_zone.*.scope, [""]), 0)
}

output "dns_zone_self" {
  description = "The canonical absolute URL of the resource."
  value       = element(concat(oci_dns_zone.dns_zone.*.self, [""]), 0)
}

output "dns_zone_serial" {
  description = "The current serial of the zone. As seen in the zone's SOA record."
  value       = element(concat(oci_dns_zone.dns_zone.*.serial, [""]), 0)
}

output "dns_zone_state" {
  description = "The current state of the zone resource."
  value       = element(concat(oci_dns_zone.dns_zone.*.state, [""]), 0)
}

output "dns_zone_version" {
  description = "Version is the never-repeating, totally-orderable, version of the zone, from which the serial field of the zone's SOA record is derived."
  value       = element(concat(oci_dns_zone.dns_zone.*.version, [""]), 0)
}

output "dns_zone_view_id" {
  description = "The OCID of the private view containing the zone. This value will be null for zones in the global DNS, which are publicly resolvable and not part of a private view."
  value       = element(concat(oci_dns_zone.dns_zone.*.view_id, [""]), 0)
}

output "dns_zone_zone_transfer_servers" {
  description = "The Oracle Cloud Infrastructure nameservers that transfer the zone data with external nameservers."
  value       = concat(oci_dns_zone.dns_zone.*.zone_transfer_servers, [""])
}

output "dns_zone_zone_type" {
  description = "The type of the zone. Must be either PRIMARY or SECONDARY. SECONDARY is only supported for GLOBAL zones."
  value       = element(concat(oci_dns_zone.dns_zone.*.zone_type, [""]), 0)
}

#-----------------------------------------------------------
# dns view
#-----------------------------------------------------------
output "dns_view_compartment_id" {
  description = "The OCID of the owning compartment."
  value       = element(concat(oci_dns_view.dns_view.*.compartment_id, [""]), 0)
}

output "dns_view_display_name" {
  description = "The display name of the view."
  value       = element(concat(oci_dns_view.dns_view.*.display_name, [""]), 0)
}

output "dns_view_id" {
  description = "The OCID of the view."
  value       = element(concat(oci_dns_view.dns_view.*.id, [""]), 0)
}

output "dns_view_is_protected" {
  description = "A Boolean flag indicating whether or not parts of the resource are unable to be explicitly managed."
  value       = element(concat(oci_dns_view.dns_view.*.is_protected, [""]), 0)
}

output "dns_view_self" {
  description = "The canonical absolute URL of the resource."
  value       = element(concat(oci_dns_view.dns_view.*.self, [""]), 0)
}

output "dns_view_state" {
  description = "The current state of the resource."
  value       = element(concat(oci_dns_view.dns_view.*.state, [""]), 0)
}

#-----------------------------------------------------------
# dns tsig key
#-----------------------------------------------------------
output "dns_tsig_key_id" {
  description = "The OCID of the resource."
  value       = element(concat(oci_dns_tsig_key.dns_tsig_key.*.id, [""]), 0)
}

output "dns_tsig_key_name" {
  description = "A globally unique domain name identifying the key for a given pair of hosts."
  value       = element(concat(oci_dns_tsig_key.dns_tsig_key.*.name, [""]), 0)
}

output "dns_tsig_key_secret" {
  description = "A base64 string encoding the binary shared secret."
  value       = element(concat(oci_dns_tsig_key.dns_tsig_key.*.secret, [""]), 0)
}

output "dns_tsig_key_self" {
  description = "The canonical absolute URL of the resource."
  value       = element(concat(oci_dns_tsig_key.dns_tsig_key.*.self, [""]), 0)
}

output "dns_tsig_key_state" {
  description = "The current state of the resource."
  value       = element(concat(oci_dns_tsig_key.dns_tsig_key.*.state, [""]), 0)
}

output "dns_tsig_key_algorithm" {
  description = "TSIG key algorithms are encoded as domain names, but most consist of only one non-empty label, which is not required to be explicitly absolute. Applicable algorithms include: hmac-sha1, hmac-sha224, hmac-sha256, hmac-sha512. For more information on these algorithms, see RFC 4635."
  value       = element(concat(oci_dns_tsig_key.dns_tsig_key.*.algorithm, [""]), 0)
}

output "dns_tsig_key_compartment_id" {
  description = "The OCID of the compartment containing the TSIG key."
  value       = element(concat(oci_dns_tsig_key.dns_tsig_key.*.compartment_id, [""]), 0)
}

#-----------------------------------------------------------
# dns steering policy
#-----------------------------------------------------------
output "dns_steering_policy_id" {
  description = "The OCID of the resource."
  value       = element(concat(oci_dns_steering_policy.dns_steering_policy.*.id, [""]), 0)
}

output "dns_steering_policy_rules" {
  description = "The series of rules that will be processed in sequence to reduce the pool of answers to a response for any given request."
  value       = concat(oci_dns_steering_policy.dns_steering_policy.*.rules, [""])
}

output "dns_steering_policy_self" {
  description = "The canonical absolute URL of the resource."
  value       = element(concat(oci_dns_steering_policy.dns_steering_policy.*.self, [""]), 0)
}

output "dns_steering_policy_state" {
  description = "The current state of the resource."
  value       = element(concat(oci_dns_steering_policy.dns_steering_policy.*.state, [""]), 0)
}

output "dns_steering_policy_template" {
  description = "A set of predefined rules based on the desired purpose of the steering policy. Each template utilizes Traffic Management's rules in a different order to produce the desired results when answering DNS queries."
  value       = concat(oci_dns_steering_policy.dns_steering_policy.*.template, [""])
}

output "dns_steering_policy_ttl" {
  description = "The Time To Live (TTL) for responses from the steering policy, in seconds. If not specified during creation, a value of 30 seconds will be used."
  value       = element(concat(oci_dns_steering_policy.dns_steering_policy.*.ttls, [""]), 0)
}

output "dns_steering_policy_compartment_id" {
  description = "The OCID of the compartment containing the steering policy."
  value       = element(concat(oci_dns_steering_policy.dns_steering_policy.*.compartment_id, [""]), 0)
}

output "dns_steering_policy_display_name" {
  description = "A user-friendly name for the steering policy. Does not have to be unique and can be changed. Avoid entering confidential information."
  value       = element(concat(oci_dns_steering_policy.dns_steering_policy.*.display_name, [""]), 0)
}

output "dns_steering_policy_health_check_monitor_id" {
  description = "The OCID of the health check monitor providing health data about the answers of the steering policy. A steering policy answer with rdata matching a monitored endpoint will use the health data of that endpoint. A steering policy answer with rdata not matching any monitored endpoint will be assumed healthy."
  value       = element(concat(oci_dns_steering_policy.dns_steering_policy.*.health_check_monitor_id, [""]), 0)
}

#-----------------------------------------------------------
# dns steering policy attachment
#-----------------------------------------------------------
output "dns_steering_policy_attachment_id" {
  description = "The OCID of the resource."
  value       = element(concat(oci_dns_steering_policy_attachment.dns_steering_policy_attachment.*.id, [""]), 0)
}

output "dns_steering_policy_attachment_display_name" {
  description = "A user-friendly name for the steering policy attachment. Does not have to be unique and can be changed. Avoid entering confidential information."
  value       = element(concat(oci_dns_steering_policy_attachment.dns_steering_policy_attachment.*.display_name, [""]), 0)
}

output "dns_steering_policy_attachment_domain_name" {
  description = "The attached domain within the attached zone."
  value       = element(concat(oci_dns_steering_policy_attachment.dns_steering_policy_attachment.*.domain_name, [""]), 0)
}

output "dns_steering_policy_attachment_compartment_id" {
  description = "The OCID of the compartment containing the steering policy attachment."
  value       = element(concat(oci_dns_steering_policy_attachment.dns_steering_policy_attachment.*.compartment_id, [""]), 0)
}

output "dns_steering_policy_attachment_rtypes" {
  description = "The record types covered by the attachment at the domain. The set of record types is determined by aggregating the record types from the answers defined in the steering policy."
  value       = element(concat(oci_dns_steering_policy_attachment.dns_steering_policy_attachment.*.rtypes, [""]), 0)
}

output "dns_steering_policy_attachment_self" {
  description = "The canonical absolute URL of the resource."
  value       = element(concat(oci_dns_steering_policy_attachment.dns_steering_policy_attachment.*.self, [""]), 0)
}

output "dns_steering_policy_attachment_state" {
  description = "The current state of the resource."
  value       = element(concat(oci_dns_steering_policy_attachment.dns_steering_policy_attachment.*.state, [""]), 0)
}

output "dns_steering_policy_attachment_steering_policy_id" {
  description = "The OCID of the attached steering policy."
  value       = element(concat(oci_dns_steering_policy_attachment.dns_steering_policy_attachment.*.steering_policy_id, [""]), 0)
}

output "dns_steering_policy_attachment_zone_id" {
  description = "The OCID of the attached zone."
  value       = element(concat(oci_dns_steering_policy_attachment.dns_steering_policy_attachment.*.zone_id, [""]), 0)
}

#-----------------------------------------------------------
# dns action create zone from zone file
#-----------------------------------------------------------
output "dns_action_create_zone_from_zone_file_id" {
  description = "The OCID of the zone."
  value       = element(concat(oci_dns_action_create_zone_from_zone_file.dns_action_create_zone_from_zone_file.*.id, [""]), 0)
}

output "dns_action_create_zone_from_zone_file_is_protected" {
  description = "A Boolean flag indicating whether or not parts of the resource are unable to be explicitly managed."
  value       = element(concat(oci_dns_action_create_zone_from_zone_file.dns_action_create_zone_from_zone_file.*.is_protected, [""]), 0)
}

output "dns_action_create_zone_from_zone_file_name" {
  description = "The name of the zone."
  value       = element(concat(oci_dns_action_create_zone_from_zone_file.dns_action_create_zone_from_zone_file.*.name, [""]), 0)
}

output "dns_action_create_zone_from_zone_file_nameservers" {
  description = "The authoritative nameservers for the zone."
  value       = concat(oci_dns_action_create_zone_from_zone_file.dns_action_create_zone_from_zone_file.*.nameservers, [""])
}

output "dns_action_create_zone_from_zone_file_scope" {
  description = "The scope of the zone."
  value       = element(concat(oci_dns_action_create_zone_from_zone_file.dns_action_create_zone_from_zone_file.*.scope, [""]), 0)
}

output "dns_action_create_zone_from_zone_file_self" {
  description = "The canonical absolute URL of the resource."
  value       = element(concat(oci_dns_action_create_zone_from_zone_file.dns_action_create_zone_from_zone_file.*.self, [""]), 0)
}

output "dns_action_create_zone_from_zone_file_serial" {
  description = "The current serial of the zone. As seen in the zone's SOA record."
  value       = element(concat(oci_dns_action_create_zone_from_zone_file.dns_action_create_zone_from_zone_file.*.serial, [""]), 0)
}

output "dns_action_create_zone_from_zone_file_state" {
  description = "The current state of the zone resource."
  value       = element(concat(oci_dns_action_create_zone_from_zone_file.dns_action_create_zone_from_zone_file.*.state, [""]), 0)
}

output "dns_action_create_zone_from_zone_file_version" {
  description = "Version is the never-repeating, totally-orderable, version of the zone, from which the serial field of the zone's SOA record is derived."
  value       = element(concat(oci_dns_action_create_zone_from_zone_file.dns_action_create_zone_from_zone_file.*.version, [""]), 0)
}

output "dns_action_create_zone_from_zone_file_view_id" {
  description = "The OCID of the private view containing the zone. This value will be null for zones in the global DNS, which are publicly resolvable and not part of a private view."
  value       = element(concat(oci_dns_action_create_zone_from_zone_file.dns_action_create_zone_from_zone_file.*.view_id, [""]), 0)
}

output "dns_action_create_zone_from_zone_file_zone_type" {
  description = "The type of the zone. Must be either PRIMARY or SECONDARY. SECONDARY is only supported for GLOBAL zones."
  value       = element(concat(oci_dns_action_create_zone_from_zone_file.dns_action_create_zone_from_zone_file.*.zone_type, [""]), 0)
}

#-----------------------------------------------------------
# dns rrset
#-----------------------------------------------------------
output "dns_rrset_id" {
  description = "ID of DNS rrset"
  value       = element(concat(oci_dns_rrset.dns_rrset.*.id, [""]), 0)
}

output "dns_rrset_items" {
  description = "Items of DNS rrset"
  value       = concat(oci_dns_rrset.dns_rrset.*.items, [""])
}

#-----------------------------------------------------------
# dns resolver
#-----------------------------------------------------------
output "dns_resolver_id" {
  description = "The OCID of the resolver."
  value       = element(concat(oci_dns_resolver.dns_resolver.*.id, [""]), 0)
}

output "dns_resolver_is_protected" {
  description = "A Boolean flag indicating whether or not parts of the resource are unable to be explicitly managed."
  value       = element(concat(oci_dns_resolver.dns_resolver.*.is_protected, [""]), 0)
}

output "dns_resolver_self" {
  description = "The canonical absolute URL of the resource."
  value       = element(concat(oci_dns_resolver.dns_resolver.*.self, [""]), 0)
}

output "dns_resolver_state" {
  description = "The current state of the resource."
  value       = element(concat(oci_dns_resolver.dns_resolver.*.state, [""]), 0)
}

output "dns_resolver_attached_vcn_id" {
  description = "The OCID of the attached VCN."
  value       = element(concat(oci_dns_resolver.dns_resolver.*.attached_vcn_id, [""]), 0)
}

output "dns_resolver_rules" {
  description = "Rules for the resolver. Rules are evaluated in order."
  value       = concat(oci_dns_resolver.dns_resolver.*.rules, [""])
}

output "dns_resolver_default_view_id" {
  description = "The OCID of the default view."
  value       = element(concat(oci_dns_resolver.dns_resolver.*.default_view_id, [""]), 0)
}

output "dns_resolver_attached_views" {
  description = "The attached views. Views are evaluated in order."
  value       = concat(oci_dns_resolver.dns_resolver.*.attached_views, [""])
}

output "dns_resolver_compartment_id" {
  description = "The OCID of the owning compartment."
  value       = element(concat(oci_dns_resolver.dns_resolver.*.compartment_id, [""]), 0)
}

#-----------------------------------------------------------
# dns resolver endpoint
#-----------------------------------------------------------
output "dns_resolver_endpoint_id" {
  description = "ID of DNS resolver endpoint"
  value       = element(concat(oci_dns_resolver_endpoint.dns_resolver_endpoint.*.id, [""]), 0)
}

output "dns_resolver_endpoint_name" {
  description = "The name of the resolver endpoint. Must be unique, case-insensitive, within the resolver."
  value       = element(concat(oci_dns_resolver_endpoint.dns_resolver_endpoint.*.name, [""]), 0)
}

output "dns_resolver_endpoint_subnet_id" {
  description = "The OCID of a subnet. Must be part of the VCN that the resolver is attached to."
  value       = element(concat(oci_dns_resolver_endpoint.dns_resolver_endpoint.*.subnet_id, [""]), 0)
}

output "dns_resolver_endpoint_state" {
  description = "The current state of the resource."
  value       = element(concat(oci_dns_resolver_endpoint.dns_resolver_endpoint.*.state, [""]), 0)
}

output "dns_resolver_endpoint_self" {
  description = "The canonical absolute URL of the resource."
  value       = element(concat(oci_dns_resolver_endpoint.dns_resolver_endpoint.*.self, [""]), 0)
}

output "dns_resolver_endpoint_nsg_ids" {
  description = "An array of network security group OCIDs for the resolver endpoint. These must be part of the VCN that the resolver endpoint is a part of."
  value       = concat(oci_dns_resolver_endpoint.dns_resolver_endpoint.*.nsg_ids, [""])
}

output "dns_resolver_endpoint_compartment_id" {
  description = "The OCID of the owning compartment. This will match the resolver that the resolver endpoint is under and will be updated if the resolver's compartment is changed."
  value       = element(concat(oci_dns_resolver_endpoint.dns_resolver_endpoint.*.compartment_id, [""]), 0)
}

output "dns_resolver_endpoint_endpoint_type" {
  description = "The type of resolver endpoint. VNIC is currently the only supported type."
  value       = element(concat(oci_dns_resolver_endpoint.dns_resolver_endpoint.*.endpoint_type, [""]), 0)
}

output "dns_resolver_endpoint_forwarding_address" {
  description = "An IP address from which forwarded queries may be sent. For VNIC endpoints, this IP address must be part of the subnet and will be assigned by the system if unspecified when isForwarding is true."
  value       = element(concat(oci_dns_resolver_endpoint.dns_resolver_endpoint.*.forwarding_address, [""]), 0)
}

output "dns_resolver_endpoint_is_forwarding" {
  description = "A Boolean flag indicating whether or not the resolver endpoint is for forwarding."
  value       = element(concat(oci_dns_resolver_endpoint.dns_resolver_endpoint.*.is_forwarding, [""]), 0)
}

output "dns_resolver_endpoint_is_listening" {
  description = "A Boolean flag indicating whether or not the resolver endpoint is for listening."
  value       = element(concat(oci_dns_resolver_endpoint.dns_resolver_endpoint.*.is_listening, [""]), 0)
}

output "dns_resolver_endpoint_listening_address" {
  description = "An IP address to listen to queries on. For VNIC endpoints this IP address must be part of the subnet and will be assigned by the system if unspecified when isListening is true."
  value       = element(concat(oci_dns_resolver_endpoint.dns_resolver_endpoint.*.listening_address, [""]), 0)
}
