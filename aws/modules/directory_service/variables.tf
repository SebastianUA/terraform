#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "tags" {
  description = "A list of tag blocks. Each element should have keys named key, value, etc."
  type        = map(string)
  default     = {}
}

#---------------------------------------------------
# AWS directory service directory
#---------------------------------------------------
variable "enable_directory_service_directory" {
  description = "Enable directory_service directory usage"
  default     = false
}

variable "directory_service_directory_name" {
  description = "(Required) The fully qualified name for the directory, such as corp.example.com"
  default     = ""
}

variable "directory_service_directory_password" {
  description = "(Required) The password for the directory administrator or connector user."
  default     = null
}

variable "directory_service_directory_size" {
  description = "(Required for SimpleAD and ADConnector) The size of the directory (Small or Large are accepted values)."
  default     = null
}

variable "directory_service_directory_alias" {
  description = "(Optional) The alias for the directory (must be unique amongst all aliases in AWS). Required for enable_sso"
  default     = null
}

variable "directory_service_directory_description" {
  description = "(Optional) A textual description for the directory."
  default     = null
}

variable "directory_service_directory_short_name" {
  description = "(Optional) The short name of the directory, such as CORP."
  default     = null
}

variable "directory_service_directory_enable_sso" {
  description = "(Optional) Whether to enable single-sign on for the directory. Requires alias. Defaults to false"
  default     = false
}

variable "directory_service_directory_type" {
  description = "(Optional) - The directory type (SimpleAD, ADConnector or MicrosoftAD are accepted values). Defaults to SimpleAD"
  default     = "SimpleAD"
}

variable "directory_service_directory_edition" {
  description = "Optional) The MicrosoftAD edition (Standard or Enterprise). Defaults to Enterprise (applies to MicrosoftAD type only)."
  default     = "Enterprise"
}

variable "directory_service_directory_vpc_settings" {
  description = "(Required for SimpleAD and MicrosoftAD) VPC related information about the directory."
  default     = []
}

variable "directory_service_directory_connect_settings" {
  description = "(Required for ADConnector) Connector related information about the directory. "
  default     = []
}

#---------------------------------------------------
# AWS directory service log subscription
#---------------------------------------------------
variable "enable_directory_service_log_subscription" {
  description = "Enable directory_service log subscription usage"
  default     = false
}

variable "directory_service_log_subscription_directory_id" {
  description = "The id of directory."
  default     = ""
}

variable "directory_service_log_subscription_log_group_name" {
  description = "(Required) Name of the cloudwatch log group to which the logs should be published. The log group should be already created and the directory service principal should be provided with required permission to create stream and publish logs. Changing this value would delete the current subscription and create a new one. A directory can only have one log subscription at a time."
  default     = null
}

#---------------------------------------------------
# AWS directory service conditional forwarder
#---------------------------------------------------
variable "enable_directory_service_conditional_forwarder" {
  description = "Enable directory_service conditional forwarder usage"
  default     = false
}

variable "directory_service_conditional_forwarder_directory_id" {
  description = "The id of directory."
  default     = ""
}

variable "directory_service_conditional_forwarder_remote_domain_name" {
  description = "(Required) The fully qualified domain name of the remote domain for which forwarders will be used."
  default     = null
}

variable "directory_service_conditional_forwarder_dns_ips" {
  description = "(Required) A list of forwarder IP addresses."
  default     = null
}
