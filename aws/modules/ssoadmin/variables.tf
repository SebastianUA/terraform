#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Set name prefix for some resources"
  default     = "ssoadmin"
}

variable "environment" {
  description = "Set Env for stack"
  default     = "dev"
}

variable "tags" {
  description = "A list of tag blocks. Each element should have keys named key, value, etc."
  type        = map(string)
  default     = {}
}

#---------------------------------------------------
# ssoadmin account assignment
#---------------------------------------------------
variable "enable_ssoadmin_account_assignment" {
  description = "Enable ssoadmin account assignment usage"
  default     = false
}

variable "ssoadmin_account_assignment_instance_arn" {
  description = "(Required, Forces new resource) The Amazon Resource Name (ARN) of the SSO Instance."
  default     = null
}

variable "ssoadmin_account_assignment_permission_set_arn" {
  description = "(Required, Forces new resource) The Amazon Resource Name (ARN) of the Permission Set that the admin wants to grant the principal access to."
  default     = null
}

variable "ssoadmin_account_assignment_principal_id" {
  description = "(Required, Forces new resource) An identifier for an object in SSO, such as a user or group. PrincipalIds are GUIDs (For example, f81d4fae-7dec-11d0-a765-00a0c91e6bf6)."
  default     = null
}

variable "ssoadmin_account_assignment_principal_type" {
  description = "(Required, Forces new resource) The entity type for which the assignment will be created. Valid values: USER, GROUP."
  default     = null
}


variable "ssoadmin_account_assignment_target_id" {
  description = "(Required, Forces new resource) An AWS account identifier, typically a 10-12 digit string."
  default     = null
}

variable "ssoadmin_account_assignment_target_type" {
  description = "(Optional, Forces new resource) The entity type for which the assignment will be created. Valid values: AWS_ACCOUNT."
  default     = null
}

#---------------------------------------------------
# ssoadmin managed policy attachment
#---------------------------------------------------
variable "enable_ssoadmin_managed_policy_attachment" {
  description = "Enable ssoadmin managed policy attachment usage"
  default     = false
}

variable "ssoadmin_managed_policy_attachment_instance_arn" {
  description = "The Amazon Resource Name (ARN) of the SSO Instance under which the operation will be executed."
  default     = ""
}

variable "ssoadmin_managed_policy_attachment_managed_policy_arns" {
  description = "(Required, Forces new resource) The IAM managed policy list of Amazon Resource Name (ARN) to be attached to the Permission Set."
  default     = []
}

variable "ssoadmin_managed_policy_attachment_permission_set_arn" {
  description = "The Amazon Resource Name (ARN) of the Permission Set."
  default     = ""
}

#---------------------------------------------------
# ssoadmin permission set
#---------------------------------------------------
variable "enable_ssoadmin_permission_set" {
  description = "Enable ssoadmin permission set usage"
  default     = false
}

variable "ssoadmin_permission_set_name" {
  description = "The name of the Permission Set."
  default     = ""
}

variable "ssoadmin_permission_set_instance_arn" {
  description = "(Required, Forces new resource) The Amazon Resource Name (ARN) of the SSO Instance under which the operation will be executed."
  default     = null
}

variable "ssoadmin_permission_set_description" {
  description = "(Optional) The description of the Permission Set."
  default     = null
}

variable "ssoadmin_permission_set_relay_state" {
  description = "(Optional) The relay state URL used to redirect users within the application during the federation authentication process."
  default     = null
}

variable "ssoadmin_permission_set_session_duration" {
  description = "(Optional) The length of time that the application user sessions are valid in the ISO-8601 standard. Default: PT1H."
  default     = null
}

#---------------------------------------------------
# ssoadmin permission set inline policy
#---------------------------------------------------
variable "enable_ssoadmin_permission_set_inline_policy" {
  description = "Enable ssoadmin permission set inline policy usage"
  default     = false
}

variable "ssoadmin_permission_set_inline_policy_inline_policies" {
  description = "(Required) The IAM inline policy list to attach to a Permission Set."
  default     = []
}

variable "ssoadmin_permission_set_inline_policy_instance_arn" {
  description = "The Amazon Resource Name (ARN) of the SSO Instance under which the operation will be executed."
  default     = ""
}

variable "ssoadmin_permission_set_inline_policy_permission_set_arn" {
  description = "The Amazon Resource Name (ARN) of the Permission Set."
  default     = ""
}
