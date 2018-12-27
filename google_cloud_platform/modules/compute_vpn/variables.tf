variable "name" {
    description = "A unique name for the resource, required by GCE. Changing this forces a new resource to be created."
    default     = "TEST"
}

variable "environment" {
    description = "Environment for service"
    default     = "STAGE"
}

variable "orchestration" {
    description = "Type of orchestration"
    default     = "Terraform"
}

variable "project" {
    description = "The project in which the resource belongs. If it is not provided, the provider project is used."
    default     = ""
}

variable "enable_compute_vpn_gateway" {
    description = "Enable compute vpn gateway usage"
    default     = "false"
}

variable "network" {
    description = "(Required) The network this VPN gateway is accepting traffic for."
    default     = ""
}

variable "region" {
    description = "(Optional) The region this gateway should sit in."
    default     = ""
}

variable "description" {
    description = "(Optional) An optional description of this resource."
    default     = ""
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

variable "enable_compute_vpn_tunnel" {
    description = "Enable compute vpn tunnel usage"
    default     = "false"
}

variable "target_vpn_gateway" {
    description = "(Required) URL of the Target VPN gateway with which this VPN tunnel is associated."
    default     = ""
}

variable "peer_ip" {
    description = "(Required) IP address of the peer VPN gateway. Only IPv4 is supported."
    default     = ""
}

variable "shared_secret" {
    description = "(Required) Shared secret used to set the secure session between the Cloud VPN gateway and the peer VPN gateway."
    default     = ""
}

variable "remote_traffic_selector" {
    description = "(Optional) Remote traffic selector to use when establishing the VPN tunnel with peer VPN gateway. The value should be a CIDR formatted string, for example 192.168.0.0/16. The ranges should be disjoint. Only IPv4 is supported."
    default     = []
}

variable "local_traffic_selector" {
    description = "(Optional) Local traffic selector to use when establishing the VPN tunnel with peer VPN gateway. The value should be a CIDR formatted string, for example 192.168.0.0/16. The ranges should be disjoint. Only IPv4 is supported."
    default     = []
}

variable "ike_version" {
    description = "(Optional) IKE protocol version to use when establishing the VPN tunnel with peer VPN gateway. Acceptable IKE versions are 1 or 2. Default version is 2."
    default     = "2"
}

variable "router" {
    description = "(Optional) URL of router resource to be used for dynamic routing."
    default     = ""
}
