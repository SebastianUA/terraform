#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST-SG"
}

variable "environment" {
    description = "Environment for service"
    default     = "STAGE"
}

variable "orchestration" {
    description = "Type of orchestration"
    default     = "Terraform"
}

variable "createdby" {
    description = "Created by"
    default     = "Vitaliy Natarov"
}
#---------------------------------------------------------------
# VPC variables
#---------------------------------------------------------------
variable "vpc_id" {
    description = "VPC ID"
    default     = ""
}
#---------------------------------------------------------------
# Security group's variables
#---------------------------------------------------------------
variable "enable_sg_creating" {
    description = "Enable to create SG for VPC"
    default     = true
}

variable "allowed_ports" {
    description = "Allowed ports from/to host"
    type        = "list"
    default     = []
}

variable "allow_cidrs_for_allowed_ports" {
    description = "Set allowed cidrs for allowed_ports"
    type        = "map"
    default     = {
        "80"        = ["0.0.0.0/0"]
        "443"       = ["0.0.0.0/0"]
    }
}

variable "enable_all_egress_ports" {
    description = "Allows all ports from host"
    default     = false
}

variable "enable_custom_sg_rule_with_cidr_blocks" {
    description = "Allows create a custom sg rule with cidr_blocks usage"
    default     = false
}

variable "enable_custom_sg_rule_with_self" {
    description = "Allows create a custom sg rule with self usage"
    default     = false
}

variable "sg_rule_type" {
    description = ""
    default     = "ingress"
}

variable "sg_rule_from_port" {
    description = ""
    default     = "0"
}

variable "sg_rule_to_port" {
    description = ""
    default     = "0"
}

variable "sg_rule_protocol" {
    description = ""
    default     = "-1"
}

variable "sg_rule_cidr_blocks" {
    description = ""
    default     =["0.0.0.0/0"]
}
