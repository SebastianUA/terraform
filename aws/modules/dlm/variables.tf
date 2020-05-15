#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST"
}

variable "region" {
    description = "The region where to deploy this code (e.g. us-east-1)."
    default     = "us-east-1"
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
# AWS DLM lifecycle_policy
#---------------------------------------------------
variable "enable_dlm_lifecycle_policy" {
  description   = "Enable dlm lifecycle policy"
  default       = false
}

variable "dlm_lifecycle_policy_name" {
  description   = "Set dlm lifecycle policy name"
  default       = ""
}

variable "dlm_lifecycle_policy_description" {
  description   = "A description for the DLM lifecycle policy."
  default       = ""
}

variable "dlm_lifecycle_policy_execution_role_arn" {
  description   = "(Required) The ARN of an IAM role that is able to be assumed by the DLM service."
  default       = null
}

variable "dlm_lifecycle_policy_state" {
  description   = "(Optional) Whether the lifecycle policy should be enabled or disabled. ENABLED or DISABLED are valid values. Defaults to ENABLED."
  default       = "ENABLED"
}

variable "dlm_lifecycle_policy_details_resource_types" {
  description   = "(Required) A list of resource types that should be targeted by the lifecycle policy. VOLUME is currently the only allowed value."
  default       = ["VOLUME"]
}

variable "dlm_lifecycle_policy_details_schedule_name" {
  description   = "A name for the schedule."
  default       = ""
}

variable "dlm_lifecycle_policy_details_schedule_create_rule_interval" {
  description   = "(Required) How often this lifecycle policy should be evaluated. 1, 2,3,4,6,8,12 or 24 are valid values."
  default       = 24
}

variable "dlm_lifecycle_policy_details_schedule_create_rule_interval_unit" {
  description   = "(Optional) The unit for how often the lifecycle policy should be evaluated. HOURS is currently the only allowed value and also the default value."
  default       = "HOURS"
}

variable "dlm_lifecycle_policy_details_schedule_create_rule_times" {
  description   = "(Optional) A list of times in 24 hour clock format that sets when the lifecycle policy should be evaluated. Max of 1."
  default       = ["23:45"]
}

variable "dlm_lifecycle_policy_details_schedule_retain_rule_count" {
  description   = "(Required) How many snapshots to keep. Must be an integer between 1 and 1000."
  default       = 14
}

variable "dlm_lifecycle_policy_details_schedule_copy_tags" {
  description   = "(Optional) Copy all user-defined tags on a source volume to snapshots of the volume created by this policy."
  default       = false
}


variable "target_tags" {
  description = "(Required) A map of tag keys and their values. Any resources that match the resource_types and are tagged with any of these tags will be targeted."
  default     = {}
}

variable "tags_to_add" {
  description = "(Optional) A map of tag keys and their values. DLM lifecycle policies will already tag the snapshot with the tags on the volume. This configuration adds extra tags on top of these."
  default     = {}
}
