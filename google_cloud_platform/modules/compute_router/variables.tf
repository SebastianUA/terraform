variable "name" {
    description = "A unique name for the resource, required by GCE. Changing this forces a new resource to be created."
    default     = "TEST"
}

variable "environment" {
    description = "Environment for service"
    default     = "STAGE"
}

variable "network" {
    description = "(Required) A reference to the network to which this router belongs."
    default     = "default"
}

variable "description" {
    description = "(Optional) An optional description of this resource."
    default     = ""
}

variable "region" {
    description = "(Optional) Region where the router resides."
    default     = ""
}

variable "project" {
    description = "(Optional) The ID of the project in which the resource belongs. If it is not provided, the provider project is used."
    default     = ""
}

variable "enable_compute_router" {
    description = "Enable compute router usage"
    default     = "true"
}

variable "bgp_asn" {
    description = "(Required) Local BGP Autonomous System Number (ASN). Must be an RFC6996 private ASN, either 16-bit or 32-bit. The value will be fixed for this router resource. All VPN tunnels that link to this router will have the same local ASN."
    default     = "64514"
}

variable "bgp_advertise_mode" {
    description = "(Optional) User-specified flag to indicate which mode to use for advertisement. Valid values of this enum field are: DEFAULT, CUSTOM"
    default     = "DEFAULT"
}

variable "timeouts_create" {
    description = "Time to create. Default is 4 minutes. Valid units of time are s, m, h."
    default     = "4m"
}

variable "timeouts_update" {
    description = "Time to update. Default is 4 minutes. Valid units of time are s, m, h."
    default     = "4m"
}

variable "timeouts_delete" {
    description = "Time to delete. Default is 4 minutes. Valid units of time are s, m, h."
    default     = "4m"
}

variable "bgp" {
    description = " (Optional) BGP information specific to this router."
    default     = []
}

variable "enable_compute_router_interface" {
    description = "Enable compute router interface usage"
    default     = "false"
}

variable "router" {
    description = "(Required) The name of the router this interface will be attached to. Changing this forces a new interface to be created."
    default     = ""
}

variable "vpn_tunnel" {
    description = "(Required) The name or resource link to the VPN tunnel this interface will be linked to. Changing this forces a new interface to be created."
    default     = ""
}

variable "ip_range" {
    description = "(Optional) IP address and range of the interface. The IP range must be in the RFC3927 link-local IP space. Changing this forces a new interface to be created."
    default     = ""
}

variable "enable_compute_router_peer" {
    description = "Enable compute router peer usage"
    default     = "false"
}

variable "peer_ip_address" {
    description = "(Required) IP address of the BGP interface outside Google Cloud. Changing this forces a new peer to be created."
    default     = ""
}

variable "peer_asn" {
    description = "(Required) Peer BGP Autonomous System Number (ASN). Changing this forces a new peer to be created."
    default     = "65513"
}

variable "advertised_route_priority" {
    description = "(Optional) The priority of routes advertised to this BGP peer. Changing this forces a new peer to be created."
    default     = "100"
}

variable "interface" {
    description = "(Required) The name of the interface the BGP peer is associated with. Changing this forces a new peer to be created."
    default     = ""
}

