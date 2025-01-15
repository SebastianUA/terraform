#-----------------------------------------------------------
# core drg
#-----------------------------------------------------------
output "core_drg_id" {
  description = "The DRG's Oracle ID (OCID)."
  value       = element(concat(oci_core_drg.core_drg.*.id, [""]), 0)
}

output "core_drg_display_name" {
  description = "A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  value       = element(concat(oci_core_drg.core_drg.*.display_name, [""]), 0)
}

output "core_drg_redundancy_status" {
  description = "The redundancy status of the DRG specified."
  value       = element(concat(oci_core_drg.core_drg.*.redundancy_status, [""]), 0)
}

output "core_drg_state" {
  description = "The DRG's current state."
  value       = element(concat(oci_core_drg.core_drg.*.state, [""]), 0)
}

output "core_drg_default_export_drg_route_distribution_id" {
  description = "The OCID of this DRG's default export route distribution for the DRG attachments."
  value       = element(concat(oci_core_drg.core_drg.*.default_export_drg_route_distribution_id, [""]), 0)
}

output "core_drg_compartment_id" {
  description = "The OCID of the compartment containing the DRG."
  value       = element(concat(oci_core_drg.core_drg.*.compartment_id, [""]), 0)
}

output "core_drg_default_drg_route_tables" {
  description = "The default DRG route table for this DRG. Each network type has a default DRG route table."
  value       = concat(oci_core_drg.core_drg.*.default_drg_route_tables, [""])
}

#-----------------------------------------------------------
# drg attachments list
#-----------------------------------------------------------
output "core_drg_attachments_list_id" {
  description = "The Oracle-assigned ID of the DRG attachment"
  value       = element(concat(oci_core_drg_attachments_list.core_drg_attachments_list.*.id, [""]), 0)
}

output "core_drg_attachments_list_drg_all_attachments" {
  description = "The list of drg_attachments."
  value       = concat(oci_core_drg_attachments_list.core_drg_attachments_list.*.drg_all_attachments, [""])
}

#-----------------------------------------------------------
# drg route distribution
#-----------------------------------------------------------
output "core_drg_route_distribution_id" {
  description = "The route distribution's Oracle ID (OCID)."
  value       = element(concat(oci_core_drg_route_distribution.core_drg_route_distribution.*.id, [""]), 0)
}

output "core_drg_route_distribution_compartment_id" {
  description = "The OCID of the compartment containing the route distribution."
  value       = element(concat(oci_core_drg_route_distribution.core_drg_route_distribution.*.compartment_id, [""]), 0)
}

output "core_drg_route_distribution_display_name" {
  description = "A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  value       = element(concat(oci_core_drg_route_distribution.core_drg_route_distribution.*.display_name, [""]), 0)
}

output "core_drg_route_distribution_distribution_type" {
  description = "Whether this distribution defines how routes get imported into route tables or exported through DRG attachments."
  value       = element(concat(oci_core_drg_route_distribution.core_drg_route_distribution.*.distribution_type, [""]), 0)
}

output "core_drg_route_distribution_drg_id" {
  description = "The OCID of the DRG that contains this route distribution."
  value       = element(concat(oci_core_drg_route_distribution.core_drg_route_distribution.*.drg_id, [""]), 0)
}

output "core_drg_route_distribution_state" {
  description = "The route distribution's current state."
  value       = element(concat(oci_core_drg_route_distribution.core_drg_route_distribution.*.state, [""]), 0)
}

output "core_drg_route_distribution_time_created" {
  description = "The date and time the route distribution was created, in the format defined by RFC3339. Example: 2016-08-25T21:10:29.600Z"
  value       = element(concat(oci_core_drg_route_distribution.core_drg_route_distribution.*.time_created, [""]), 0)
}

#-----------------------------------------------------------
# core drg route distribution statement
#-----------------------------------------------------------
output "core_drg_route_distribution_statement_id" {
  description = "The Oracle-assigned ID of the route distribution statement."
  value       = element(concat(oci_core_drg_route_distribution_statement.core_drg_route_distribution_statement.*.id, [""]), 0)
}

output "core_drg_route_distribution_statement_action" {
  description = "ACCEPT indicates the route should be imported or exported as-is."
  value       = element(concat(oci_core_drg_route_distribution_statement.core_drg_route_distribution_statement.*.action, [""]), 0)
}

output "core_drg_route_distribution_statement_match_criteria" {
  description = "The action is applied only if all of the match criteria is met. If match type is MATCH_ALL, any input is considered a match."
  value       = concat(oci_core_drg_route_distribution_statement.core_drg_route_distribution_statement.*.match_criteria, [""])
}

output "core_drg_route_distribution_statement_priority" {
  description = "This field specifies the priority of each statement in a route distribution. Priorities must be unique within a particular route distribution. The priority will be represented as a number between 0 and 65535 where a lower number indicates a higher priority. When a route is processed, statements are applied in the order defined by their priority. The first matching rule dictates the action that will be taken on the route."
  value       = element(concat(oci_core_drg_route_distribution_statement.core_drg_route_distribution_statement.*.priority, [""]), 0)
}

#-----------------------------------------------------------
# core drg attachment
#-----------------------------------------------------------
output "core_drg_attachment_id" {
  description = "The DRG attachment's Oracle ID (OCID)."
  value       = element(concat(oci_core_drg_attachment.core_drg_attachment.*.id, [""]), 0)
}

output "core_drg_attachment_state" {
  description = "The DRG attachment's current state."
  value       = element(concat(oci_core_drg_attachment.core_drg_attachment.*.state, [""]), 0)
}

output "core_drg_attachment_vcn_id" {
  description = "The OCID of the VCN. This field is deprecated. Instead, use the networkDetails field to view the OCID of the attached resource."
  value       = element(concat(oci_core_drg_attachment.core_drg_attachment.*.id, [""]), 0)
}

output "core_drg_attachment_route_table_id" {
  description = "The OCID of the route table the DRG attachment is using."
  value       = element(concat(oci_core_drg_attachment.core_drg_attachment.*.route_table_id, [""]), 0)
}

output "core_drg_attachment_is_cross_tenancy" {
  description = "Indicates whether the DRG attachment and attached network live in a different tenancy than the DRG. Example: false"
  value       = element(concat(oci_core_drg_attachment.core_drg_attachment.*.is_cross_tenancy, [""]), 0)
}

output "core_drg_attachment_network_details" {
  description = "Output for network details"
  value       = concat(oci_core_drg_attachment.core_drg_attachment.*.network_details, [""])
}

output "core_drg_attachment_compartment_id" {
  description = "The OCID of the compartment containing the DRG attachment."
  value       = element(concat(oci_core_drg_attachment.core_drg_attachment.*.compartment_id, [""]), 0)
}

output "core_drg_attachment_display_name" {
  description = "A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  value       = element(concat(oci_core_drg_attachment.core_drg_attachment.*.display_name, [""]), 0)
}

output "core_drg_attachment_drg_id" {
  description = "The OCID of the DRG."
  value       = element(concat(oci_core_drg_attachment.core_drg_attachment.*.drg_id, [""]), 0)
}

output "core_drg_attachment_drg_route_table_id" {
  description = "The OCID of the DRG route table that is assigned to this attachment."
  value       = element(concat(oci_core_drg_attachment.core_drg_attachment.*.drg_route_table_id, [""]), 0)
}

output "core_drg_attachment_export_drg_route_distribution_id" {
  description = "The OCID of the export route distribution used to specify how routes in the assigned DRG route table are advertised to the attachment. If this value is null, no routes are advertised through this attachment."
  value       = element(concat(oci_core_drg_attachment.core_drg_attachment.*.export_drg_route_distribution_id, [""]), 0)
}

#-----------------------------------------------------------
# core drg attachment management
#-----------------------------------------------------------
output "core_drg_attachment_management_route_table_id" {
  description = "The OCID of the route table the DRG attachment is using."
  value       = element(concat(oci_core_drg_attachment_management.core_drg_attachment_management.*.route_table_id, [""]), 0)
}

output "core_drg_attachment_management_vcn_id" {
  description = "The OCID of the VCN."
  value       = element(concat(oci_core_drg_attachment_management.core_drg_attachment_management.*.vcn_id, [""]), 0)
}

output "core_drg_attachment_management_export_drg_route_distribution_id" {
  description = "The OCID of the export route distribution used to specify how routes in the assigned DRG route table are advertised to the attachment. If this value is null, no routes are advertised through this attachment."
  value       = element(concat(oci_core_drg_attachment_management.core_drg_attachment_management.*.export_drg_route_distribution_id, [""]), 0)
}

output "core_drg_attachment_management_remove_export_drg_route_distribution_trigger" {
  description = "An optional property when set to true during update disables the export of route Distribution by setting export_drg_route_distribution_id to null."
  value       = element(concat(oci_core_drg_attachment_management.core_drg_attachment_management.*.remove_export_drg_route_distribution_trigger, [""]), 0)
}

output "core_drg_attachment_management_is_cross_tenancy" {
  description = "Indicates whether the DRG attachment and attached network live in a different tenancy than the DRG. Example: false"
  value       = element(concat(oci_core_drg_attachment_management.core_drg_attachment_management.*.is_cross_tenancy, [""]), 0)
}

output "core_drg_attachment_management_state" {
  description = "A filter to return only resources that match the specified lifecycle state. The value is case insensitive."
  value       = element(concat(oci_core_drg_attachment_management.core_drg_attachment_management.*.state, [""]), 0)
}

output "core_drg_attachment_management_network_details" {
  description = "Outputs for DRG network details"
  value       = concat(oci_core_drg_attachment_management.core_drg_attachment_management.*.id, [""])
}

output "core_drg_attachment_management_attachment_type" {
  description = "The type for the network resource attached to the DRG."
  value       = element(concat(oci_core_drg_attachment_management.core_drg_attachment_management.*.attachment_type, [""]), 0)
}

output "core_drg_attachment_management_compartment_id" {
  description = "The OCID of the compartment."
  value       = element(concat(oci_core_drg_attachment_management.core_drg_attachment_management.*.compartment_id, [""]), 0)
}

output "core_drg_attachment_management_network_id" {
  description = "The OCID of the resource (virtual circuit, VCN, IPSec tunnel, or remote peering connection) attached to the DRG."
  value       = element(concat(oci_core_drg_attachment_management.core_drg_attachment_management.*.network_id, [""]), 0)
}

output "core_drg_attachment_management_display_name" {
  description = "A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  value       = element(concat(oci_core_drg_attachment_management.core_drg_attachment_management.*.display_name, [""]), 0)
}

output "core_drg_attachment_management_drg_id" {
  description = "The OCID of the DRG."
  value       = element(concat(oci_core_drg_attachment_management.core_drg_attachment_management.*.drg_id, [""]), 0)
}

output "core_drg_attachment_management_drg_route_table_id" {
  description = "The OCID of the DRG route table assigned to the DRG attachment."
  value       = element(concat(oci_core_drg_attachment_management.core_drg_attachment_management.*.drg_route_table_id, [""]), 0)
}

#-----------------------------------------------------------
# core drg route table
#-----------------------------------------------------------
output "core_drg_route_table_id" {
  description = "The OCID of the DRG route table."
  value       = element(concat(oci_core_drg_route_table.core_drg_route_table.*.id, [""]), 0)
}

output "core_drg_route_table_import_drg_route_distribution_id" {
  description = "The OCID of the import route distribution used to specify how incoming route advertisements from referenced attachments are inserted into the DRG route table."
  value       = element(concat(oci_core_drg_route_table.core_drg_route_table.*.import_drg_route_distribution_id, [""]), 0)
}

output "core_drg_route_table_is_ecmp_enabled" {
  description = "If you want traffic to be routed using ECMP across your virtual circuits or IPSec tunnels to your on-premises network, enable ECMP on the DRG route table to which these attachments import routes."
  value       = element(concat(oci_core_drg_route_table.core_drg_route_table.*.is_ecmp_enabled, [""]), 0)
}

output "core_drg_route_table_state" {
  description = "The DRG route table's current state."
  value       = element(concat(oci_core_drg_route_table.core_drg_route_table.*.state, [""]), 0)
}

output "core_drg_route_table_compartment_id" {
  description = "The OCID of the compartment the DRG is in. The DRG route table is always in the same compartment as the DRG."
  value       = element(concat(oci_core_drg_route_table.core_drg_route_table.*.compartment_id, [""]), 0)
}

output "core_drg_route_table_display_name" {
  description = "A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  value       = element(concat(oci_core_drg_route_table.core_drg_route_table.*.display_name, [""]), 0)
}

output "core_drg_route_table_drg_id" {
  description = "The OCID of the DRG the DRG that contains this route table."
  value       = element(concat(oci_core_drg_route_table.core_drg_route_table.*.drg_id, [""]), 0)
}

#-----------------------------------------------------------
# core drg route table route rule
#-----------------------------------------------------------
output "core_drg_route_table_route_rule_attributes" {
  description = "Additional properties for the route, computed by the service."
  value       = concat(oci_core_drg_route_table_route_rule.core_drg_route_table_route_rule.*.attributes, [""])
}

output "core_drg_route_table_route_rule_destination" {
  description = "Represents the range of IP addresses to match against when routing traffic."
  value       = element(concat(oci_core_drg_route_table_route_rule.core_drg_route_table_route_rule.*.destination, [""]), 0)
}

output "core_drg_route_table_route_rule_destination_type" {
  description = "The type of destination for the rule."
  value       = element(concat(oci_core_drg_route_table_route_rule.core_drg_route_table_route_rule.*.destination_type, [""]), 0)
}

output "core_drg_route_table_route_rule_id" {
  description = "The Oracle-assigned ID of the DRG route rule."
  value       = element(concat(oci_core_drg_route_table_route_rule.core_drg_route_table_route_rule.*.id, [""]), 0)
}

output "core_drg_route_table_route_rule_is_blackhole" {
  description = "Indicates that if the next hop attachment does not exist, so traffic for this route is discarded without notification."
  value       = element(concat(oci_core_drg_route_table_route_rule.core_drg_route_table_route_rule.*.is_blackhole, [""]), 0)
}

output "core_drg_route_table_route_rule_is_conflict" {
  description = "Indicates that the route was not imported due to a conflict between route rules."
  value       = element(concat(oci_core_drg_route_table_route_rule.core_drg_route_table_route_rule.*.is_conflict, [""]), 0)
}

output "core_drg_route_table_route_rule_next_hop_drg_attachment_id" {
  description = "The OCID of the next hop DRG attachment responsible for reaching the network destination."
  value       = element(concat(oci_core_drg_route_table_route_rule.core_drg_route_table_route_rule.*.next_hop_drg_attachment_id, [""]), 0)
}

output "core_drg_route_table_route_rule_route_provenance" {
  description = "The earliest origin of a route. If a route is advertised to a DRG through an IPsec tunnel attachment, and is propagated to peered DRGs via RPC attachments, the route's provenance in the peered DRGs remains IPSEC_TUNNEL, because that is the earliest origin."
  value       = element(concat(oci_core_drg_route_table_route_rule.core_drg_route_table_route_rule.*.route_provenance, [""]), 0)
}

output "core_drg_route_table_route_rule_route_type" {
  description = "You can specify static routes for the DRG route table using the API. The DRG learns dynamic routes from the DRG attachments using various routing protocols."
  value       = element(concat(oci_core_drg_route_table_route_rule.core_drg_route_table_route_rule.*.route_type, [""]), 0)
}
