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
# AWS codestarconnections connection
#---------------------------------------------------
variable "enable_codestarconnections_connection" {
  description = "Enable codestarconnections connection usage"
  default     = false
}

variable "codestarconnections_connection_name" {
  description = "The name of the connection to be created. The name must be unique in the calling AWS account. Changing name will create a new resource."
  default     = ""
}

variable "codestarnotifications_notification_rule_resource" {
  description = "(Required) The name of the external provider where your third-party code repository is configured. Valid values are Bitbucket, GitHub, or GitHubEnterpriseServer. Changing provider_type will create a new resource."
  default     = null
}