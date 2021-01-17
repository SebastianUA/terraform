#-----------------------------------------------------------
# Global
#-----------------------------------------------------------

#---------------------------------------------------
# Vault mount
#---------------------------------------------------
variable "enable_mount" {
  description = "Enable mount for Vault usage"
  default     = false
}

variable "mount_path" {
  description = "(Required) Where the secret backend will be mounted"
  default     = null
}

variable "mount_type" {
  description = "(Required) Type of the backend, such as 'aws', 'generic', etc."
  default     = null
}

variable "mount_description" {
  description = "(Optional) Human-friendly description of the mount"
  default     = null
}

variable "mount_default_lease_ttl_seconds" {
  description = "(Optional) Default lease duration for tokens and secrets in seconds"
  default     = null
}

variable "mount_max_lease_ttl_seconds" {
  description = "(Optional) Maximum possible lease duration for tokens and secrets in seconds"
  default     = null
}

variable "mount_local" {
  description = "(Optional) Boolean flag that can be explicitly set to true to enforce local mount in HA environment"
  default     = null
}

variable "mount_options" {
  description = "(Optional) Specifies mount type specific options that are passed to the backend"
  default     = null
}

variable "mount_seal_wrap" {
  description = "(Optional) Boolean flag that can be explicitly set to true to enable seal wrapping for the mount, causing values stored by the mount to be wrapped by the seal's encryption capability"
  default     = null
}

variable "mount_external_entropy_access" {
  description = "(Optional) Boolean flag that can be explicitly set to true to enable the secrets engine to access Vault's external entropy source"
  default     = null
}
