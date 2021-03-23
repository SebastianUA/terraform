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

variable "tags" {
  description = "A list of tag blocks. Each element should have keys named key, value, etc."
  type        = map(string)
  default     = {}
}

#---------------------------------------------------
# AWS prometheus workspace
#---------------------------------------------------
variable "enable_prometheus_workspace" {
  description = "Enable prometheus workspace usage"
  default     = false
}

variable "prometheus_workspace_alias" {
  description = "(Optional) The alias of the prometheus workspace. See more in AWS Docs."
  default     = null
}