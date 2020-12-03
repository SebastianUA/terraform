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
  description = "A list of tag blocks. Each element should have keys named key, value, etc."
  type        = map(string)
  default     = {}
}

#---------------------------------------------------
# AWS EC2 transit gateway
#---------------------------------------------------
variable "enable_transit_gateway" {
  description = "Enable transit gateway"
  default     = false
}

variable "transit_gateway_name" {
  description = "Set name for TGW"
  default     = ""
}

variable "transit_gateway_amazon_side_asn" {
  description = "(Optional) Private Autonomous System Number (ASN) for the Amazon side of a BGP session. The range is 64512 to 65534 for 16-bit ASNs and 4200000000 to 4294967294 for 32-bit ASNs. Default value: 64512."
  default     = 64512
}

variable "transit_gateway_auto_accept_shared_attachments" {
  description = "(Optional) Whether resource attachment requests are automatically accepted. Valid values: disable, enable. Default value: disable"
  default     = "disable"
}

variable "transit_gateway_default_route_table_association" {
  description = "(Optional) Whether resource attachments are automatically associated with the default association route table. Valid values: disable, enable. Default value: enable"
  default     = "enable"
}

variable "transit_gateway_default_route_table_propagation" {
  description = "(Optional) Whether resource attachments automatically propagate routes to the default propagation route table. Valid values: disable, enable. Default value: enable"
  default     = "enable"
}

variable "transit_gateway_description" {
  description = "(Optional) Description of the EC2 Transit Gateway."
  default     = null
}

variable "transit_gateway_dns_support" {
  description = "(Optional) Whether DNS support is enabled. Valid values: disable, enable. Default value: enable"
  default     = "enable"
}

variable "transit_gateway_vpn_ecmp_support" {
  description = "(Optional) Whether VPN Equal Cost Multipath Protocol support is enabled. Valid values: disable, enable. Default value: enable"
  default     = "enable"
}

#---------------------------------------------------
# AWS EC2 transit gateway vpc attachment
#---------------------------------------------------
variable "enable_transit_gateway_vpc_attachment" {
  description = "Enable TGW vpc attachment usage"
  default     = false
}

variable "transit_gateway_vpc_attachment_name" {
  description = "Set name for TGW VPC attachment"
  default     = ""
}

variable "transit_gateway_vpc_attachment_subnet_ids" {
  description = "(Required) Identifiers of EC2 Subnets."
  default     = []
}

variable "transit_gateway_vpc_attachment_transit_gateway_id" {
  description = "Identifier of EC2 Transit Gateway."
  default     = ""
}

variable "transit_gateway_vpc_attachment_vpc_id" {
  description = "(Required) Identifier of EC2 VPC."
  default     = ""
}

variable "transit_gateway_vpc_attachment_appliance_mode_support" {
  description = "(Optional) Whether Appliance Mode support is enabled. If enabled, a traffic flow between a source and destination uses the same Availability Zone for the VPC attachment for the lifetime of that flow. Valid values: disable, enable. Default value: disable."
  default     = "disable"
}

variable "transit_gateway_vpc_attachment_dns_support" {
  description = "(Optional) Whether DNS support is enabled. Valid values: disable, enable. Default value: enable."
  default     = "enable"
}

variable "transit_gateway_vpc_attachment_ipv6_support" {
  description = "(Optional) Whether IPv6 support is enabled. Valid values: disable, enable. Default value: disable."
  default     = "disable"
}

variable "transit_gateway_vpc_attachment_transit_gateway_default_route_table_association" {
  description = "(Optional) Boolean whether the VPC Attachment should be associated with the EC2 Transit Gateway association default route table. This cannot be configured or perform drift detection with Resource Access Manager shared EC2 Transit Gateways. Default value: true"
  default     = true
}

variable "transit_gateway_vpc_attachment_transit_gateway_default_route_table_propagation" {
  description = "(Optional) Boolean whether the VPC Attachment should propagate routes with the EC2 Transit Gateway propagation default route table. This cannot be configured or perform drift detection with Resource Access Manager shared EC2 Transit Gateways. Default value: true"
  default     = true
}

#---------------------------------------------------
# AWS EC2 transit gateway vpc attachment accepter
#---------------------------------------------------
variable "enable_transit_gateway_vpc_attachment_accepter" {
  description = "Enable TGW vpc attachment accepter usage"
  default     = false
}

variable "transit_gateway_vpc_attachment_accepter_name" {
  description = "Set name for TGW VPC attachment acceper"
  default     = ""
}

variable "transit_gateway_vpc_attachment_accepter_transit_gateway_attachment_id" {
  description = "The ID of the EC2 Transit Gateway Attachment to manage."
  default     = ""
}

variable "transit_gateway_vpc_attachment_accepter_transit_gateway_default_route_table_association" {
  description = "(Optional) Boolean whether the VPC Attachment should be associated with the EC2 Transit Gateway association default route table. Default value: true."
  default     = true
}

variable "transit_gateway_vpc_attachment_accepter_transit_gateway_default_route_table_propagation" {
  description = "(Optional) Boolean whether the VPC Attachment should propagate routes with the EC2 Transit Gateway propagation default route table. Default value: true."
  default     = true
}

#---------------------------------------------------
# AWS EC2 transit gateway route table
#---------------------------------------------------
variable "enable_transit_gateway_route_table" {
  description = "Enable TGW route table usage"
  default     = false
}

variable "transit_gateway_route_table_name" {
  description = "Set name for TGV route table"
  default     = ""
}

variable "transit_gateway_route_table_transit_gateway_id" {
  description = "Set an identifier of EC2 Transit Gateway."
  default     = ""
}

#---------------------------------------------------
# AWS EC2 transit gateway route
#---------------------------------------------------
variable "enable_transit_gateway_route" {
  description = "Enable TGW route usage"
  default     = false
}

variable "transit_gateway_route_destination_cidr_blocks" {
  description = "(Required) IPv4 or IPv6 RFC1924 CIDR list used for destination matches. Routing decisions are based on the most specific match."
  default     = ["0.0.0.0/0"]
}

variable "transit_gateway_route_transit_gateway_route_table_id" {
  description = "Set an identifier of EC2 Transit Gateway Route Table."
  default     = ""
}

variable "transit_gateway_route_transit_gateway_attachment_id" {
  description = "(Optional) Identifier of EC2 Transit Gateway Attachment (required if blackhole is set to false)."
  default     = ""
}

variable "transit_gateway_route_blackhole" {
  description = "(Optional) Indicates whether to drop traffic that matches this route (default to false)."
  default     = false
}

#---------------------------------------------------
# AWS EC2 transit gateway route table propagation
#---------------------------------------------------
variable "enable_transit_gateway_route_table_propagation" {
  description = "Enable TGE route table propagation usage"
  default     = false
}

variable "transit_gateway_route_table_propagation_transit_gateway_attachment_id" {
  description = "Set an identifier of EC2 Transit Gateway Attachment."
  default     = ""
}

variable "transit_gateway_route_table_propagation_transit_gateway_route_table_id" {
  description = "Set an identifier of EC2 Transit Gateway Route Table."
  default     = ""
}

#---------------------------------------------------
# AWS EC2 transit gateway route table association
#---------------------------------------------------
variable "enable_transit_gateway_route_table_association" {
  description = "Enable TGW route table association usage"
  default     = false
}

variable "transit_gateway_route_table_association_transit_gateway_attachment_id" {
  description = "Set an identifier of EC2 Transit Gateway Attachment."
  default     = ""
}

variable "transit_gateway_route_table_association_transit_gateway_route_table_id" {
  description = "Set an identifier of EC2 Transit Gateway Route Table."
  default     = ""
}

#---------------------------------------------------
# AWS EC2 transit gateway peering attachment
#---------------------------------------------------
variable "enable_transit_gateway_peering_attachment" {
  description = "Enable TGW peering attachment usage"
  default     = false
}

variable "transit_gateway_peering_attachment_peer_account_id" {
  description = "(Optional) Account ID of EC2 Transit Gateway to peer with. Defaults to the account ID the AWS provider is currently connected to."
  default     = null
}

variable "transit_gateway_peering_attachment_peer_transit_gateway_id" {
  description = "Set an identifier of EC2 Transit Gateway to peer with."
  default     = ""
}

variable "transit_gateway_peering_attachment_name" {
  description = "Set name for TGW peering attachment"
  default     = ""
}

variable "transit_gateway_peering_attachment_peer_region" {
  description = "(Required) Region of EC2 Transit Gateway to peer with."
  default     = null
}

variable "transit_gateway_peering_attachment_transit_gateway_id" {
  description = "(Required) Identifier of EC2 Transit Gateway."
  default     = null
}

#---------------------------------------------------
# AWS EC2 transit gateway peering attachment accepter
#---------------------------------------------------
variable "enable_transit_gateway_peering_attachment_accepter" {
  description = "Enable TGW peering attachment accepter usage"
  default     = false
}

variable "transit_gateway_peering_attachment_accepter_name" {
  description = "Set name for TGW peering attachment accepter"
  default     = ""
}

variable "transit_gateway_peering_attachment_accepter_transit_gateway_attachment_id" {
  description = "The ID of the EC2 Transit Gateway Peering Attachment to manage."
  default     = ""
}
