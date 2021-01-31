#---------------------------------------------------
# Heroku domain
#---------------------------------------------------
variable "enable_domain" {
  description = "Enable Heroku domain usage"
  default     = false
}

variable "domain_app" {
  description = "(Required) The Heroku app to link to."
  default     = null
}

variable "domain_hostname" {
  description = "(Required) The hostname to serve requests from."
  default     = null
}
