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
# IAM user
#-----------------------------------------------------------
variable "enable_iam_user" {
    description = "Enable iam_user usage"
    default     = false
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
    default     = null
}

variable "force_destroy" {
    description = "(Optional, default false) When destroying this user, destroy even if it has non-Terraform-managed IAM access keys, login profile or MFA devices. Without force_destroy a user with non-Terraform-managed access keys and login profile will fail to be destroyed."
    default     = false
}

#-----------------------------------------------------------
# IAM user policy
#-----------------------------------------------------------
variable "enable_iam_user_policy" {
    description = "Enable iam user policy usage"
    default     = false
}

variable "iam_user_policy_name" {
    description = "(Optional) The name of the policy. If omitted, Terraform will assign a random, unique name."
    default     = ""
}

variable "iam_user_policy_name_prefix" {
    description = "(Optional, Forces new resource) Creates a unique name beginning with the specified prefix. Conflicts with name."
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

#-----------------------------------------------------------
# IAM user policy attachment
#-----------------------------------------------------------
variable "enable_iam_user_policy_attachment" {
    description = "Enable iam_user_policy_attachment usage"
    default     = false
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
    default     = false
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
# IAM  use login profile
#-----------------------------------------------------------
variable "enable_iam_user_login_profile" {
    description = "Enable iam_user_login_profile usage"
    default     = false
}

variable "iam_user_login_profile_user" {
    description = "(Required) The IAM user's name."
    default     = null
}

variable "iam_user_login_profile_pgp_key" {
    description = "(Required) Either a base-64 encoded PGP public key, or a keybase username in the form keybase:username. Only applies on resource creation. Drift detection is not possible with this argument. Ex - keybase:captainua"
    default     = null
}

variable "iam_user_login_profile_password_length" {
    description = "(Optional, default 20) The length of the generated password on resource creation. Only applies on resource creation. Drift detection is not possible with this argument."
    default     = 20
}

variable "iam_user_login_profile_password_reset_required" {
    description = " (Optional, default 'true') Whether the user should be forced to reset the generated password on resource creation. Only applies on resource creation. Drift detection is not possible with this argument."
    default     = true
}

#-----------------------------------------------------------
# IAm user group membership
#-----------------------------------------------------------
variable "enable_iam_user_group_membership" {
    description = "Enable iam_user_group_membership usage"
    default     = false
}

variable "iam_user_group_membership_user" {
    description = "(Required) The name of the IAM User to add to groups"
    default     = ""
}

variable "iam_user_group_membership_groups" {
    description = "(Required) A list of IAM Groups to add the user to"
    default     = []
}
