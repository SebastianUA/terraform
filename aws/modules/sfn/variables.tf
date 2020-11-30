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
# AWS sfn activity
#---------------------------------------------------
variable "enable_sfn_activity" {
  description = "Enable sfn activity"
  default     = false
}

variable "sfn_activity_name" {
  description = "The name of the activity to create."
  default     = ""
}

#---------------------------------------------------
# AWS sfn state machine
#---------------------------------------------------
variable "enable_sfn_state_machine" {
  description = "Enable sfn state machine"
  default     = false
}

variable "sfn_state_machine_name" {
  description = "The name of the state machine."
  default     = ""
}

variable "sfn_state_machine_definition" {
  description = "(Required) The Amazon States Language definition of the state machine."
  default     = null
}

variable "sfn_state_machine_role_arn" {
  description = "(Required) The Amazon Resource Name (ARN) of the IAM role to use for this state machine."
  default     = null
}