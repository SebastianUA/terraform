#---------------------------------------------------
# Consul certificate authority
#---------------------------------------------------
variable "enable_certificate_authority" {
  description = "Enable certificate authority for Consul usage"
  default     = false
}

variable "certificate_authority_connect_provider" {
  description = "(Required, string) Specifies the CA provider type to use."
  default     = null
}

variable "certificate_authority_config" {
  description = "(Required, map) The raw configuration to use for the chosen provider."
  default     = null
}
