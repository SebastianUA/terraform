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
# AWS Codecommit repository
#---------------------------------------------------
variable "enable_codecommit_repository" {
  description = "Enable codecommit repository usage"
  default     = false
}

variable "codecommit_repository_name" {
  description = "Set name for codecommit repository. The name for the repository. This needs to be less than 100 characters."
  default     = ""
}

variable "codecommit_repository_description" {
  description = "(Optional) The description of the repository. This needs to be less than 1000 characters"
  default     = null
}

variable "codecommit_repository_default_branch" {
  description = "(Optional) The default branch of the repository. The branch specified here needs to exist."
  default     = null
}

#---------------------------------------------------
# AWS Codecommit trigger
#---------------------------------------------------
variable "enable_codecommit_trigger" {
  description = "Enable codecommit trigger usage"
  default     = false
}

variable "codecommit_trigger_repository_name" {
  description = "Set repo name for codecommit trigger"
  default     = ""
}

variable "codecommit_trigger_triggers" {
  description = "Set codecommit triggers params"
  default     = []
}

// variable "codecommit_trigger_name" {
//   description = "The name of the trigger."
//   default     = ""
// }

// variable "codecommit_trigger_destination_arn" {
//   description = "(Required) The ARN of the resource that is the target for a trigger. For example, the ARN of a topic in Amazon Simple Notification Service (SNS)."
//   default     = null
// }

// variable "codecommit_trigger_events" {
//   description = "(Required) The repository events that will cause the trigger to run actions in another service, such as sending a notification through Amazon Simple Notification Service (SNS). If no events are specified, the trigger will run for all repository events. Event types include: all, updateReference, createReference, deleteReference."
//   default     = null
// }

// variable "codecommit_trigger_custom_data" {
//   description = "(Optional) Any custom data associated with the trigger that will be included in the information sent to the target of the trigger."
//   default     = null
// }

// variable "codecommit_trigger_branches" {
//   description = "(Optional) The branches that will be included in the trigger configuration. If no branches are specified, the trigger will apply to all branches."
//   default     = null
// }

#---------------------------------------------------
# AWS Codecommit approval rule template
#---------------------------------------------------
variable "enable_codecommit_approval_rule_template" {
  description = "Enable codecommit approval rule template usage"
  default     = false
}

variable "codecommit_approval_rule_template_name" {
  description = "The name for the approval rule template. Maximum of 100 characters."
  default     = ""
}

variable "codecommit_approval_rule_template_content" {
  description = "(Required) The content of the approval rule template. Maximum of 3000 characters."
  default     = ""
}

variable "codecommit_approval_rule_template_description" {
  description = "(Optional) The description of the approval rule template. Maximum of 1000 characters."
  default     = null
}

#---------------------------------------------------
# AWS Codecommit approval rule template association
#---------------------------------------------------
variable "enable_codecommit_approval_rule_template_association" {
  description = "Enable codecommit approval rule template association usage"
  default     = false
}

variable "codecommit_approval_rule_template_association_approval_rule_template_name" {
  description = "The name for the approval rule template."
  default     = ""
}

variable "codecommit_approval_rule_template_association_repository_name" {
  description = "The name of the repository that you want to associate with the template."
  default     = ""
}
