#---------------------------------------------------
# Consul intention
#---------------------------------------------------
variable "enable_intention" {
  description = "Enable intention for Consul usage"
  default     = false
}

variable "intention_source_name" {
  description = "(Required, string) The name of the source service for the intention. This service does not have to exist."
  default     = null
}

variable "intention_destination_name" {
  description = "(Required, string) The name of the destination service for the intention. This service does not have to exist."
  default     = null
}

variable "intention_action" {
  description = "(Required, string) The intention action. Must be one of allow or deny."
  default     = null
}

variable "intention_description" {
  description = "(Optional, string) Optional description that can be used by Consul tooling, but is not used internally."
  default     = null
}

variable "intention_datacenter" {
  description = "(Optional) The datacenter to use. This overrides the agent's default datacenter and the datacenter in the provider setup."
  default     = null
}

variable "intention_source_namespace" {
  description = "(Optional, Enterprise Only) The source namespace of the intention."
  default     = null
}

variable "intention_destination_namespace" {
  description = "(Optional, Enterprise Only) The destination namespace of the intention."
  default     = null
}

variable "intention_meta" {
  description = "(Optional, map) Key/value pairs that are opaque to Consul and are associated with the intention."
  default     = null
}
