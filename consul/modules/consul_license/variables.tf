#---------------------------------------------------
# Consul license
#---------------------------------------------------
variable "enable_license" {
  description = "Enable license for Consul usage"
  default     = false
}

variable "license" {
  description = "(Required) The Consul license to use."
  default     = null
}

variable "license_datacenter" {
  description = "(Optional) The datacenter to use. This overrides the agent's default datacenter and the datacenter in the provider setup."
  default     = null
}
