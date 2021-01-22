#---------------------------------------------------
# Consul autopilot config
#---------------------------------------------------
variable "enable_autopilot_config" {
  description = "Enable autopilot config for Consul usage"
  default     = false
}

variable "autopilot_config_cleanup_dead_servers" {
  description = "(Optional) Whether to remove failing servers when a replacement comes online. Defaults to true."
  default     = null
}

variable "autopilot_config_last_contact_threshold" {
  description = "(Optional) The time after which a server is considered as unhealthy and will be removed. Defaults to '200ms'"
  default     = null
}

variable "autopilot_config_max_trailing_logs" {
  description = "(Optional) The maximum number of Raft log entries a server can trail the leader. Defaults to 250."
  default     = null
}

variable "autopilot_config_datacenter" {
  description = "(Optional) The datacenter to use. This overrides the agent's default datacenter and the datacenter in the provider setup."
  default     = null
}

variable "autopilot_config_server_stabilization_time" {
  description = "(Optional) The period to wait for a server to be healthy and stable before being promoted to a full, voting member. Defaults to '10s'."
  default     = null
}

variable "autopilot_config_redundancy_zone_tag" {
  description = "(Optional) The redundancy zone tag to use. Consul will try to keep one voting server by zone to take advantage of isolated failure domains. Defaults to an empty string."
  default     = null
}

variable "autopilot_config_disable_upgrade_migration" {
  description = "(Optional) Whether to disable upgrade migrations. Defaults to false."
  default     = null
}

variable "autopilot_config_upgrade_version_tag" {
  description = "(Optional) The tag to override the version information used during a migration. Defaults to an empty string."
  default     = null
}
