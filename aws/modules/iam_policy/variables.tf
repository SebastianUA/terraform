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

#-----------------------------------------------------------
# IAM policy
#-----------------------------------------------------------
variable "enable_iam_policy" {
  description = "Enable IAM policy usage/creation"
  default     = false
}

variable "iam_policy_path" {
  description = "(Optional, default '/') Path in which to create the policy. See IAM Identifiers for more information."
  default     = "/"
}

variable "iam_policy_policy" {
  description = "(Required) The policy document. This is a JSON formatted string. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide"
  default     = ""
}

variable "iam_policy_name" {
  description = "Set custom policy name"
  default     = ""
}

variable "iam_policy_name_prefix" {
  description = "Enable IAM policy with name_prefix usage"
  default     = null
}

variable "iam_policy_description" {
  description = "(Optional, Forces new resource) Description of the IAM policy."
  default     = ""
}

#-----------------------------------------------------------
# IAM Policy Attachment
#-----------------------------------------------------------
variable "enable_iam_policy_attachment" {
  description = "Enabling IAM policy attachment"
  default     = false
}

variable "iam_policy_attachment_name" {
  description = "Set custom iam policy attachment name"
  default     = ""
}

variable "iam_role_policy_attachment_roles" {
  description = "(Optional) - The role(s) the policy should be applied to"
  default     = []
}

variable "iam_policy_attachment_users" {
  description = "(Optional) - The user(s) the policy should be applied to"
  default     = []
}

variable "iam_policy_attachment_groups" {
  description = "(Optional) - The group(s) the policy should be applied to"
  default     = []
}

variable "iam_role_policy_attachment_policy_arn" {
  description = "The ARN of the policy you want to apply"
  default     = ""
}
