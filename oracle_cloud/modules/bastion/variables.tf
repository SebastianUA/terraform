#-----------------------------------------------------------
# Global
#-----------------------------------------------------------
variable "name" {
  description = "The name for resources"
  default     = "test"
}

variable "environment" {
  description = "The environment for resources"
  default     = "dev"
}

variable "tags" {
  description = "Add additional tags"
  default     = {}
}

#-----------------------------------------------------------
# bastion bastion
#-----------------------------------------------------------
variable "enable_bastion" {
  description = "Enable bastion usage"
  default     = false
}

variable "bastion_bastion_type" {
  description = "(Required) The type of bastion. Use standard"
  default     = null
}

variable "bastion_compartment_id" {
  description = "(Required) (Updatable) The unique identifier (OCID) of the compartment where the bastion is located."
  default     = null
}

variable "bastion_target_subnet_id" {
  description = "(Required) The unique identifier (OCID) of the subnet that the bastion connects to."
  default     = null
}

variable "bastion_name" {
  description = "(Optional) The name of the bastion, which can't be changed after creation."
  default     = ""
}


variable "bastion_client_cidr_block_allow_list" {
  description = "(Optional) (Updatable) A list of address ranges in CIDR notation that you want to allow to connect to sessions hosted by this bastion."
  default     = null
}

variable "bastion_dns_proxy_status" {
  description = "(Optional) Flag to enable FQDN and SOCKS5 Proxy Support. Example: ENABLED, DISABLED"
  default     = null
}

variable "bastion_max_session_ttl_in_seconds" {
  description = "(Optional) (Updatable) The maximum amount of time that any session on the bastion can remain active."
  default     = null
}

variable "bastion_phone_book_entry" {
  description = "(Optional) The phonebook entry of the customer's team, which can't be changed after creation. Not applicable to standard bastions."
  default     = null
}

variable "bastion_static_jump_host_ip_addresses" {
  description = "(Optional) (Updatable) A list of IP addresses of the hosts that the bastion has access to. Not applicable to standard bastions."
  default     = null
}


variable "bastion_freeform_tags" {
  description = "(Optional) (Updatable) Simple key-value pair that is applied without any predefined name, type or scope. Exists for cross-compatibility only. Example: {'bar-key': 'value'}"
  default     = null
}

variable "bastion_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Bastion * update - (Defaults to 20 minutes), when updating the Bastion * delete - (Defaults to 20 minutes), when destroying the Bastion"
  default     = {}
}

#-----------------------------------------------------------
# bastion session
#-----------------------------------------------------------
variable "enable_session" {
  description = "Enable session usages"
  default     = false
}

variable "session_bastion_id" {
  description = "The unique identifier (OCID) of the bastion that is hosting this session."
  default     = ""
}

variable "session_key_details" {
  description = "Public key details for a bastion session."
  default     = {}
}

variable "session_target_resource_details" {
  description = "Details about a bastion session's target resource."
  default     = {}
}

variable "session_display_name" {
  description = "(Optional) (Updatable) The name of the session."
  default     = ""
}

variable "session_key_type" {
  description = "(Optional) The type of the key used to connect to the session. PUB is a standard public key in OpenSSH format."
  default     = null
}

variable "session_session_ttl_in_seconds" {
  description = "(Optional) The amount of time the session can remain active."
  default     = null
}

variable "session_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Session * update - (Defaults to 20 minutes), when updating the Session * delete - (Defaults to 20 minutes), when destroying the Session"
  default     = {}
}
