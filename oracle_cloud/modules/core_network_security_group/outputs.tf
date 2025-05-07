#-----------------------------------------------------------
# core network security group
#-----------------------------------------------------------
output "core_network_security_group_compartment_id" {
  description = "The OCID of the compartment the network security group is in."
  value       = element(concat(oci_core_network_security_group.core_network_security_group.*.compartment_id, [""]), 0)
}

output "core_network_security_group_display_name" {
  description = "A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  value       = element(concat(oci_core_network_security_group.core_network_security_group.*.display_name, [""]), 0)
}

output "core_network_security_group_id" {
  description = "The OCID of the network security group."
  value       = element(concat(oci_core_network_security_group.core_network_security_group.*.id, [""]), 0)
}

output "core_network_security_group_state" {
  description = "The network security group's current state."
  value       = element(concat(oci_core_network_security_group.core_network_security_group.*.state, [""]), 0)
}

output "core_network_security_group_time_created" {
  description = "The date and time the network security group was created, in the format defined by RFC3339. Example: 2016-08-25T21:10:29.600Z"
  value       = element(concat(oci_core_network_security_group.core_network_security_group.*.time_created, [""]), 0)
}

output "core_network_security_group_vcn_id" {
  description = "The OCID of the network security group's VCN."
  value       = element(concat(oci_core_network_security_group.core_network_security_group.*.vcn_id, [""]), 0)
}

#-----------------------------------------------------------
# core network security group security rule
#-----------------------------------------------------------
output "core_network_security_group_security_rule_udp_options" {
  description = "Optional and valid only for UDP. Use to specify particular destination ports for UDP rules. If you specify UDP as the protocol but omit this object, then all destination ports are allowed."
  value       = concat(oci_core_network_security_group_security_rule.core_network_security_group_security_rule.*.id, [""])
}

output "core_network_security_group_security_rule_time_created" {
  description = "The date and time the security rule was created. Format defined by RFC3339."
  value       = element(concat(oci_core_network_security_group_security_rule.core_network_security_group_security_rule.*.time_created, [""]), 0)
}

output "core_network_security_group_security_rule_stateless" {
  description = "A stateless rule allows traffic in one direction. Remember to add a corresponding stateless rule in the other direction if you need to support bidirectional traffic. For example, if egress traffic allows TCP destination port 80, there should be an ingress rule to allow TCP source port 80. Defaults to false, which means the rule is stateful and a corresponding rule is not necessary for bidirectional traffic."
  value       = element(concat(oci_core_network_security_group_security_rule.core_network_security_group_security_rule.*.stateless, [""]), 0)
}

output "core_network_security_group_security_rule_tcp_options" {
  description = "Optional and valid only for TCP. Use to specify particular destination ports for TCP rules. If you specify TCP as the protocol but omit this object, then all destination ports are allowed."
  value       = concat(oci_core_network_security_group_security_rule.core_network_security_group_security_rule.*.id, [""])
}

output "core_network_security_group_security_rule_source_type" {
  description = "Type of source for the rule. Required if direction = INGRESS."
  value       = element(concat(oci_core_network_security_group_security_rule.core_network_security_group_security_rule.*.source_type, [""]), 0)
}

output "core_network_security_group_security_rule_id" {
  description = "An Oracle-assigned identifier for the security rule. You specify this ID when you want to update or delete the rule. Example: 04ABEC"
  value       = element(concat(oci_core_network_security_group_security_rule.core_network_security_group_security_rule.*.id, [""]), 0)
}

output "core_network_security_group_security_rule_is_valid" {
  description = "Whether the rule is valid. The value is True when the rule is first created. If the rule's source or destination is a network security group, the value changes to False if that network security group is deleted."
  value       = element(concat(oci_core_network_security_group_security_rule.core_network_security_group_security_rule.*.is_valid, [""]), 0)
}

output "core_network_security_group_security_rule_protocol" {
  description = "The transport protocol. Specify either all or an IPv4 protocol number as defined in Protocol Numbers. Options are supported only for ICMP ('1'), TCP ('6'), UDP ('17'), and ICMPv6 ('58')."
  value       = element(concat(oci_core_network_security_group_security_rule.core_network_security_group_security_rule.*.protocol, [""]), 0)
}

output "core_network_security_group_security_rule_source" {
  description = "Conceptually, this is the range of IP addresses that a packet coming into the instance can come from."
  value       = element(concat(oci_core_network_security_group_security_rule.core_network_security_group_security_rule.*.source, [""]), 0)
}

output "core_network_security_group_security_rule_direction" {
  description = "Direction of the security rule. Set to EGRESS for rules to allow outbound IP packets, or INGRESS for rules to allow inbound IP packets."
  value       = element(concat(oci_core_network_security_group_security_rule.core_network_security_group_security_rule.*.direction, [""]), 0)
}

output "core_network_security_group_security_rule_icmp_options" {
  description = "Optional and valid only for ICMP and ICMPv6. Use to specify a particular ICMP type and code"
  value       = concat(oci_core_network_security_group_security_rule.core_network_security_group_security_rule.*.icmp_options, [""])
}

output "core_network_security_group_security_rule_destination_type" {
  description = "Type of destination for the rule. Required if direction = EGRESS."
  value       = element(concat(oci_core_network_security_group_security_rule.core_network_security_group_security_rule.*.destination_type, [""]), 0)
}

output "core_network_security_group_security_rule_description" {
  description = "An optional description of your choice for the rule."
  value       = element(concat(oci_core_network_security_group_security_rule.core_network_security_group_security_rule.*.description, [""]), 0)
}

output "core_network_security_group_security_rule_destination" {
  description = "Conceptually, this is the range of IP addresses that a packet originating from the instance can go to."
  value       = element(concat(oci_core_network_security_group_security_rule.core_network_security_group_security_rule.*.destination, [""]), 0)
}
