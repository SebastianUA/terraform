#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST"
}

variable "environment" {
  description = "Environment for service"
  default     = "STAGE"
}

variable "tags" {
  description = "A list of tag blocks."
  type        = map(string)
  default     = {}
}

#---------------------------------------------------------------
# Security group's variables
#---------------------------------------------------------------
variable "enable_security_group" {
  description = "Enable SG usage"
  default     = false
}

variable "security_group_name" {
  description = "(Optional, Forces new resource) The name of the security group. If omitted, Terraform will assign a random, unique name"
  default     = ""
}

variable "security_group_name_prefix" {
  description = "(Optional, Forces new resource) Creates a unique name beginning with the specified prefix. Conflicts with security_group_name."
  default     = ""
}

variable "security_group_description" {
  description = "(Optional, Forces new resource) The security group description. Defaults to 'Managed by Terraform'. Cannot be ''. NOTE: This field maps to the AWS GroupDescription attribute, for which there is no Update API. If you'd like to classify your security groups in a way that can be updated, use tags."
  default     = "Managed by Terraform"
}

variable "security_group_vpc_id" {
  description = "(Optional, Forces new resource) The VPC ID."
  default     = null
}

variable "security_group_revoke_rules_on_delete" {
  description = "(Optional) Instruct Terraform to revoke all of the Security Groups attached ingress and egress rules before deleting the rule itself. This is normally not needed, however certain AWS services such as Elastic Map Reduce may automatically add required rules to security groups used with the service, and those rules may contain a cyclic dependency that prevent the security groups from being destroyed without removing the dependency first. Default false"
  default     = false
}

variable "security_group_ingress" {
  description = "(Optional) Can be specified multiple times for each ingress rule. Each ingress block supports fields documented below. This argument is processed in attribute-as-blocks mode."
  default     = []
}

variable "security_group_egress" {
  description = "(Optional, VPC only) Can be specified multiple times for each egress rule. Each egress block supports fields documented below. This argument is processed in attribute-as-blocks mode."
  default     = []
}

variable "security_group_timeouts" {
  description = "(Optional, allowing add custom timeouts for VPC"
  default     = []
}

#---------------------------------------------------
# Security group rules
#---------------------------------------------------
variable "security_group_id" {
  description = "The security group to apply this rule to."
  default     = ""
}

variable "allowed_ports" {
  description = "Allowed ports from/to host"
  default     = []
}

variable "cidr_blocks" {
  description = "(Optional) List of CIDR blocks. Cannot be specified with source_security_group_id."
  default     = null
  #{
  #80        = ["0.0.0.0/0"]
  #443       = ["0.0.0.0/0"]
  #}
}

# ingress
variable "enable_sg_rule_ingress_ports" {
  description = "Enable SG rule with ingress ports usage"
  default     = false
}

variable "ingress_ports_from_port" {
  description = "The start port (or ICMP type number if protocol is 'icmp' or 'icmpv6')."
  default     = null
}

variable "ingress_ports_to_port" {
  description = "The end port (or ICMP code if protocol is 'icmp')."
  default     = null
}

variable "ingress_ports_protocol" {
  description = "(Required) The protocol. If not icmp, icmpv6, tcp, udp, or all use the protocol number"
  default     = "tcp"
}

variable "ingress_ports_ipv6_cidr_blocks" {
  description = "(Optional) List of IPv6 CIDR blocks."
  default     = null
}

variable "ingress_ports_source_security_group_id" {
  description = "(Optional) The security group id to allow access to/from, depending on the type. Cannot be specified with ingress_ports_ipv6_cidr_blocks and ingress_ports_self."
  default     = null
}

variable "ingress_ports_self" {
  description = "(Optional) If true, the security group itself will be added as a source to this ingress rule. Cannot be specified with ingress_ports_source_security_group_id."
  default     = null
}

variable "ingress_ports_description" {
  description = "(Optional) Description of the rule."
  default     = null
}

# egress
variable "enable_sg_rule_egress_ports" {
  description = "Enable SG rule with egress ports usage"
  default     = false
}

variable "egress_ports_from_port" {
  description = "The start port (or ICMP type number if protocol is 'icmp' or 'icmpv6')."
  default     = null
}

variable "egress_ports_to_port" {
  description = "The end port (or ICMP code if protocol is 'icmp')."
  default     = null
}

variable "egress_ports_protocol" {
  description = "(Required) The protocol. If not icmp, icmpv6, tcp, udp, or all use the protocol number"
  default     = "tcp"
}

variable "egress_ports_ipv6_cidr_blocks" {
  description = "(Optional) List of IPv6 CIDR blocks."
  default     = null
}

variable "egress_ports_source_security_group_id" {
  description = "(Optional) The security group id to allow access to/from, depending on the type. Cannot be specified with egress_ports_ipv6_cidr_blocks and egress_ports_self."
  default     = null
}

variable "egress_ports_self" {
  description = "(Optional) If true, the security group itself will be added as a source to this ingress rule. Cannot be specified with egress_ports_source_security_group_id."
  default     = null
}

variable "egress_ports_description" {
  description = "(Optional) Description of the rule."
  default     = null
}

# custom
variable "enable_sg_rule_custom_ports" {
  description = "Enable SG rule for custom ports usage"
  default     = false
}

variable "custom_ports_type" {
  description = "(Required) The type of rule being created. Valid options are ingress (inbound) or egress (outbound)."
  default     = "ingress"
}

variable "custom_ports_from_port" {
  description = "(Required) The start port (or ICMP type number if protocol is 'icmp' or 'icmpv6')."
  default     = -1
}

variable "custom_ports_to_port" {
  description = "(Required) The end port (or ICMP code if protocol is 'icmp')."
  default     = -1
}

variable "custom_ports_protocol" {
  description = "(Required) The protocol. If not icmp, icmpv6, tcp, udp, or all use the protocol number"
  default     = "icmp"
}

variable "custom_ports_cidr_blocks" {
  description = "(Optional) List of CIDR blocks. Cannot be specified with custom_ports_source_security_group_id."
  default     = null
}


variable "custom_ports_ipv6_cidr_blocks" {
  description = "(Optional) List of IPv6 CIDR blocks."
  default     = null
}

variable "custom_ports_source_security_group_id" {
  description = "(Optional) The security group id to allow access to/from, depending on the type. Cannot be specified with custom_ports_ipv6_cidr_blocks and custom_ports_self."
  default     = null
}

variable "custom_ports_self" {
  description = "(Optional) If true, the security group itself will be added as a source to this ingress rule. Cannot be specified with custom_ports_source_security_group_id."
  default     = null
}

variable "custom_ports_description" {
  description = "(Optional) Description of the rule."
  default     = null
}

# Ingress all ports
variable "enable_sg_rule_ingress_ports_all" {
  description = "Enable SG rule with ingress to open all ports usage"
  default     = false
}

# Egress all ports
variable "enable_sg_rule_egress_ports_all" {
  description = "Enable SG rule with egress to open all ports usage"
  default     = false
}
