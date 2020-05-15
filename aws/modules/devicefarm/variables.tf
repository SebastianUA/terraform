#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST"
}

variable "environment" {
    description = "Environment for service"
    default     = "STAGE"
}

#---------------------------------------------------
# AWS devicefarm project
#---------------------------------------------------
variable "enable_devicefarm_project" {
  description   = "Enable devicefarm project usage"
  default       = false
}

variable "devicefarm_project_name" {
  description   = "The name of the project"
  default       = ""
}
