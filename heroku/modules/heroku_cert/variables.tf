#---------------------------------------------------
# Heroku cert
#---------------------------------------------------
variable "enable_cert" {
  description = "Enable Heroku cert usage"
  default     = false
}

variable "cert_app" {
  description = "(Required) The Heroku app to add to."
  default     = null
}

variable "cert_certificate_chain" {
  description = "(Required) The certificate chain to add"
  default     = null
}

variable "cert_private_key" {
  description = "(Required) The private key for a given certificate chain"
  default     = null
}
