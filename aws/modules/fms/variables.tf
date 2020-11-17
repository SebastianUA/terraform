#---------------------------------------------------
# AWS fms admin account
#---------------------------------------------------
variable "enable_fms_admin_account" {
  description = "Enable fms admin account usage"
  default     = false
}

variable "fms_admin_account_id" {
  description = "(Optional) The AWS account ID to associate with AWS Firewall Manager as the AWS Firewall Manager administrator account. This can be an AWS Organizations master account or a member account. Defaults to the current account. Must be configured to perform drift detection."
  default     = null
}
