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
# Consul service
#---------------------------------------------------
variable "enable_service" {
  description = "Enable service for Consul usage"
  default     = false
}

variable "service_name" {
  description = "The name of the service."
  default     = ""
}

variable "service_node" {
  description = "(Required, string) The name of the node the to register the service on."
  default     = null
}

variable "service_datacenter" {
  description = "(Optional) The datacenter to use. This overrides the agent's default datacenter and the datacenter in the provider setup."
  default     = null
}

variable "service_meta" {
  description = "(Optional) A map of arbitrary KV metadata linked to the service instance."
  default     = null
}

variable "service_namespace" {
  description = "(Optional, Enterprise Only) The namespace to create the service within."
  default     = null
}

variable "service_address" {
  description = "(Optional, string) The address of the service. Defaults to the address of the node."
  default     = null
}

variable "service_port" {
  description = "(Optional, int) The port of the service."
  default     = null
}

variable "service_service_id" {
  description = "(Optional, string) - If the service ID is not provided, it will be defaulted to the value of the name attribute."
  default     = null
}

variable "service_enable_tag_override" {
  description = "(Optional, boolean) Specifies to disable the anti-entropy feature for this service's tags. Defaults to false"
  default     = null
}

variable "service_check" {
  description = "(Optional, list of checks) Health-checks to register to monitor the service."
  default     = []
}

variable "service_tags" {
  description = "(Optional, set of strings) A list of values that are opaque to Consul, but can be used to distinguish between services or nodes."
  default     = null
}
