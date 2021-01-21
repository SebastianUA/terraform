#---------------------------------------------------
# Consul keys
#---------------------------------------------------
output "consul_keys_id" {
  description = "ID of Counsul keys"
  value       = element(concat(consul_keys.keys.*.id, [""]), 0)
}

output "consul_keys_datacenter" {
  description = "The datacenter the keys are being written to."
  value       = element(concat(consul_keys.keys.*.datacenter, [""]), 0)
}

#---------------------------------------------------
# Consul key prefix
#---------------------------------------------------
output "consul_key_prefix_id" {
  description = "ID of Counsul key prefix"
  value       = element(concat(consul_key_prefix.key_prefix.*.id, [""]), 0)
}

output "consul_key_prefix_datacenter" {
  description = "The datacenter the keys are being read/written to."
  value       = element(concat(consul_key_prefix.key_prefix.*.datacenter, [""]), 0)
}
