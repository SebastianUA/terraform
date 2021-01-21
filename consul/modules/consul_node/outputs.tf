#---------------------------------------------------
# Consul node
#---------------------------------------------------
output "consul_node_id" {
  description = "ID of Counsul node"
  value       = element(concat(consul_node.node.*.id, [""]), 0)
}

output "consul_node_address" {
  description = "The address of the node."
  value       = element(concat(consul_node.node.*.address, [""]), 0)
}

output "consul_node_name" {
  description = "The name of the node."
  value       = element(concat(consul_node.node.*.name, [""]), 0)
}

output "consul_node_meta" {
  description = "(Optional, map) Key/value pairs that are associated with the node."
  value       = element(concat(consul_node.node.*.meta, [""]), 0)
}
