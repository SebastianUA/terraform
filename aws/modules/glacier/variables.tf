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
# AWS glacier vault
#---------------------------------------------------
variable "enable_glacier_vault" {
  description = "Enable glacier vault usage"
  default     = false
}

variable "glacier_vault_name" {
  description = "The name of the Vault. Names can be between 1 and 255 characters long and the valid characters are a-z, A-Z, 0-9, '_' (underscore), '-' (hyphen), and '.' (period)."
  default     = ""
}

variable "glacier_vault_access_policy" {
  description = "(Optional) The policy document. This is a JSON formatted string. The heredoc syntax or file function is helpful here. Use the Glacier Developer Guide for more information on Glacier Vault Policy"
  default     = null
}

variable "glacier_vault_notification" {
  description = "(Optional) The notifications for the Vault."
  default     = []
}

#---------------------------------------------------
# AWS glacier vault lock
#---------------------------------------------------
variable "enable_glacier_vault_lock" {
  description = "Enable glacier vault lock usage"
  default     = false
}

variable "glacier_vault_lock_complete_lock" {
  description = "(Required) Boolean whether to permanently apply this Glacier Lock Policy. Once completed, this cannot be undone. If set to false, the Glacier Lock Policy remains in a testing mode for 24 hours. After that time, the Glacier Lock Policy is automatically removed by Glacier and the Terraform resource will show as needing recreation. Changing this from false to true will show as resource recreation, which is expected. Changing this from true to false is not possible unless the Glacier Vault is recreated at the same time."
  default     = false
}

variable "glacier_vault_lock_policy" {
  description = "(Required) JSON string containing the IAM policy to apply as the Glacier Vault Lock policy."
  default     = null
}

variable "glacier_vault_lock_vault_name" {
  description = "The name of the Glacier Vault."
  default     = ""
}

variable "glacier_vault_lock_ignore_deletion_error" {
  description = "(Optional) Allow Terraform to ignore the error returned when attempting to delete the Glacier Lock Policy. This can be used to delete or recreate the Glacier Vault via Terraform, for example, if the Glacier Vault Lock policy permits that action. This should only be used in conjunction with complete_lock being set to true."
  default     = null
}
