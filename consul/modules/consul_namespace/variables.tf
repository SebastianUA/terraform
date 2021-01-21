#-----------------------------------------------------------
# Global
#-----------------------------------------------------------
variable "name" {
  description = "Set name for Consul namespace if doesnt set namespace's name properly"
  default     = false
}

variable "environment" {
  description = "Set env for Consul namespace if does not set name"
  default     = "dev"
}

#---------------------------------------------------
# Consul namespace
#---------------------------------------------------
variable "enable_namespace" {
  description = "Enable namespace for Consul usage"
  default     = false
}

variable "namespace_name" {
  description = "The namespace name."
  default     = ""
}

variable "namespace_description" {
  description = "(Optional) Free form namespace description."
  default     = null
}

variable "namespace_policy_defaults" {
  description = "(Optional) The list of default policies that should be applied to all tokens created in this namespace."
  default     = null
}

variable "namespace_role_defaults" {
  description = "(Optional) The list of default roles that should be applied to all tokens created in this namespace."
  default     = null
}

variable "namespace_meta" {
  description = "(Optional) Specifies arbitrary KV metadata to associate with the namespace."
  default     = null
}
