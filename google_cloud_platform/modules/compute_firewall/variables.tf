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

variable "description" {
    description = "Textual description field."
    default     = ""
}

variable "priority" {
    description = "The priority for this firewall. Ranges from 0-65535, inclusive. Defaults to 1000. Firewall resources with lower priority values have higher precedence (e.g. a firewall resource with a priority value of 0 takes effect over all other firewall rules with a non-zero priority)."
    default     = "1000"
}

variable "source_ranges" {
    description = "A list of source CIDR ranges that this firewall applies to. Can't be used for EGRESS."
    default     = []
}

variable "source_tags" {
    description = "A list of source tags for this firewall. Can't be used for EGRESS."
    default     = []
}

variable "target_tags" {
    description = "A list of target tags for this firewall."
    default     = []
}

variable "direction" {
    description = "Direction of traffic to which this firewall applies; One of INGRESS or EGRESS. Defaults to INGRESS."
    default     = "INGRESS"
}

variable "destination_ranges" {
    description = "A list of destination CIDR ranges that this firewall applies to. Can't be used for INGRESS."
    default     = []
}

variable "source_service_accounts" {
    description = "A list of service accounts such that the firewall will apply only to traffic originating from an instance with a service account in this list. Note that as of May 2018, this list can contain only one item, due to a change in the way that these firewall rules are handled. Source service accounts cannot be used to control traffic to an instance's external IP address because service accounts are associated with an instance, not an IP address. source_ranges can be set at the same time as source_service_accounts. If both are set, the firewall will apply to traffic that has source IP address within source_ranges OR the source IP belongs to an instance with service account listed in source_service_accounts. The connection does not need to match both properties for the firewall to apply. source_service_accounts cannot be used at the same time as source_tags or target_tags."
    default     = []
}

variable "target_service_accounts" {
    description = "A list of service accounts indicating sets of instances located in the network that may make network connections as specified in allow. target_service_accounts cannot be used at the same time as source_tags or target_tags. If neither target_service_accounts nor target_tags are specified, the firewall rule applies to all instances on the specified network. Note that as of May 2018, this list can contain only one item, due to a change in the way that these firewall rules are handled."
    default     = []
}

variable "allow_protocol" {
    description = "The name of the protocol to allow. This value can either be one of the following well known protocol strings (tcp, udp, icmp, esp, ah, sctp), or the IP protocol number, or all."
    default     = ""
}

variable "allow_ports" {
    description = "List of ports and/or port ranges to allow. This can only be specified if the protocol is TCP or UDP."
    default     = []
}

variable "deny_protocol" {
    description = "The name of the protocol to deny. This value can either be one of the following well known protocol strings (tcp, udp, icmp, esp, ah, sctp), or the IP protocol number, or all."
    default     = ""
}

variable "deny_ports" {
    description = "List of ports and/or port ranges to allow. This can only be specified if the protocol is TCP or UDP."
    default     = []
}

variable "enable_all_ingress" {
    description = "Enable all ports for ingress traffic"
    default     = false
}

variable "enable_all_egress" {
    description = "Enable all ports for egress traffic"
    default     = true
}
