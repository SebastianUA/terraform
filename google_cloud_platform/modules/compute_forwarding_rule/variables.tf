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

variable "region" {
    description = "The region in which the resource belongs. If it is not provided, the project region is used."
    default     = ""
}

variable "description" {
    description = "Description of this forwarding rule."
    default     = ""
}

variable "network" {
    description = "Network of this forwarding rule."
    default     = ""
}

variable "subnetwork" {
    description = "Subnetwork of this forwarding rule."
    default     = ""
}

variable "ip_address" {
    description = "IP address of this forwarding rule."
    default     = ""
}

variable "ip_protocol" {
    description = "IP protocol of this forwarding rule."
    default     = ""
}

variable "ports" {
    description = "List of ports to use for internal load balancing, if this forwarding rule has any."
    default     = []
}

variable "port_range" {
    description = "Port range, if this forwarding rule has one."
    default     = ""
}

variable "target" {
    description = "URL of the target pool, if this forwarding rule has one."
    default     = ""
}

variable "backend_service" {
    description = "Backend service, if this forwarding rule has one."
    default     = ""
}

variable "load_balancing_scheme" {
    description = " Type of load balancing of this forwarding rule. Default is EXTERNAL"
    default     = "EXTERNAL"
}
