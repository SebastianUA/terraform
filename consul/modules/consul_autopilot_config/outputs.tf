#---------------------------------------------------
# Consul autopilot config
#---------------------------------------------------
output "consul_autopilot_config_id" {
  description = "ID of Counsul autopilot config"
  value       = element(concat(consul_autopilot_config.autopilot_config.*.id, [""]), 0)
}

output "consul_autopilot_config_datacenter" {
  description = "The datacenter used."
  value       = element(concat(consul_autopilot_config.autopilot_config.*.datacenter, [""]), 0)
}

output "consul_autopilot_config_cleanup_dead_servers" {
  description = "Whether to remove failing servers."
  value       = element(concat(consul_autopilot_config.autopilot_config.*.cleanup_dead_servers, [""]), 0)
}

output "consul_autopilot_config_last_contact_threshold" {
  description = "The time after which a server is considered as unhealthy and will be removed."
  value       = element(concat(consul_autopilot_config.autopilot_config.*.last_contact_threshold, [""]), 0)
}

output "consul_autopilot_config_max_trailing_logs" {
  description = "The maximum number of Raft log entries a server can trail the leader."
  value       = element(concat(consul_autopilot_config.autopilot_config.*.max_trailing_logs, [""]), 0)
}

output "consul_autopilot_config_server_stabilization_time" {
  description = "The period to wait for a server to be healthy and stable before being promoted to a full, voting member."
  value       = element(concat(consul_autopilot_config.autopilot_config.*.server_stabilization_time, [""]), 0)
}

output "consul_autopilot_config_redundancy_zone_tag" {
  description = "The redundancy zone tag used. Consul will try to keep one voting server by zone to take advantage of isolated failure domains."
  value       = element(concat(consul_autopilot_config.autopilot_config.*.redundancy_zone_tag, [""]), 0)
}

output "consul_autopilot_config_disable_upgrade_migration" {
  description = "Whether to disable upgrade migrations."
  value       = element(concat(consul_autopilot_config.autopilot_config.*.disable_upgrade_migration, [""]), 0)
}

output "consul_autopilot_config_upgrade_version_tag" {
  description = "The tag to override the version information used during a migration."
  value       = element(concat(consul_autopilot_config.autopilot_config.*.upgrade_version_tag, [""]), 0)
}
