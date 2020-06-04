#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "tags" {
    description = "A list of tag blocks. Each element should have keys named key, value, etc."
    type        = map(string)
    default     = {}
}

#---------------------------------------------------
# AWS secretsmanager secret
#---------------------------------------------------
variable "enable_secretsmanager_secret" {
  description   = "Enable secretsmanager secret usage"
  default       = false
}

variable "secretsmanager_secret_name" {
  description   = "(Optional) Specifies the friendly name of the new secret. The secret name can consist of uppercase letters, lowercase letters, digits, and any of the following characters: /_+=.@- Conflicts with secretsmanager_secret_name_prefix."
  default       = null
}

variable "secretsmanager_secret_name_prefix" {
  description   = "(Optional) Creates a unique name beginning with the specified prefix. Conflicts with secretsmanager_secret_name."
  default       = null
}

variable "secretsmanager_secret_description" {
  description   = "(Optional) A description of the secret."
  default       = null
}

variable "secretsmanager_secret_kms_key_id" {
  description   = "(Optional) Specifies the ARN or alias of the AWS KMS customer master key (CMK) to be used to encrypt the secret values in the versions stored in this secret. If you don't specify this value, then Secrets Manager defaults to using the AWS account's default CMK (the one named aws/secretsmanager). If the default KMS CMK with that name doesn't yet exist, then AWS Secrets Manager creates it for you automatically the first time."
  default       = null
}

variable "secretsmanager_secret_policy" {
  description   = "(Optional) A valid JSON document representing a resource policy. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide."
  default       = null
}

variable "secretsmanager_secret_recovery_window_in_days" {
  description   = "(Optional) Specifies the number of days that AWS Secrets Manager waits before it can delete the secret. This value can be 0 to force deletion without recovery or range from 7 to 30 days. The default value is 30."
  default       = 30
}

variable "secretsmanager_secret_rotation_lambda_arn" {
  description   = "description"
  default       = null
}

variable "secretsmanager_secret_rotation_rules" {
  description   = "(Optional) A structure that defines the rotation configuration for this secret."
  default       = []
}

#---------------------------------------------------
# AWS secretsmanager secret version
#---------------------------------------------------
variable "enable_secretsmanager_secret_version" {
  description   = "Enable secretsmanager secret version usage"
  default       = false
}

variable "secretsmanager_secret_version_secret_id" {
  description   = "Specifies the secret to which you want to add a new version. You can specify either the Amazon Resource Name (ARN) or the friendly name of the secret. The secret must already exist."
  default       = ""
}

variable "secretsmanager_secret_version_secret_string" {
  description   = "(Optional) Specifies text data that you want to encrypt and store in this version of the secret. This is required if secret_binary is not set."
  default       = null
}

variable "secretsmanager_secret_version_secret_binary" {
  description   = "(Optional) Specifies binary data that you want to encrypt and store in this version of the secret. This is required if secret_string is not set. Needs to be encoded to base64."
  default       = null
}

variable "secretsmanager_secret_version_version_stages" {
  description   = "(Optional) Specifies a list of staging labels that are attached to this version of the secret. A staging label must be unique to a single version of the secret. If you specify a staging label that's already associated with a different version of the same secret then that staging label is automatically removed from the other version and attached to this version. If you do not specify a value, then AWS Secrets Manager automatically moves the staging label AWSCURRENT to this new version on creation."
  default       = null
}
