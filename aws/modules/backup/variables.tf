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
# AWS Backup plan
#---------------------------------------------------
variable "enable_backup_plan" {
  description = "Enable backup plan usage"
  default     = false
}

variable "backup_plan_name" {
  description = "The display name of a backup plan."
  default     = ""
}

variable "backup_plan_rule" {
  description = "(Required) A rule object that specifies a scheduled task that is used to back up a selection of resources."
  default     = []
}

#---------------------------------------------------
# AWS Backup selection
#---------------------------------------------------
variable "enable_backup_selection" {
  description = "Enable backup selection usage"
  default     = false
}

variable "backup_selection_name" {
  description = "The display name of a resource selection document."
  default     = ""
}

variable "backup_selection_iam_role_arn" {
  description = "The ARN of the IAM role that AWS Backup uses to authenticate when restoring and backing up the target resource. See the AWS Backup Developer Guide for additional information about using AWS managed policies or creating custom policies attached to the IAM role."
  default     = null
}

variable "backup_selection_plan_id" {
  description = "The backup plan ID to be associated with the selection of resources."
  default     = ""
}

variable "backup_selection_resources" {
  description = "(Optional) An array of strings that either contain Amazon Resource Names (ARNs) or match patterns of resources to assign to a backup plan.."
  default     = null
}

variable "backup_selection_selection_tag" {
  description = "(Optional) Tag-based conditions used to specify a set of resources to assign to a backup plan."
  default     = []
}

#---------------------------------------------------
# AWS Backup global settings
#---------------------------------------------------
variable "enable_backup_global_settings" {
  description = "Enable backup global settings usage"
  default     = false
}

variable "backup_global_settings" {
  description = "Required) A list of resources along with the opt-in preferences for the account."
  default = {
    "isCrossAccountBackupEnabled" = "true"
  }
}

#---------------------------------------------------
# AWS Backup region settings
#---------------------------------------------------
variable "enable_backup_region_settings" {
  description = "Enable backup region settings usage"
  default     = false
}

variable "backup_region_settings_resource_type_opt_in_preference" {
  description = "(Required) A map of services along with the opt-in preferences for the Region."
  default = {
    "DynamoDB"        = true
    "Aurora"          = true
    "EBS"             = true
    "EC2"             = true
    "EFS"             = true
    "FSx"             = true
    "RDS"             = true
    "Storage Gateway" = true
  }
}

#---------------------------------------------------
# AWS Backup vault
#---------------------------------------------------
variable "enable_backup_vault" {
  description = "Enable backup vault usage"
  default     = false
}

variable "backup_vault_name" {
  description = "Name of the backup vault to create."
  default     = ""
}

variable "backup_vault_kms_key_arn" {
  description = "(Optional) The server-side encryption key that is used to protect your backups."
  default     = null
}

#---------------------------------------------------
# AWS Backup vault policy
#---------------------------------------------------
variable "enable_backup_vault_policy" {
  description = "Enable backup vault policy usage"
  default     = false
}

variable "backup_vault_policy_backup_vault_name" {
  description = "Name of the backup vault to add policy for."
  default     = ""
}

variable "backup_vault_policy" {
  description = "(Required) The backup vault access policy document in JSON format."
  default     = null
}

#---------------------------------------------------
# AWS Backup vault notifications
#---------------------------------------------------
variable "enable_backup_vault_notifications" {
  description = "Enable backup vault notifications usage"
  default     = false
}

variable "backup_vault_notifications_backup_vault_name" {
  description = "Name of the backup vault to add notifications for."
  default     = ""
}

variable "backup_vault_notifications_sns_topic_arn" {
  description = "(Required) The Amazon Resource Name (ARN) that specifies the topic for a backup vault’s events"
  default     = null
}

variable "backup_vault_notifications_backup_vault_events" {
  description = "(Required) An array of events that indicate the status of jobs to back up resources to the backup vault."
  default     = ["BACKUP_JOB_STARTED", "RESTORE_JOB_COMPLETED"]
}
