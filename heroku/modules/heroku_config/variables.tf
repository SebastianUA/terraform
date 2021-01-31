#---------------------------------------------------
# Heroku config
#---------------------------------------------------
variable "enable_config" {
  description = "Enable Heroku config usage"
  default     = false
}

variable "config_vars" {
  description = "Map of vars that are can be outputted in plaintext."
  default     = null
}

variable "config_sensitive_vars" {
  description = "This is the same as vars. The main difference between the two attributes is sensitive_vars outputs are redacted on-screen and replaced by a <sensitive> placeholder, following a terraform plan or apply. It is recommended to put private keys, passwords, etc in this argument."
  default     = null
}
