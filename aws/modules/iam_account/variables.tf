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

variable "orchestration" {
    description = "Type of orchestration"
    default     = "Terraform"
}

variable "createdby" {
    description = "Created by"
    default     = "Vitaliy Natarov"
}

#-----------------------------------------------------------
# IAM access key
#-----------------------------------------------------------
variable "enable_iam_access_key" {
    description = "Enable IAM access key usage"
    default     = false
}

variable "iam_access_key_user" {
    description = "(Required) The IAM user to associate with this access key."
    default     = null
}

variable "iam_access_key_pgp_key" {
    description = "(Optional) Either a base-64 encoded PGP public key, or a keybase username in the form keybase:some_person_that_exists."
    default     = null
}

variable "iam_access_key_status" {
    description = "(Optional) The access key status to apply. Defaults to Active. Valid values are Active and Inactive."
    default     = "Active"
}

#-----------------------------------------------------------
# IAM account alias
#-----------------------------------------------------------
variable "enable_iam_account_alias" {
  description   = "Enable IAM account alias usage"
  default       = false
}

variable "account_alias" {
  description   = "(Required) The account alias"
  default       = ""
}

#-----------------------------------------------------------
# IAM account password policy
#-----------------------------------------------------------
variable "enable_iam_account_password_policy" {
  description   = "Enable IAM account password policy usage"
  default       = false
}

variable "minimum_password_length" {
  description   = "(Optional) Minimum length to require for user passwords."
  default       = 8
}

variable "require_lowercase_characters" {
  description   = "(Optional) Whether to require lowercase characters for user passwords."
  default       = true
}

variable "require_numbers" {
  description   = "(Optional) Whether to require numbers for user passwords."
  default       = true
}

variable "require_uppercase_characters" {
  description   = "(Optional) Whether to require uppercase characters for user passwords."
  default       = true
}

variable "require_symbols" {
  description   = "(Optional) Whether to require symbols for user passwords."
  default       = true
}

variable "allow_users_to_change_password" {
  description   = "(Optional) Whether to allow users to change their own password"
  default       = true
}

variable "hard_expiry" {
  description   = "(Optional) Whether users are prevented from setting a new password after their password has expired (i.e. require administrator reset)"
  default       = null
}

variable "max_password_age" {
  description   = "(Optional) The number of days that an user password is valid."
  default       = null
}

variable "password_reuse_prevention" {
  description   = "(Optional) The number of previous passwords that users are prevented from reusing."
  default       = null
}
