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

#-----------------------------------------------------------
# IAM user
#-----------------------------------------------------------
variable "enable_iam_user" {
    description = "Enable iam_user usage"
    default     = "false"
} 

variable "iam_user_name" {
    description = "(Required) The user's name. The name must consist of upper and lowercase alphanumeric characters with no spaces. You can also include any of the following characters: =,.@-_.. User names are not distinguished by case. For example, you cannot create users named both 'TESTUSER' and 'testuser'."
    default     = ""
}

variable "iam_user_path" {
    description = "(Optional, default '/') Path in which to create the user."
    default     = "/"
}

variable "permissions_boundary" {
    description = "(Optional) The ARN of the policy that is used to set the permissions boundary for the user."
    default     = ""
}

variable "force_destroy" {
    description = "(Optional, default false) When destroying this user, destroy even if it has non-Terraform-managed IAM access keys, login profile or MFA devices. Without force_destroy a user with non-Terraform-managed access keys and login profile will fail to be destroyed."
    default     = "false"
}

#-----------------------------------------------------------
# IAM user policy
#-----------------------------------------------------------
variable "enable_iam_user_policy" {
    description = "Enable iam user policy usage"
    default     = "false"
}

variable "iam_user_policy_name" {
    description = "(Optional) The name of the policy. If omitted, Terraform will assign a random, unique name."
    default     = ""
}

variable "iam_user_policy_user" {
    description = "(Required) IAM user to which to attach this policy."
    default     = ""
}

variable "iam_user_policy_policy" {
    description = "(Required) IAM user to which to attach this policy."
    default     = ""
}

variable "enable_iam_user_policy_name_prefix" {
    description = "Enable to use iam_user_policy with prefix"
    default     = "false"
}

variable "iam_user_policy_name_prefix" {
    description = "(Optional, Forces new resource) Creates a unique name beginning with the specified prefix. Conflicts with name."
    default     = "prefix-"
}

#-----------------------------------------------------------
# IAM user policy attachment
#-----------------------------------------------------------
variable "enable_iam_user_policy_attachment" {
    description = "Enable iam_user_policy_attachment usage"
    default     = "false"
}

variable "iam_user_policy_attachment_name" {
    description = "(Required) - The user the policy should be applied to"
    default     = ""
}

variable "iam_user_policy_attachment_policy_arn" {
    description = "(Required) - The ARN of the policy you want to apply"
    default     = ""
}

#-----------------------------------------------------------
# IAM  user ssh key
#-----------------------------------------------------------
variable "enable_iam_user_ssh_key" {
    description = "Enable iam_user_ssh_key usage"
    default     = "false"
}

variable "iam_user_ssh_key_username" {
    description = "(Required) The name of the IAM user to associate the SSH public key with."
    default     = ""
}

variable "iam_user_ssh_key_encoding" {
    description = "(Required) Specifies the public key encoding format to use in the response. To retrieve the public key in ssh-rsa format, use SSH. To retrieve the public key in PEM format, use PEM."
    default     = "SSH"
}

variable "iam_user_ssh_key_public_key" {
    description = "(Required) The SSH public key. The public key must be encoded in ssh-rsa format or PEM format."
    default     = ""
}

variable "iam_user_ssh_key_status" {
    description = "(Optional) The status to assign to the SSH public key. Active means the key can be used for authentication with an AWS CodeCommit repository. Inactive means the key cannot be used. Default is Active."
    default     = "Active"
}

#-----------------------------------------------------------
# IAM access key
#-----------------------------------------------------------
variable "enable_iam_access_key" {
    description = "Enable iam_access_key  usage"
    default     = "false"
}

variable "iam_access_key_user" {
    description = "(Required) The IAM user to associate with this access key."
    default     = ""
}

variable "iam_access_key_pgp_key" {
    description = "(Optional) Either a base-64 encoded PGP public key, or a keybase username in the form keybase:some_person_that_exists."
    default     = ""
}

variable "iam_access_key_status" {
    description = "(Optional) The access key status to apply. Defaults to Active. Valid values are Active and Inactive."
    default     = "Active"
}   

#-----------------------------------------------------------
# IAM  use login profile
#-----------------------------------------------------------
variable "enable_iam_user_login_profile" {
    description = "Enable iam_user_login_profile usage"
    default     = "false"
}

variable "iam_user_login_profile_user" {
    description = "(Required) The IAM user's name."
    default     = ""
}

variable "iam_user_login_profile_pgp_key" {
    description = "(Required) Either a base-64 encoded PGP public key, or a keybase username in the form keybase:username. Only applies on resource creation. Drift detection is not possible with this argument."
    default     = "keybase:some_person_that_exists"
}

variable "iam_user_login_profile_password_length" {
    description = "(Optional, default 20) The length of the generated password on resource creation. Only applies on resource creation. Drift detection is not possible with this argument."
    default     = "20"
}

variable "iam_user_login_profile_password_reset_required" {
    description = " (Optional, default 'true') Whether the user should be forced to reset the generated password on resource creation. Only applies on resource creation. Drift detection is not possible with this argument."
    default     = "true"
}

#-----------------------------------------------------------
# IAm user group membership
#-----------------------------------------------------------
variable "enable_iam_user_group_membership" {
    description = "Enable iam_user_group_membership usage"
    default     = "false"
}

variable "iam_user_group_membership_user" {
    description = "(Required) The name of the IAM User to add to groups"
    default     = ""
}

variable "iam_user_group_membership_groups" {
    description = "(Required) A list of IAM Groups to add the user to"
    type        = "list"
    default     = []
}
