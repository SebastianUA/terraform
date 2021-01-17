#-----------------------------------------------------------
# Global
#-----------------------------------------------------------

#---------------------------------------------------
# Vault namespace
#---------------------------------------------------
variable "enable_namespace" {
  description = "Enable namespace for Vault usage"
  default     = false
}

variable "namespace_path" {
  description = "(Required) The path of the namespace. Must not have a trailing /"
  default     = null
}
