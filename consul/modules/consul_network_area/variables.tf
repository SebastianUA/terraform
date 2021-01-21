#---------------------------------------------------
# Consul network area
#---------------------------------------------------
variable "enable_network_area" {
  description = "Enable network area for Consul usage"
  default     = false
}

variable "network_area_peer_datacenter" {
  description = "(Required) The name of the Consul datacenter that will be joined to form the area."
  default     = null
}

variable "network_area_retry_join" {
  description = "(Optional) Specifies a list of Consul servers to attempt to join. Servers can be given as IP, IP:port, hostname, or hostname:port"
  default     = null
}

variable "network_area_use_tls" {
  description = "(Optional) Specifies whether gossip over this area should be encrypted with TLS if possible. Defaults to false."
  default     = null
}

variable "network_area_datacenter" {
  description = "(Optional) The datacenter to use. This overrides the agent's default datacenter and the datacenter in the provider setup."
  default     = null
}

variable "network_area_token" {
  description = "(Optional) The ACL token to use. This overrides the token that the agent provides by default."
  default     = null
}
