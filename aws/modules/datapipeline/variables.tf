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
# AWS datapipeline pipeline
#---------------------------------------------------
variable "enable_datapipeline_pipeline" {
  description   = "Enable datapipeline pipeline usage"
  default       = false
}

variable "datapipeline_pipeline_name" {
  description   = "The name of Pipeline."
  default       = ""
}

variable "datapipeline_pipeline_description" {
  description   = "(Optional) The description of Pipeline."
  default       = null
}
