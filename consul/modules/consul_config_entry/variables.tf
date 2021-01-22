#-----------------------------------------------------------
# Global
#-----------------------------------------------------------
variable "name" {
  description = "Set name for Consul namespace if doesnt set config entry's name properly"
  default     = false
}

variable "environment" {
  description = "Set env for Consul config entry if does not set name"
  default     = "dev"
}

#---------------------------------------------------
# Consul config entry
#---------------------------------------------------
variable "enable_config_entry" {
  description = "Enable config entry for Consul usage"
  default     = false
}

variable "config_entry_name" {
  description = "The name of the configuration entry being registred."
  default     = ""
}

variable "config_entry_kind" {
  description = "(Required) The kind of configuration entry to register."
  default     = null
}

variable "config_entry_config_json" {
  description = "(Optional) An arbitrary map of configuration values."
  default     = null
}