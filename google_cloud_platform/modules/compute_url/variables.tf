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
    description = "(Optional) A brief description of this resource."
    default     = ""
}

variable "default_service" {
    description = "(Required) The backend service or backend bucket to use when none of the given rules match."
    default     = ""
}

variable "enable_compute_url_map" {
    description = "Enable compute url map usage"
    default     = "false"
}

variable "host_rule_hosts" {
    description = "(Required) - The list of host patterns to match."
    default     = []
}

variable "host_rule_path_matcher" {
    description = "(Required) The name of the path_matcher to apply this host rule to."
    default     = ""
}

variable "host_rule_description" {
    description = "(Optional) An optional description of the host rule."
    default     = ""
}

variable "test_service" {
    description = "(Required) The backend service or backend bucket link that should be matched by this test."
    default     = ""
}

variable "test_host" {
    description = "(Required) The host component of the URL being tested."
    default     = ""
}

variable "test_path" {
    description = "(Required) The path component of the URL being tested."
    default     = ""
}

variable "test_description" {
    description = "(Optional) An optional description of this test."
    default     = ""
}

variable "path_rule_paths" {
    description = "(Required) The list of paths to match against."
    default     = []
}

variable "path_rule_service" {
    description = "(Required) The backend service or backend bucket to use if any of the given paths match."
    default     = ""
}

variable "path_rule" { 
    description = "Rules for path_rule"
    default     = []
}

variable "path_matcher_name" {
    description = "(Required) The name of the path_matcher resource."
    default     = ""
}
