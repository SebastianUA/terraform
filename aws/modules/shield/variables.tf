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
# AWS shield protection
#---------------------------------------------------
variable "enable_shield_protection" {
  description = "Enable shield protection usage"
  default     = false
}

variable "shield_protection_name" {
  description = "A friendly name for the Protection you are creating."
  default     = ""
}

variable "shield_protection_resource_arn" {
  description = "(Required) The ARN (Amazon Resource Name) of the resource to be protected."
  default     = ""
}
