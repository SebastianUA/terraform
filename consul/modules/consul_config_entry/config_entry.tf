#---------------------------------------------------
# Consul config entry
#---------------------------------------------------
resource "consul_config_entry" "config_entry" {
  count = var.enable_config_entry ? 1 : 0

  name = var.config_entry_name != "" ? var.config_entry_name : "${var.name}-${var.environment}-config-entry"
  kind = var.config_entry_kind

  config_json = var.config_entry_config_json

  depends_on = []
}