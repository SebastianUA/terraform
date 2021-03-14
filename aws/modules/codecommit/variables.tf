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

variable "codecommit_trigger" {
  description = "Set codecommit trigger params"
  default     = []
}
