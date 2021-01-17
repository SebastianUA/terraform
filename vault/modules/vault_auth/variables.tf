#-----------------------------------------------------------
# Global
#-----------------------------------------------------------

#---------------------------------------------------
# Vault auth backend
#---------------------------------------------------
variable "enable_auth_backend" {
  description = "Enable auth backend for vault"
  default     = false
}

variable "auth_backend_type" {
  description = "(Required) The name of the auth method type"
  default     = null
}

variable "auth_backend_path" {
  description = "(Optional) The path to mount the auth method — this defaults to the name of the type"
  default     = null
}

variable "auth_backend_description" {
  description = "(Optional) A description of the auth method"
  default     = null
}

variable "auth_backend_local" {
  description = "(Optional) Specifies if the auth method is local only."
  default     = null
}

variable "auth_backend_tune" {
  description = "(Optional) Extra configuration block."
  default     = []
}
