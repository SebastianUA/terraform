#---------------------------------------------------
# Consul namespace
#---------------------------------------------------
output "consul_namespace_id" {
  description = "ID of Counsul namespace"
  value       = element(concat(consul_namespace.namespace.*.id, [""]), 0)
}

output "consul_namespace_name" {
  description = "The namespace name."
  value       = element(concat(consul_namespace.namespace.*.name, [""]), 0)
}

output "consul_namespace_description" {
  description = "The namespace description."
  value       = element(concat(consul_namespace.namespace.*.description, [""]), 0)
}

output "consul_namespace_policy_defaults" {
  description = "The list of default policies that will be applied to all tokens created in this namespace."
  value       = element(concat(consul_namespace.namespace.*.policy_defaults, [""]), 0)
}

output "consul_namespace_role_defaults" {
  description = "The list of default roles that will be applied to all tokens created in this namespace."
  value       = element(concat(consul_namespace.namespace.*.role_defaults, [""]), 0)
}

output "consul_namespace_meta" {
  description = "Arbitrary KV metadata associated with the namespace."
  value       = element(concat(consul_namespace.namespace.*.meta, [""]), 0)
}
