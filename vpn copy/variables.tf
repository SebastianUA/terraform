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
# AWS VPN gateway
#---------------------------------------------------------------
variable "enable_vpn_gateway" {
  description = "Should be true if you want to create a new VPN Gateway resource and attach it to the VPC"
  default     = false
}

variable "vpn_gateway_name" {
  description = "Set name for VPC GW"
  default     = ""
}

variable "vpn_gateway_vpc_id" {
  description = "(Optional) The VPC ID to create in."
  default     = null
}

variable "vpn_gateway_availability_zone" {
  description = "(Optional) The Availability Zone for the virtual private gateway."
  default     = null
}

variable "vpn_gateway_amazon_side_asn" {
  description = "(Optional) The Autonomous System Number (ASN) for the Amazon side of the gateway. If you don't specify an ASN, the virtual private gateway is created with the default ASN."
  default     = null
}

#---------------------------------------------------------------
# AWS VPN gateway attachment
#---------------------------------------------------------------
variable "enable_vpn_gateway_attachment" {
  description = "Enable vpn gateway attachment usage"
  default     = false
}

variable "vpn_gateway_attachment_vpc_id" {
  description = "(Required) The ID of the VPC."
  default     = ""
}

variable "vpn_gateway_attachment_vpn_gateway_id" {
  description = "(Required) The ID of the Virtual Private Gateway."
  default     = ""
}

#---------------------------------------------------------------
# AWS VPN gateway route propagation
#---------------------------------------------------------------
variable "enable_vpn_gateway_route_propagation" {
  description = "Enable vpn gateway route propagation usage"
  default     = false
}

variable "vpn_gateway_route_propagation_vpn_gateway_id" {
  description = "The id of the aws_vpn_gateway to propagate routes from."
  default     = ""
}

variable "vpn_gateway_route_propagation_route_table_id" {
  description = "The id of the aws_route_table to propagate routes into."
  default     = ""
}

variable "vpn_gateway_route_propagation_timeouts" {
  description = "Set timeouts for VPN gateway route propagation"
  default     = {}
}

#---------------------------------------------------
# AWS VPN connection
#---------------------------------------------------
variable "enable_vpn_connection" {
  description = "Enable vpn connection usage"
  default     = false
}

variable "vpn_connection_name" {
  description = "Set name for VPC vpn connection"
  default     = ""
}

variable "vpn_connection_customer_gateway_id" {
  description = "The ID of the customer gateway."
  default     = ""
}

variable "vpn_connection_type" {
  description = "(Required) The type of VPN connection. The only type AWS supports at this time is 'ipsec.1'."
  default     = "ipsec.1"
}

variable "vpn_connection_transit_gateway_id" {
  description = "(Optional) The ID of the EC2 Transit Gateway."
  default     = null
}

variable "vpn_connection_vpn_gateway_id" {
  description = "(Optional) The ID of the Virtual Private Gateway."
  default     = null
}

variable "vpn_connection_static_routes_only" {
  description = "(Optional, Default false) Whether the VPN connection uses static routes exclusively. Static routes must be used for devices that don't support BGP."
  default     = false
}

variable "vpn_connection_tunnel1_inside_cidr" {
  description = "(Optional) The CIDR block of the inside IP addresses for the first VPN tunnel."
  default     = null
}

variable "vpn_connection_tunnel2_inside_cidr" {
  description = "(Optional) The CIDR block of the inside IP addresses for the second VPN tunnel."
  default     = null
}

variable "vpn_connection_tunnel1_preshared_key" {
  description = "(Optional) The preshared key of the first VPN tunnel."
  default     = null
}

variable "vpn_connection_tunnel2_preshared_key" {
  description = "(Optional) The preshared key of the second VPN tunnel."
  default     = null
}

#---------------------------------------------------
# AWS VPN connection route
#---------------------------------------------------
variable "enable_vpn_connection_route" {
  description = "Enable vpn connection route usage"
  default     = false
}

variable "vpn_connection_route_cidr_block" {
  description = "(Required) The CIDR block associated with the local subnet of the customer network."
  default     = null
}

variable "vpn_connection_route_vpn_connection_id" {
  description = "The ID of the VPN connection."
  default     = ""
}

#---------------------------------------------------------------
# AWS customer gateway
#---------------------------------------------------------------
variable "enable_customer_gateway" {
  description = "Enable customer gateway usage"
  default     = false
}

variable "customer_gateway_name" {
  description = "Set name for VPC customer gateway"
  default     = ""
}

variable "customer_gateway_bgp_asn" {
  description = "(Required) The gateway's Border Gateway Protocol (BGP) Autonomous System Number (ASN)."
  default     = 65000
}

variable "customer_gateway_ip_address" {
  description = "(Required) The IP address of the gateway's Internet-routable external interface."
  default     = ""
}

variable "customer_gateway_type" {
  description = "(Required) The type of customer gateway. The only type AWS supports at this time is 'ipsec.1'."
  default     = "ipsec.1"
}