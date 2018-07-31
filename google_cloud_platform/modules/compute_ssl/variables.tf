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
    description = " (Optional) An optional description of this resource."
    default     = ""
}

variable "enable_compute_ssl_policy" {
    description = "Enable compute ssl policy usage"
    default     = "false"
}

variable "profile" {
    description = "(Optional) Profile specifies the set of SSL features that can be used by the load balancer when negotiating SSL with clients. This can be one of COMPATIBLE, MODERN, RESTRICTED, or CUSTOM. If using CUSTOM, the set of SSL features to enable must be specified in the customFeatures field. See the official documentation for information on what cipher suites each profile provides. If CUSTOM is used, the custom_features attribute must be set. Default is COMPATIBLE."
    default     = "COMPATIBLE"
}

variable "min_tls_version" {
    description = "(Optional) The minimum version of SSL protocol that can be used by the clients to establish a connection with the load balancer. This can be one of TLS_1_0, TLS_1_1, TLS_1_2. Default is TLS_1_0."
    default     = "TLS_1_0"
}

variable "custom_features" {
    description = "(Optional) Profile specifies the set of SSL features that can be used by the load balancer when negotiating SSL with clients. This can be one of COMPATIBLE, MODERN, RESTRICTED, or CUSTOM. If using CUSTOM, the set of SSL features to enable must be specified in the customFeatures field. See the official documentation for which ciphers are available to use. Note: this argument must be present when using the CUSTOM profile. This argument must not be present when using any other profile."
    default     = []
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

variable "enable_compute_ssl_certificate" {
    description = "Enable compute ssl certificate usage" 
    default     = "false"
}

variable "name_prefix" {
    description = "(Optional) Creates a unique name beginning with the specified prefix. Conflicts with name."
    default     = ""
}

variable "certificate" {
    description = "(Required) A local certificate file in PEM format. The chain may be at most 5 certs long, and must include at least one intermediate cert. Changing this forces a new resource to be created."
    default     = ""
}

variable "private_key" {
    description = "(Required) Write only private key in PEM format. Changing this forces a new resource to be created."
    default     = ""
}
