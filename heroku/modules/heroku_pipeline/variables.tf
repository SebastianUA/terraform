#---------------------------------------------------
# Heroku pipeline
#---------------------------------------------------
variable "enable_pipeline" {
  description = "Enable Heroku pipeline usage"
  default     = false
}

variable "pipeline_name" {
  description = "(Required) The name of the pipeline."
  default     = null
}

variable "pipeline_owner" {
  description = "Required) The owner of the pipeline. "
  default     = []
}

#---------------------------------------------------
# Heroku pipeline config var
#---------------------------------------------------
variable "enable_pipeline_config_var" {
  description = "Enable Heroku pipeline config var usage"
  default     = false
}

variable "pipeline_config_var_pipeline_id" {
  description = "The UUID of an existing pipeline."
  default     = ""
}

variable "pipeline_config_var_pipeline_stage" {
  description = "(Required) The pipeline's stage. Supported values are test & review."
  default     = "test"
}

variable "pipeline_config_var_vars" {
  description = "Map of config vars that can be output in plaintext."
  default     = null
}

variable "pipeline_config_var_sensitive_vars" {
  description = "This is the same as vars. The main difference between the two attributes is sensitive_vars outputs are redacted on-screen and replaced by a <sensitive> placeholder, following a terraform plan or apply. It is recommended to put private keys, passwords, etc in this argument."
  default     = null
}

#---------------------------------------------------
# Heroku pipeline coupling
#---------------------------------------------------
variable "enable_pipeline_coupling" {
  description = "Enable Heroku pipeline coupling usage"
  default     = false
}

variable "pipeline_coupling_app" {
  description = "(Required) A Heroku app's UUID. Can also be the name of the Heroku app but UUID is preferred as it is idempotent."
  default     = null
}

variable "pipeline_coupling_pipeline" {
  description = "The ID of the pipeline to add this app to."
  default     = ""
}

variable "pipeline_coupling_stage" {
  description = " (Required) The stage to couple this app to. Must be one of review, development, staging, or production."
  default     = null
}
