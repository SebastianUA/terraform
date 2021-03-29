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
# AWS serverlessapplicationrepository cloudformation stack
#---------------------------------------------------
variable "enable_serverlessapplicationrepository_cloudformation_stack" {
  description = "Enable serverlessapplicationrepository cloudformation stack usage"
  default     = false
}

variable "serverlessapplicationrepository_cloudformation_stack_name" {
  description = "The name of the stack to create. The resource deployed in AWS will be prefixed with serverlessrepo-"
  default     = ""
}

variable "serverlessapplicationrepository_cloudformation_stack_application_id" {
  description = "(Required) The ARN of the application from the Serverless Application Repository."
  default     = null
}

variable "serverlessapplicationrepository_cloudformation_stack_capabilities" {
  description = "(Required) A list of capabilities. Valid values are CAPABILITY_IAM, CAPABILITY_NAMED_IAM, CAPABILITY_RESOURCE_POLICY, or CAPABILITY_AUTO_EXPAND"
  default     = null
}

variable "serverlessapplicationrepository_cloudformation_stack_parameters" {
  description = "(Optional) A map of Parameter structures that specify input parameters for the stack."
  default     = null
}

variable "serverlessapplicationrepository_cloudformation_stack_semantic_version" {
  description = "(Optional) The version of the application to deploy. If not supplied, deploys the latest version."
  default     = null
}
