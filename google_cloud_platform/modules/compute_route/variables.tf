variable "name" {
    description = "A unique name for the resource, required by GCE. Changing this forces a new resource to be created."
    default     = "TEST"
}

variable "environment" {
    description = "Environment for service"
    default     = "STAGE"
}

variable "project" {
    description = "The project in which the resource belongs. If it is not provided, the provider project is used."
    default     = ""
}

variable "network" {
    description = "The name or self_link of the network to attach this firewall to."
    default     = "default"
}

variable "enable_compute_route" {
    description = "Enable compute route usage"
    default     = "true"
}

variable "timeouts_create" {
    description = "Time to create. Default is 4 minutes. Valid units of time are s, m, h."
    default     = "4m"
}

variable "timeouts_delete" {
    description = "Time to delete. Default is 4 minutes. Valid units of time are s, m, h."
    default     = "4m"
}

variable "description" {
    description = "(Optional) An optional description of this resource. Provide this property when you create the resource."
    default     = ""
}

variable "dest_range" {
    description = "(Required) The destination range of outgoing packets that this route applies to. Only IPv4 is supported."
    default     = ""
}

variable "next_hop_ip" {
    description = "(Optional) Network IP address of an instance that should handle matching packets."
    default     = ""
}

variable "priority" {
    description = "(Optional) The priority of this route. Priority is used to break ties in cases where there is more than one matching route of equal prefix length. In the case of two routes with equal prefix length, the one with the lowest-numbered priority value wins. Default value is 1000. Valid range is 0 through 65535."
    default     = "1000"
}

variable "next_hop_gateway" {
    description = "Optional) URL to a gateway that should handle matching packets. Currently, you can only specify the internet gateway, using a full or partial valid URL: https://www.googleapis.com/compute/v1/projects/project/global/gateways/default-internet-gateway or projects/project/global/gateways/default-internet-gateway or global/gateways/default-internet-gateway or The string default-internet-gateway."
    default     = ""
}

variable "next_hop_instance" {
    description = "(Optional) URL to an instance that should handle matching packets. You can specify this as a full or partial URL. For example: https://www.googleapis.com/compute/v1/projects/project/zones/zone/instances/instance or projects/project/zones/zone/instances/instance or zones/zone/instances/instance or Just the instance name, with the zone in next_hop_instance_zone."
    default     = ""
}

variable "next_hop_vpn_tunnel" {
    description = "(Optional) URL to a VpnTunnel that should handle matching packets."
    default     = ""
}

variable "next_hop_instance_zone" {
    description = "(Optional when next_hop_instance is specified) The zone of the instance specified in next_hop_instance. Omit if next_hop_instance is specified as a URL."
    default     = ""
}
