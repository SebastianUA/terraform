#---------------------------------------------------
# Vault namespace
#---------------------------------------------------
output "namespace_id" {
  description = "ID of the namespace."
  value       = element(concat(vault_namespace.namespace.*.id, [""]), 0)
}
