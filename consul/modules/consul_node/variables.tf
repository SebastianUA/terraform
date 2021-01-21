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
# Consul node
#---------------------------------------------------
variable "enable_node" {
  description = "Enable node for Consul usage"
  default     = false
}

variable "node_name" {
  description = "The name of the node being added to, or referenced in the catalog."
  default     = ""
}

variable "node_address" {
  description = "(Required) The address of the node being added to, or referenced in the catalog."
  default     = ""
}

variable "node_datacenter" {
  description = "(Optional) The datacenter to use. This overrides the agent's default datacenter and the datacenter in the provider setup."
  default     = null
}

variable "node_meta" {
  description = "(Optional, map) Key/value pairs that are associated with the node."
  default     = null
}
