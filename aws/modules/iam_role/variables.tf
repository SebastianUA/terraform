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
  description = "A list of tag blocks. Each element should have keys"
  type        = map(string)
  default     = {}
}

#-----------------------------------------------------------
# IAM role
#-----------------------------------------------------------
variable "enable_iam_role" {
  description = "Enable IAM role creation"
  default     = false
}

variable "iam_role_name" {
  description = "The name of the role"
  default     = ""
}

variable "iam_role_name_prefix" {
  description = "(Optional, Forces new resource) Creates a unique name beginning with the specified prefix. Conflicts with iam_role_name."
  default     = ""
}

variable "iam_role_description" {
  description = "(Optional) The description of the role."
  default     = ""
}

variable "assume_role_policy" {
  description = "File with assume role policy"
  default     = ""
}

variable "iam_role_force_detach_policies" {
  description = "(Optional) Specifies to force detaching any policies the role has before destroying it. Defaults to false."
  default     = false
}

variable "iam_role_path" {
  description = "(Optional) The path to the role. See IAM Identifiers for more information. Defaults is '/'"
  default     = "/"
}

variable "iam_role_max_session_duration" {
  description = "(Optional) The maximum session duration (in seconds) that you want to set for the specified role. If you do not specify a value for this setting, the default maximum of one hour is applied. This setting can have a value from 1 hour to 12 hours."
  default     = 3600
}

variable "iam_role_permissions_boundary" {
  description = "(Optional) The ARN of the policy that is used to set the permissions boundary for the role."
  default     = null
}

#-----------------------------------------------------------
# IAM policy
#-----------------------------------------------------------
variable "enable_iam_role_policy" {
  description = "Enable IAM policy usage/creation"
  default     = false
}

variable "iam_role_policy_name" {
  description = "(Optional) The name of the role policy. If omitted, Terraform will assign a random, unique name."
  default     = ""
}

variable "iam_role_policy_name_prefix" {
  description = "(Optional) Creates a unique name beginning with the specified prefix. Conflicts with iam_role_policy_name."
  default     = ""
}

variable "iam_role_policy_role" {
  description = "(Required) The IAM role to attach to the policy."
  default     = ""
}

variable "iam_role_policy" {
  description = "(Required) The policy document. This is a JSON formatted string. For more information about building IAM policy documents with Terraform, see the AWS IAM Policy Document Guide"
  default     = ""
}

#-----------------------------------------------------------
# IAM Policy Attachment
#-----------------------------------------------------------
variable "enable_iam_role_policy_attachment" {
  description = "Enable IAM role policy attachment usage"
  default     = false
}

variable "policy_arns" {
  description = "(Required) - The list of ARNs of the policy you want to apply"
  default     = []
}

#variable "iam_role_policy_attachment_policy_arn" {
#  description = "(Required) - The ARN of the policy you want to apply"
#  default     = ""
#}

#-----------------------------------------------------------
# IAM Instance Profile
#-----------------------------------------------------------
variable "enable_iam_instance_profile" {
  description = "Enable IAM instance profile"
  default     = false
}

variable "iam_instance_profile_name" {
  description = "The profile's name"
  default     = ""
}

variable "iam_instance_profile_role" {
  description = "(Optional) The role name to include in the profile."
  default     = null
}
