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
# AWS codepipeline
#---------------------------------------------------
variable "enable_codepipeline" {
  description = "Enable codepipeline usage"
  default     = false
}

variable "codepipeline_stack" {
  description = "Set properties for Codepipeline."
  default     = []
}

#---------------------------------------------------
# AWS codepipeline webhook
#---------------------------------------------------
variable "enable_codepipeline_webhook" {
  description = "Enable codepipeline webhook usage"
  default     = false
}

variable "codepipeline_webhook_stack" {
  description = "Set properties for codepipeline webhook"
  default     = []
}
