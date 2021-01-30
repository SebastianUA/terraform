#---------------------------------------------------
# Global
#---------------------------------------------------
variable "name" {
  description = "Set name if some variables will be unset for resources"
  default     = "heroku"
}

variable "environment" {
  description = "Set Env name"
  default     = "dev"
}

#---------------------------------------------------
# Heroku team collaborator
#---------------------------------------------------
variable "enable_team_collaborator" {
  description = "Enable Heroku team collaborator usage"
  default     = false
}

variable "team_collaborator_app" {
  description = "(Required) The name of the team app that the team collaborator will be added to."
  default     = null
}

variable "team_collaborator_email" {
  description = "(Required) Email address of the team collaborator"
  default     = null
}

variable "team_collaborator_permissions" {
  description = "(Required) List of permissions that will be granted to the team collaborator. The order in which individual permissions are set here does not matter."
  default     = null
}

#---------------------------------------------------
# Heroku team member
#---------------------------------------------------
variable "enable_team_member" {
  description = "Enable Heroku team member usage"
  default     = false
}

variable "team_member_team" {
  description = "The name of the Heroku Team."
  default     = ""
}

variable "team_member_email" {
  description = "(Required) Email address of the member"
  default     = null
}

variable "team_member_role" {
  description = "(Required) The role to assign the member. See the API docs for available options."
  default     = null
}
