#---------------------------------------------------
# Heroku collaborator
#---------------------------------------------------
variable "enable_collaborator" {
  description = "Enable Heroku collaborator usage"
  default     = false
}

variable "collaborator_app" {
  description = "(Required) The name of the app that the collaborator will be added to."
  default     = null
}

variable "collaborator_email" {
  description = "(Required) Email address of the collaborator"
  default     = null
}
