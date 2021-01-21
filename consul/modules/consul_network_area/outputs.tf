#---------------------------------------------------
# Consul network area
#---------------------------------------------------
output "consul_network_area_id" {
  description = "ID of Counsul network area"
  value       = element(concat(consul_network_area.network_area.*.id, [""]), 0)
}
