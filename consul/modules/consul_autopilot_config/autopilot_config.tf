#---------------------------------------------------
# Consul autopilot config
#---------------------------------------------------
resource "consul_autopilot_config" "autopilot_config" {
  count = var.enable_autopilot_config ? 1 : 0

  cleanup_dead_servers   = var.autopilot_config_cleanup_dead_servers
  last_contact_threshold = var.autopilot_config_last_contact_threshold
  max_trailing_logs      = var.autopilot_config_max_trailing_logs

  datacenter                = var.autopilot_config_datacenter
  server_stabilization_time = var.autopilot_config_server_stabilization_time
  redundancy_zone_tag       = var.autopilot_config_redundancy_zone_tag
  disable_upgrade_migration = var.autopilot_config_disable_upgrade_migration
  upgrade_version_tag       = var.autopilot_config_upgrade_version_tag

  depends_on = []
}
