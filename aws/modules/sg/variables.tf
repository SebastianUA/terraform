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

variable "security_group_id" {
  description = "ID of existing security group whose rules we will manage"
  type        = string
  default     = null
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
  default     = {}
}

#---------------------------------------------------
# Security group rules
#---------------------------------------------------

# ingress
variable "enable_sg_rule_ingress_ports" {
  description = "Enable SG rule with ingress ports usage"
  default     = false
}

# egress
variable "enable_sg_rule_egress_ports" {
  description = "Enable SG rule with egress ports usage"
  default     = false
}

# Ingress all ports
variable "enable_sg_rule_ingress_ports_all" {
  description = "Enable SG rule with ingress to open all ports usage"
  default     = false
}

variable "ingress_ports_all_stack" {
  description = "Set list of the values for engress"
  default = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = -1
      cidr_blocks = ["0.0.0.0/0"]

      cidr_blocks              = null
      prefix_list_ids          = null
      ipv6_cidr_blocks         = null
      source_security_group_id = null
      self                     = null
      description              = null
    }
  ]
}

variable "ingress_rules" {
  description = <<EOF
  (Optional) The configuration for ingress rules of the security group. Each block of `ingress_rules` as defined below.
    (Required) `id` - The ID of the ingress rule. This value is only used internally within Terraform code.
    (Optional) `description` - The description of the rule.
    (Required) `protocol` - The protocol to match. Note that if `protocol` is set to `-1`, it translates to all protocols, all port ranges, and `from_port` and `to_port` values should not be defined.
    (Required) `from_port` - The start of port range for the TCP and UDP protocols, or an ICMP/ICMPv6 type.
    (Required) `to_port` - The end of port range for the TCP and UDP protocols, or an ICMP/ICMPv6 code.
    (Optional) `ipv4_cidrs` - The IPv4 network ranges to allow, in CIDR notation.
    (Optional) `ipv6_cidrs` - The IPv6 network ranges to allow, in CIDR notation.
    (Optional) `prefix_lists` - The prefix list IDs to allow.
    (Optional) `security_groups` - The source security group IDs to allow.
    (Optional) `self` - Whether the security group itself will be added as a source to this ingress rule.
  EOF
  type = list(object({
    id              = string
    description     = optional(string, "Managed by Terraform.")
    protocol        = string
    from_port       = number
    to_port         = number
    ipv4_cidrs      = optional(list(string), [])
    ipv6_cidrs      = optional(list(string), [])
    prefix_lists    = optional(list(string), [])
    security_groups = optional(list(string), [])
    self            = optional(bool, false)
  }))
  default  = []
  nullable = false

  validation {
    condition = alltrue([
      for rule in var.ingress_rules :
      anytrue([
        length(rule.ipv4_cidrs) > 0,
        length(rule.ipv6_cidrs) > 0,
        length(rule.prefix_lists) > 0,
        length(rule.security_groups) > 0,
        rule.self,
      ])
    ])
    error_message = "At least one of `ipv4_cidrs`, `ipv6_cidrs`, `prefix_lists`, `security_groups` or `self` must be specified."
  }
}

# Egress all ports
variable "enable_sg_rule_egress_ports_all" {
  description = "Enable SG rule with egress to open all ports usage"
  default     = false
}

variable "egress_ports_all_stack" {
  description = "Set list of the values for engress"
  default = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = -1
      cidr_blocks = ["0.0.0.0/0"]

      cidr_blocks              = null
      prefix_list_ids          = null
      ipv6_cidr_blocks         = null
      source_security_group_id = null
      self                     = null
      description              = null
    }
  ]
}

variable "egress_rules" {
  description = <<EOF
  (Optional) The configuration for egress rules of the security group. Each block of `egress_rules` as defined below.
    (Required) `id` - The ID of the egress rule. This value is only used internally within Terraform code.
    (Optional) `description` - The description of the rule.
    (Required) `protocol` - The protocol to match. Note that if `protocol` is set to `-1`, it translates to all protocols, all port ranges, and `from_port` and `to_port` values should not be defined.
    (Required) `from_port` - The start of port range for the TCP and UDP protocols, or an ICMP/ICMPv6 type.
    (Required) `to_port` - The end of port range for the TCP and UDP protocols, or an ICMP/ICMPv6 code.
    (Optional) `ipv4_cidrs` - The IPv4 network ranges to allow, in CIDR notation.
    (Optional) `ipv6_cidrs` - The IPv6 network ranges to allow, in CIDR notation.
    (Optional) `prefix_lists` - The prefix list IDs to allow.
    (Optional) `security_groups` - The source security group IDs to allow.
    (Optional) `self` - Whether the security group itself will be added as a source to this ingress rule.
  EOF
  type = list(object({
    id              = string
    description     = optional(string, "Managed by Terraform.")
    protocol        = string
    from_port       = number
    to_port         = number
    ipv4_cidrs      = optional(list(string), [])
    ipv6_cidrs      = optional(list(string), [])
    prefix_lists    = optional(list(string), [])
    security_groups = optional(list(string), [])
    self            = optional(bool, false)
  }))
  default  = []
  nullable = false

  validation {
    condition = alltrue([
      for rule in var.egress_rules :
      anytrue([
        length(rule.ipv4_cidrs) > 0,
        length(rule.ipv6_cidrs) > 0,
        length(rule.prefix_lists) > 0,
        length(rule.security_groups) > 0,
        rule.self,
      ])
    ])
    error_message = "At least one of `ipv4_cidrs`, `ipv6_cidrs`, `prefix_lists`, `security_groups` or `self` must be specified."
  }
}

#---------------------------------------------------
# AWS security group (default)
#---------------------------------------------------
variable "enable_default_security_group" {
  description = "Enable default security group usage"
  default     = false
}

variable "default_security_group_name" {
  description = "Set name for default SG"
  default     = ""
}

variable "default_security_group_vpc_id" {
  description = "(Optional, Forces new resource) VPC ID. Note that changing the vpc_id will not restore any default security group rules that were modified, added, or removed. It will be left in its current state."
  default     = ""
}

variable "default_security_group_ingress" {
  description = "(Optional) Configuration block."
  default = {
    protocol  = -1
    from_port = 0
    to_port   = 0

    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    description      = "Default Inbound rules"
    prefix_list_ids  = null
    security_groups  = null
    self             = null
  }
}

variable "default_security_group_egress" {
  description = "(Optional, VPC only) Configuration block. "
  default = {
    protocol  = -1
    from_port = 0
    to_port   = 0

    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    description      = "Default Outbound rules"
    prefix_list_ids  = null
    security_groups  = null
    self             = null
  }
}
