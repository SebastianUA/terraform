#---------------------------------------------------
# Heroku formation
#---------------------------------------------------
variable "enable_formation" {
  description = "Enable Heroku formation usage"
  default     = false
}

variable "formation_app" {
  description = "(Required) The name of the application"
  default     = null
}

variable "formation_type" {
  description = "(Required) type of process such as 'web'"
  default     = null
}

variable "formation_quantity" {
  description = "(Required) number of processes to maintain"
  default     = null
}

variable "formation_size" {
  description = "(Required) dyno size (Example: “standard-1X”). Capitalization does not matter."
  default     = null
}
