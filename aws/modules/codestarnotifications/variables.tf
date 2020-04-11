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
# AWS codestarnotifications notification rule
#---------------------------------------------------
variable "enable_codestarnotifications_notification_rule" {
  description   = "Enable codestarnotifications notification rule usage"
  default       = false
}

variable "codestarnotifications_notification_rule_name" {
  description   = "The name of notification rule."
  default       = ""
}

variable "codestarnotifications_notification_rule_resource" {
  description   = "(Required) The ARN of the resource to associate with the notification rule. For exapmle: aws_codecommit_repository.codecommit_repository.arn"
  default       = ""
}

variable "codestarnotifications_notification_rule_detail_type" {
  description   = "(Required) The level of detail to include in the notifications for this resource. Possible values are BASIC and FULL"
  default       = "FULL"
}

variable "codestarnotifications_notification_rule_event_type_ids" {
  description   = "(Required) A list of event types associated with this notification rule."
  default       = ["codecommit-repository-comments-on-commits"]
}

variable "codestarnotifications_notification_rule_status" {
  description   = "(Optional) The status of the notification rule. Possible values are ENABLED and DISABLED, default is ENABLED."
  default       = "ENABLED"
}

variable "codestarnotifications_notification_rule_target" {
  description   = "(Optional) Configuration blocks containing notification target information. Can be specified multiple times. At least one target must be specified on creation."
  default       = []
}
