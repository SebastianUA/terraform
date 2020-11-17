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
# AWS accessanalyzer analyzer
#---------------------------------------------------
variable "enable_accessanalyzer_analyzer" {
  description = "Enable accessanalyzer analyzer usage"
  default     = false
}

variable "accessanalyzer_analyzer_name" {
  description = "Set mame of the Analyzer."
  default     = ""
}

variable "accessanalyzer_analyzer_type" {
  description = "(Optional) Type of Analyzer. Valid value is currently only ACCOUNT. Defaults to ACCOUNT."
  default     = "ACCOUNT"
}
