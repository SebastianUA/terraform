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

variable "description" {
    description = "(Optional) An optional description of this resource."
    default     = ""
}

variable "enable_compute_address" {
    description = "Enable compute address usage"
    default     = "true"
}

variable "address_type" {
    description = "(Optional) The type of address to reserve, either INTERNAL or EXTERNAL. If unspecified, defaults to EXTERNAL."
    default     = "EXTERNAL"
}

variable "network_tier" {
    description = "(Optional) The networking tier used for configuring this address. This field can take the following values: PREMIUM or STANDARD. If this field is not specified, it is assumed to be PREMIUM."
    default     = "PREMIUM"
}

variable "subnetwork" {
    description = "(Optional) The URL of the subnetwork in which to reserve the address. If an IP address is specified, it must be within the subnetwork's IP range. This field can only be used with INTERNAL type with GCE_ENDPOINT/DNS_RESOLVER purposes."
    default     = ""
}

variable "region" {
    description = "(Optional) The Region in which the created address should reside. If it is not provided, the provider region is used."
    default     = ""
}

variable "timeouts_create" {
    description = "Time to create redis node. Default is 6 minutes. Valid units of time are s, m, h."
    default     = "6m"
}

variable "timeouts_delete" {
    description = "Time to delete redis node. Default is 4 minutes. Valid units of time are s, m, h."
    default     = "4m"
}

variable "enable_compute_global_address" {
    description = "Enable compute global address usage"
    default     = "false"
}

variable "ip_version" {
    description = "(Optional) The IP Version that will be used by this address. Valid options are IPV4 or IPV6. The default value is IPV4."
    default     = "IPV4"
}
