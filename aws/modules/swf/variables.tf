#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
# variable "name" {
#   description = "Name to be used on all resources as prefix"
#   default     = "TEST"
# }

# variable "environment" {
#     description = "Environment for service"
#     default     = "STAGE"
# }

variable "tags" {
  description = "A list of tag blocks. Each element should have keys named key, value, etc."
  type        = map(string)
  default     = {}
}

#---------------------------------------------------
# AWS swf domain
#---------------------------------------------------
variable "enable_swf_domain" {
  description = "Enable swf domain usage"
  default     = false
}

variable "swf_domain_name" {
  description = "(Optional, Forces new resource) The name of the domain. If omitted, Terraform will assign a random, unique name."
  default     = ""
}

variable "swf_domain_name_prefix" {
  description = "(Optional, Forces new resource) Creates a unique name beginning with the specified prefix. Conflicts with swf_domain_name."
  default     = ""
}

variable "swf_domain_description" {
  description = "(Optional, Forces new resource) The domain description."
  default     = null
}

variable "swf_domain_workflow_execution_retention_period_in_days" {
  description = "(Required, Forces new resource) Length of time that SWF will continue to retain information about the workflow execution after the workflow execution is complete, must be between 0 and 90 days."
  default     = 0
}
