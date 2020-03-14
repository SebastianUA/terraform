variable "name" {
    description = "A unique name for the resource, required by GCE. Changing this forces a new resource to be created."
    default     = "TEST"
}

variable "environment" {
    description = "Environment for service"
    default     = "STAGE"
}

variable "description" {
    description = "(Optional) The description to associate with the runtime config."
    default     = ""
}

variable "project" {
    description = "(Optional) The ID of the project in which the resource belongs. If it is not provided, the provider project is used."
    default     = ""
}

variable "enable_runtimeconfig_variable_text_usage" {
    description = "Enable runtimeconfig variable with text usage"
    default     = "false"
}

variable "runtimeconfig_config_name" {
    description = "(Required) The name of the RuntimeConfig resource containing this variable."
    default     = ""
}

variable "text" {
    description = "(Required) The content to associate with the variable. Exactly one of text or variable must be specified. If text is specified, it must be a valid UTF-8 string and less than 4096 bytes in length. If value is specified, it must be base64 encoded and less than 4096 bytes in length."
    default     = ""
}

variable "value" {
    description = "(Required) The content to associate with the variable. Exactly one of text or variable must be specified. If text is specified, it must be a valid UTF-8 string and less than 4096 bytes in length. If value is specified, it must be base64 encoded and less than 4096 bytes in length."
    default     = ""
}

variable "enable_runtimeconfig_variable_value_usage" {
    description = "Enable runtimeconfig variable with value usage"
    default     = "false"
}

variable "value_file" {
    description = "Path to file with value data"
    default     = "files/file_name.dat"
}
