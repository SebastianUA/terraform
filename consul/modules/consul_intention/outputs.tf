#---------------------------------------------------
# Consul intention
#---------------------------------------------------
output "consul_intention_id" {
  description = "ID of Counsul intention"
  value       = element(concat(consul_intention.intention.*.id, [""]), 0)
}

output "consul_intention_source_name" {
  description = "The source for the intention."
  value       = element(concat(consul_intention.intention.*.source_name, [""]), 0)
}

output "consul_intention_source_namespace" {
  description = "The source namespace of the intention."
  value       = element(concat(consul_intention.intention.*.source_namespace, [""]), 0)
}

output "consul_intention_destination_name" {
  description = "The destination for the intention."
  value       = element(concat(consul_intention.intention.*.destination_name, [""]), 0)
}

output "consul_intention_destination_namespace" {
  description = "The destination namespace of the intention."
  value       = element(concat(consul_intention.intention.*.destination_namespace, [""]), 0)
}

output "consul_intention_action" {
  description = "The intention action."
  value       = element(concat(consul_intention.intention.*.action, [""]), 0)
}

output "consul_intention_description" {
  description = "A description of the intention."
  value       = element(concat(consul_intention.intention.*.description, [""]), 0)
}

output "consul_intention_meta" {
  description = "Key/value pairs associated with the intention."
  value       = element(concat(consul_intention.intention.*.meta, [""]), 0)
}

output "consul_intention_datacenter" {
  description = "The datacenter in which the intention is created."
  value       = element(concat(consul_intention.intention.*.datacenter, [""]), 0)
}
