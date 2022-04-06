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

#---------------------------------------------------
# AWS VPC peering connection
#---------------------------------------------------
variable "enable_vpc_peering_connection" {
  description = "Enable VPC peering usage"
  default     = false
}

variable "vpc_peering_connection_name" {
  description = "Set name for VPC peering connection"
  default     = ""
}

variable "vpc_peering_connection_vpc_id" {
  description = "Set vpc_id for peering connection"
  default     = ""
}

variable "vpc_peering_connection_peer_vpc_id" {
  description = "(Required) The ID of the VPC with which you are creating the VPC Peering Connection."
  default     = null
}

variable "vpc_peering_connection_peer_owner_id" {
  description = "(Optional) The AWS account ID of the owner of the peer VPC. Defaults to the account ID the AWS provider is currently connected to."
  default     = null
}

variable "vpc_peering_connection_auto_accept" {
  description = "(Optional) Accept the peering (both VPCs need to be in the same AWS account)."
  default     = null
}

variable "vpc_peering_connection_peer_region" {
  description = "(Optional) The region of the accepter VPC of the [VPC Peering Connection]. auto_accept must be false, and use the aws_vpc_peering_connection_accepter to manage the accepter side."
  default     = null
}

variable "vpc_peering_connection_accepter" {
  description = "(Optional) - An optional configuration block that allows for [VPC Peering Connection] (https://docs.aws.amazon.com/vpc/latest/peering/what-is-vpc-peering.html) options to be set for the VPC that accepts the peering connection (a maximum of one)."
  default     = {}
}

variable "vpc_peering_connection_requester" {
  description = "(Optional) - A optional configuration block that allows for [VPC Peering Connection] (https://docs.aws.amazon.com/vpc/latest/peering/what-is-vpc-peering.html) options to be set for the VPC that requests the peering connection (a maximum of one)."
  default     = {}
}

variable "vpc_peering_connection_timeouts" {
  description = "Set timeouts used for creating a peering connection"
  default     = {}
}

#---------------------------------------------------
# AWS VPC peering connection options
#---------------------------------------------------
variable "enable_vpc_peering_connection_options" {
  description = "Enable VPC peering connection options usage"
  default     = false
}

variable "vpc_peering_connection_options_vpc_peering_connection_id" {
  description = "The ID of the requester VPC peering connection."
  default     = ""
}

variable "vpc_peering_connection_options_accepter" {
  description = "(Optional) - An optional configuration block that allows for [VPC Peering Connection] (https://docs.aws.amazon.com/vpc/latest/peering/what-is-vpc-peering.html) options to be set for the VPC that accepts the peering connection (a maximum of one)."
  default     = {}
}

variable "vpc_peering_connection_options_requester" {
  description = "(Optional) - A optional configuration block that allows for [VPC Peering Connection] (https://docs.aws.amazon.com/vpc/latest/peering/what-is-vpc-peering.html) options to be set for the VPC that requests the peering connection (a maximum of one)."
  default     = {}
}

#---------------------------------------------------
# AWS VPC peering connection accepter
#---------------------------------------------------
variable "enable_vpc_peering_connection_accepter" {
  description = "Enable VPC endpoint usage"
  default     = false
}

variable "vpc_peering_connection_accepter_name" {
  description = "Set name for VPC peering connection accepter"
  default     = ""
}

variable "vpc_peering_connection_accepter_vpc_peering_connection_id" {
  description = "(Optional) Whether or not to accept the peering request. Defaults to false."
  default     = false
}

variable "vpc_peering_connection_accepter_auto_accept" {
  description = "(Optional) Whether or not to accept the peering request. Defaults to false."
  default     = false
}
