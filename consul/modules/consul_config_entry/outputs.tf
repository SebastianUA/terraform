#---------------------------------------------------
# Consul config entry
#---------------------------------------------------
output "consul_config_entry_id" {
  description = "The id of the configuration entry."
  value       = element(concat(consul_config_entry.config_entry.*.id, [""]), 0)
}

output "consul_config_entry_kind" {
  description = "The kind of the configuration entry."
  value       = element(concat(consul_config_entry.config_entry.*.kind, [""]), 0)
}

output "consul_config_entry_name" {
  description = "The name of the configuration entry."
  value       = element(concat(consul_config_entry.config_entry.*.name, [""]), 0)
}

output "consul_config_entry_config_json" {
  description = "A map of configuration values."
  value       = element(concat(consul_config_entry.config_entry.*.config_json, [""]), 0)
}
