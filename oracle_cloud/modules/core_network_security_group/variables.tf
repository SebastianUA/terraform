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
# core network security group
#-----------------------------------------------------------
variable "enable_core_network_security_group" {
  description = "Enable core network security group usages"
  default     = null
}

variable "core_network_security_group_compartment_id" {
  description = "(Required) (Updatable) The OCID of the compartment to contain the network security group."
  default     = null
}

variable "core_network_security_group_vcn_id" {
  description = "(Required) The OCID of the VCN to create the network security group in."
  default     = null
}

variable "core_network_security_group_display_name" {
  description = "(Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  default     = null
}

variable "core_network_security_group_freeform_tags" {
  description = "(Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags."
  default     = {}
}

variable "core_network_security_group_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Network Security Group * update - (Defaults to 20 minutes), when updating the Network Security Group * delete - (Defaults to 20 minutes), when destroying the Network Security Group"
  default     = {}
}

#-----------------------------------------------------------
# core network security group security rule
#-----------------------------------------------------------
variable "enable_core_network_security_group_security_rule" {
  description = "Enable core network security group security rule usages"
  default     = false
}

variable "core_network_security_group_security_rule_network_security_group_id" {
  description = "The OCID of the network security group."
  default     = ""
}

variable "core_network_security_group_security_rule_direction" {
  description = "(Required) Direction of the security rule. Set to EGRESS for rules to allow outbound IP packets, or INGRESS for rules to allow inbound IP packets."
  default     = null
}

variable "core_network_security_group_security_rule_protocol" {
  description = "(Required) The transport protocol. Specify either all or an IPv4 protocol number as defined in Protocol Numbers. Options are supported only for ICMP ('1'), TCP ('6'), UDP ('17'), and ICMPv6 ('58')."
  default     = null
}

variable "core_network_security_group_security_rule_description" {
  description = "(Optional) An optional description of your choice for the rule. Avoid entering confidential information."
  default     = null
}

variable "core_network_security_group_security_rule_destination" {
  description = "(Optional) Conceptually, this is the range of IP addresses that a packet originating from the instance can go to."
  default     = null
}

variable "core_network_security_group_security_rule_destination_type" {
  description = "(Optional) Type of destination for the rule. Required if direction = EGRESS."
  default     = null
}

variable "core_network_security_group_security_rule_source" {
  description = "(Optional) Conceptually, this is the range of IP addresses that a packet coming into the instance can come from."
  default     = null
}

variable "core_network_security_group_security_rule_source_type" {
  description = "(Optional) Type of source for the rule. Required if direction = INGRESS."
  default     = null
}

variable "core_network_security_group_security_rule_stateless" {
  description = "(Optional) A stateless rule allows traffic in one direction. Remember to add a corresponding stateless rule in the other direction if you need to support bidirectional traffic. For example, if egress traffic allows TCP destination port 80, there should be an ingress rule to allow TCP source port 80. Defaults to false, which means the rule is stateful and a corresponding rule is not necessary for bidirectional traffic."
  default     = null
}

variable "core_network_security_group_security_rule_icmp_options" {
  description = "(Optional) Optional and valid only for ICMP and ICMPv6. Use to specify a particular ICMP type and code"
  default     = []
}

variable "core_network_security_group_security_rule_tcp_options" {
  description = "(Optional) Optional and valid only for TCP. Use to specify particular destination ports for TCP rules. If you specify TCP as the protocol but omit this object, then all destination ports are allowed."
  default     = []
}

variable "core_network_security_group_security_rule_udp_options" {
  description = "(Optional) Optional and valid only for UDP. Use to specify particular destination ports for UDP rules. If you specify UDP as the protocol but omit this object, then all destination ports are allowed."
  default     = null
}

variable "core_network_security_group_security_rule_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Network Security Group Security Rule * update - (Defaults to 20 minutes), when updating the Network Security Group Security Rule * delete - (Defaults to 20 minutes), when destroying the Network Security Group Security Rule"
  default     = {}
}