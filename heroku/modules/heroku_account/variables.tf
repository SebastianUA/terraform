#---------------------------------------------------
# Heroku account feature
#---------------------------------------------------
variable "enable_account_feature" {
  description = "Enable Heroku account feature usage"
  default     = false
}

variable "account_feature_name" {
  description = "(Required) Name of the account feature"
  default     = ""
}

variable "account_feature_enabled" {
  description = "(Required) Enable or disable the account feature"
  default     = true
}
