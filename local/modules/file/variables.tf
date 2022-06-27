#---------------------------------------------------
# Local file
#---------------------------------------------------
variable "enable_file" {
  description = "Enable file usage"
  default     = false
}

variable "file_filename" {
  description = "(Required) The path to the file that will be created. Missing parent directories will be created. If the file already exists, it will be overridden with the given content."
  default     = null
}

variable "file_content" {
  description = "(Optional) Content to store in the file, expected to be an UTF-8 encoded string. Conflicts with sensitive_content, content_base64 and source. Exactly one of these four arguments must be specified."
  default     = null
}

variable "file_content_base64" {
  description = "(Optional) Content to store in the file, expected to be binary encoded as base64 string. Conflicts with content, sensitive_content and source. Exactly one of these four arguments must be specified."
  default     = null
}

variable "file_source" {
  description = "(Optional) Path to file to use as source for the one we are creating. Conflicts with content, sensitive_content and content_base64. Exactly one of these four arguments must be specified."
  default     = null
}

variable "file_file_permission" {
  description = "(Optional) Permissions to set for the output file, expressed as string in numeric notation. Default value is '0777'."
  default     = null
}

variable "file_directory_permission" {
  description = "(Optional) Permissions to set for directories created, expressed as string in numeric notation. Default value is '0777'."
  default     = null
}

#---------------------------------------------------
# Local sensitive file
#---------------------------------------------------
variable "enable_sensitive_file" {
  description = "Enable sensitive file usage"
  default     = false
}

variable "sensitive_file_filename" {
  description = "(Required) The path to the file that will be created. Missing parent directories will be created. If the file already exists, it will be overridden with the given content."
  default     = null
}

variable "sensitive_file_content" {
  description = "(Optional) Sensitive content to store in the file, expected to be an UTF-8 encoded string. Conflicts with content_base64 and source. Exactly one of these three arguments must be specified."
  default     = null
}

variable "sensitive_file_content_base64" {
  description = "(Optional) Sensitive content to store in the file, expected to be binary encoded as base64 string. Conflicts with content and source. Exactly one of these three arguments must be specified."
  default     = null
}

variable "sensitive_file_source" {
  description = "(Optional) Path to file to use as source for the one we are creating. Conflicts with content and content_base64. Exactly one of these three arguments must be specified."
  default     = null
}

variable "sensitive_file_file_permission" {
  description = "(Optional) Permissions to set for the output file, expressed as string in numeric notation. Default value is '0777'."
  default     = null
}

variable "sensitive_file_directory_permission" {
  description = "(Optional) Permissions to set for directories created, expressed as string in numeric notation. Default value is '0777'."
  default     = null
}
