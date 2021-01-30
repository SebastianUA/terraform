#---------------------------------------------------
# Heroku drain
#---------------------------------------------------
variable "enable_drain" {
  description = "Enable Heroku drain usage"
  default     = false
}

variable "drain_app" {
  description = "(Required) The URL for Heroku to drain your logs to."
  default     = null
}

variable "drain_url" {
  description = "(Required) The Heroku app to link to."
  default     = null
}
