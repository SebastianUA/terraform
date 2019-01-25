#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST-IAM"
}

variable "environment" {
    description = "Environment for service"
    default     = "STAGE"
}

variable "orchestration" {
    description = "Type of orchestration"
    default     = "Terraform"
}

variable "createdby" {
    description = "Created by"
    default     = "Vitaliy Natarov"
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

variable "assume_role_policy_file" {
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
    default     = ""
}

#variable "provider" {
#    type = "map"
#    default = {
#        access_key = "unknown"
#        secret_key = "unknown"
#        region     = "us-east-1"
#    }
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
    default     = ""
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

variable "iam_policy_file" {
    description = "File with policy"
    default     = ""
}

variable "iam_policy_name" {
    description = "Set custom policy name"
    default     = ""
}

#-----------------------------------------------------------
# IAM crossaccount role
#-----------------------------------------------------------
variable "enable_crossaccount_role" {
    description = "Enabling cross account role"
    default     = false
}

variable "cross_account_assume_role_name" {
    description = "Set custom cross account assume role name"
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

#-----------------------------------------------------------
# Cross account assume role
#-----------------------------------------------------------
variable "cross_acc_principal_arns" {
    description = "ARNs of accounts, groups, or users with the ability to assume this role."
    type        = "list"
    default     = ["222222222222","arn:aws:iam::333333333333:user/MyUser"]
}

variable "cross_acc_policy_arns" {
    description = "List of ARNs of policies to be associated with the created IAM role"
    type        = "list"
    default     = ["arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser", "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"]
}

#-----------------------------------------------------------
# IAM certificate
#-----------------------------------------------------------
variable "enable_iam_server_certificate" {
    description = "Allow upload server certificate"
    default     = false
}

variable "iam_server_certificate_name" {
    description = "Set custom iam server cert name"
    default     = ""
}

variable "certificate_body_file" {
    description = "Path to the crt file"
    default     = ""
}

variable "private_key_file" {
    description = "Path to the private key file"
    default     = ""
}
