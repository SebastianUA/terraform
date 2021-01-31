#---------------------------------------------------
# Heroku build
#---------------------------------------------------
variable "enable_build" {
  description = "Enable Heroku build usage"
  default     = false
}

variable "build_app" {
  description = "(Required) The ID of the Heroku app"
  default     = null
}

variable "build_buildpacks" {
  description = "List of buildpack GitHub URLs"
  default     = null
}

variable "build_source" {
  description = "(Required) A block that specifies the source code to build & release"
  default     = []
}
