#---------------------------------------------------
# Consul service
#---------------------------------------------------
output "consul_service_id" {
  description = "ID of Counsul service"
  value       = element(concat(consul_service.service.*.id, [""]), 0)
}

output "consul_service_service_id" {
  description = "The ID of the service."
  value       = element(concat(consul_service.service.*.service_id, [""]), 0)
}

output "consul_service_address" {
  description = "The address of the service."
  value       = element(concat(consul_service.service.*.address, [""]), 0)
}

output "consul_service_node" {
  description = "The node the service is registered on."
  value       = element(concat(consul_service.service.*.node, [""]), 0)
}

output "consul_service_name" {
  description = "The name of the service."
  value       = element(concat(consul_service.service.*.name, [""]), 0)
}

output "consul_service_port" {
  description = "The port of the service."
  value       = element(concat(consul_service.service.*.port, [""]), 0)
}

output "consul_service_tags" {
  description = "The tags of the service."
  value       = consul_service.service.*.tags
}

output "consul_service_check" {
  description = "The list of health-checks associated with the service."
  value       = element(concat(consul_service.service.*.check, [""]), 0)
}

output "consul_service_datacenter" {
  description = "The datacenter of the service."
  value       = element(concat(consul_service.service.*.datacenter, [""]), 0)
}

output "consul_service_service_meta" {
  description = "A map of arbitrary KV metadata linked to the service instance."
  value       = element(concat(consul_service.service.*.meta, [""]), 0)
}
