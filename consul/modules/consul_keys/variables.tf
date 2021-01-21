#-----------------------------------------------------------
# Global
#-----------------------------------------------------------

#---------------------------------------------------
# Consul keys
#---------------------------------------------------
variable "enable_keys" {
  description = "Enable keys for Consul usage"
  default     = false
}

variable "keys_datacenter" {
  description = "(Optional) The datacenter to use. This overrides the agent's default datacenter and the datacenter in the provider setup."
  default     = null
}

variable "keys_token" {
  description = "(Optional) The ACL token to use. This overrides the token that the agent provides by default."
  default     = null
}

variable "keys_namespace" {
  description = "(Optional, Enterprise Only) The namespace to create the keys within."
  default     = null
}

variable "consul_keys" {
  description = "(Required) Specifies a key in Consul to be written. "
  default     = []
}

#---------------------------------------------------
# Consul key prefix
#---------------------------------------------------
variable "enable_key_prefix" {
  description = "Enable key prefix usage"
  default     = false
}

variable "key_prefix_path_prefix" {
  description = "(Required) Specifies the common prefix shared by all keys that will be managed by this resource instance. In most cases this will end with a slash, to manage a 'folder' of keys."
  default     = null
}

variable "key_prefix_datacenter" {
  description = "(Optional) The datacenter to use. This overrides the agent's default datacenter and the datacenter in the provider setup."
  default     = null
}

variable "key_prefix_token" {
  description = "(Optional) The ACL token to use. This overrides the token that the agent provides by default."
  default     = null
}

variable "key_prefix_namespace" {
  description = "(Optional, Enterprise Only) The namespace to create the keys within."
  default     = null
}

variable "key_prefix_subkeys" {
  description = "(Optional) A mapping from subkey name (which will be appended to the given path_prefix) to the value that should be stored at that key. Use slashes, as shown in the above example, to create 'sub-folders' under the given path prefix."
  default     = null
}

variable "key_prefix_subkey" {
  description = "(Optional) A subkey to add. Supported values documented below. Multiple blocks supported."
  default     = []
}
