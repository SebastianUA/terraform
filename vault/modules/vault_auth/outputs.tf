#---------------------------------------------------
# Vault auth backend
#---------------------------------------------------
output "auth_backend_id" {
  description = "ID of Vault auth backend"
  value       = element(concat(vault_auth_backend.auth_backend.*.id, [""]), 0)
}

output "auth_backend_accessor" {
  description = "The accessor for this auth method"
  value       = element(concat(vault_auth_backend.auth_backend.*.accessor, [""]), 0)
}
