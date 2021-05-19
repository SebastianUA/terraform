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
  description = "A list of tag blocks. Each element should have keys named key, value"
  default     = {}
}

#---------------------------------------------------
# AWS cloudtrail
#---------------------------------------------------
variable "enable_cloudtrail" {
  description = "Enable cloudtrail usage"
  default     = false
}

variable "cloudtrail_name" {
  description = "Specifies the name of the trail."
  default     = ""
}

variable "cloudtrail_s3_bucket_name" {
  description = "(Required) Specifies the name of the S3 bucket designated for publishing log files."
  default     = ""
}

variable "cloudtrail_s3_key_prefix" {
  description = "(Optional) Specifies the S3 key prefix that follows the name of the bucket you have designated for log file delivery."
  default     = ""
}

variable "cloudtrail_cloud_watch_logs_role_arn" {
  description = "(Optional) Specifies the role for the CloudWatch Logs endpoint to assume to write to a user’s log group."
  default     = ""
}

variable "cloudtrail_cloud_watch_logs_group_arn" {
  description = "(Optional) Specifies a log group name using an Amazon Resource Name (ARN), that represents the log group to which CloudTrail logs will be delivered."
  default     = ""
}

variable "cloudtrail_enable_logging" {
  description = "(Optional) Enables logging for the trail. Defaults to true. Setting this to false will pause logging."
  default     = true
}

variable "cloudtrail_include_global_service_events" {
  description = "(Optional) Specifies whether the trail is publishing events from global services such as IAM to the log files. Defaults to true."
  default     = true
}

variable "cloudtrail_is_multi_region_trail" {
  description = "(Optional) Specifies whether the trail is created in the current region or in all regions. Defaults to false."
  default     = false
}

variable "cloudtrail_is_organization_trail" {
  description = "(Optional) Specifies whether the trail is an AWS Organizations trail. Organization trails log events for the master account and all member accounts. Can only be created in the organization master account. Defaults to false."
  default     = false
}

variable "cloudtrail_sns_topic_name" {
  description = "(Optional) Specifies the name of the Amazon SNS topic defined for notification of log file delivery."
  default     = ""
}

variable "cloudtrail_enable_log_file_validation" {
  description = "(Optional) Specifies whether log file integrity validation is enabled. Defaults to false."
  default     = false
}

variable "cloudtrail_kms_key_id" {
  description = "(Optional) Specifies the KMS key ARN to use to encrypt the logs delivered by CloudTrail."
  default     = ""
}

variable "cloudtrail_event_selector" {
  description = "(Optional) Set cloudtrail event selector"
  default     = []
}