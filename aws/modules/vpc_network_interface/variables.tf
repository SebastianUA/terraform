#---------------------------------------------------------------
# Global or/and default variables
#---------------------------------------------------------------
variable "name" {
    description = "Name to be used on all resources as prefix"
    default     = "TEST"
}

variable "region" {
  description = "The region where to deploy this code (e.g. us-east-1)."
  default     = "us-east-1"
}

variable "environment" {
    description = "Environment for service"
    default     = "STAGE"
}

variable "tags" {
    description = "A list of tag blocks. Each element should have keys named key, value, etc."
    type        = map(string)
    default     = {}
}

#---------------------------------------------------------------
# AWS VPC network interface
#---------------------------------------------------------------
variable "enable_network_interface" {
    description   = "Enable VPC network interface usage"
    default       = false
}

variable "network_interface_name" {
    description = "Set name for VPC network interface"
    default     = ""
}

variable "network_interface_subnet_id" {
  description   = "(Required) Subnet ID to create the ENI in."
  default       = ""
}

variable "network_interface_description" {
  description   = "(Optional) A description for the network interface."
  default       = null
}

variable "network_interface_private_ips" {
  description   = "(Optional) List of private IPs to assign to the ENI."
  default       = null
}

variable "network_interface_private_ips_count" {
  description   = "(Optional) Number of secondary private IPs to assign to the ENI. The total number of private IPs will be 1 + private_ips_count, as a primary private IP will be assiged to an ENI by default."
  default       = null
}

variable "network_interface_security_groups" {
  description   = "(Optional) List of security group IDs to assign to the ENI."
  default       = null
}

variable "network_interface_source_dest_check" {
  description   = "(Optional) Whether to enable source destination checking for the ENI. Default true."
  default       = true
}

variable "network_interface_attachment" {
  description   = "(Optional) Block to define the attachment of the ENI."
  default       = []
}

#---------------------------------------------------
# AWS VPC network interface sg attachment
#---------------------------------------------------
variable "enable_network_interface_sg_attachment" {
  description   = "Enable Elastic network interface SG attachment usage"
  default       = false
}

variable "network_interface_sg_attachment_security_group_id" {
  description   = "(Required) The ID of the security group."
  default       = ""
}

variable "network_interface_sg_attachment_network_interface_id" {
  description   = "(Required) The ID of the network interface to attach to."
  default       = ""
}

#---------------------------------------------------
# AWS VPC network interface attachment
#---------------------------------------------------
variable "enable_network_interface_attachment" {
  description   = "Enable network interface attachment usage"
  default       = false
}

variable "network_interface_attachment_instance_id" {
  description   = "(Required) Instance ID to attach."
  default       = ""
}

variable "network_interface_attachment_network_interface_id" {
  description   = "ENI ID to attach."
  default       = ""
}

variable "network_interface_attachment_device_index" {
  description   = "(Required) Network interface index (int)."
  default       = 2
}
