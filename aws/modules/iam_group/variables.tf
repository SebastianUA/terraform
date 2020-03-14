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
# IAM group
#-----------------------------------------------------------
variable "enable_iam_group" {
  description   = "Enable IAM group usage"
  default       = false
}

variable "iam_group_name" {
  description   = "The group's name. The name must consist of upper and lowercase alphanumeric characters with no spaces. You can also include any of the following characters: =,.@-_.. Group names are not distinguished by case. For example, you cannot create groups named both 'ADMINS' and"
  default       = ""
}

variable "iam_group_path" {
  description   = "(Optional, default '/') Path in which to create the group."
  default       = "/"
}

#-----------------------------------------------------------
# IAM group policy
#-----------------------------------------------------------
variable "enable_iam_group_policy" {
  description   = "Enable IAM group policy usage"
  default       = false
}

variable "iam_group_policy_name" {
  description   = "(Optional) The name of the policy. If omitted, Terraform will assign a random, unique name."
  default       = ""
}

variable "iam_group_policy_name_prefix" {
  description   = "(Optional) Creates a unique name beginning with the specified prefix. Conflicts with iam_group_policy_name."
  default       = ""
}

variable "iam_group_policy_group" {
  description   = "The IAM group to attach to the policy."
  default       = ""
}

variable "iam_group_policy" {
  description   = "(Required) The policy document. This is a JSON formatted string. For more information about building IAM policy documents with Terraform, see the AWS IAM Policy Document Guide"
  default       = ""
}

#-----------------------------------------------------------
# IAM group policy attachment
#-----------------------------------------------------------
variable "enable_iam_group_policy_attachment" {
  description   = "Enable IAM group policy attachment usage"
  default       = false
}

variable "iam_group_policy_attachment_policy_arn" {
  description = "(Required) - The ARN of the policy you want to apply"
  default     = ""
}

#-----------------------------------------------------------
# IAM group membership
#-----------------------------------------------------------
variable "enable_iam_group_membership" {
  description   = "Enable IAM group membership usage"
  default       = false
}

variable "iam_group_membership_name" {
  description   = "The name to identify the Group Membership"
  default       = ""
}

variable "iam_group_membership_users" {
  description   = "(Required) A list of IAM User names to associate with the Group"
  default       = []
}
