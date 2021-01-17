#---------------------------------------------------
# Vault generic secret
#---------------------------------------------------
output "generic_secret_id" {
  description = "ID of Vault generic secret"
  value       = element(concat(vault_generic_secret.generic_secret.*.id, [""]), 0)
}

#---------------------------------------------------
# Vault generic endpoint
#---------------------------------------------------
output "generic_endpoint_id" {
  description = "ID of Vault generic endpoint"
  value       = element(concat(vault_generic_endpoint.generic_endpoint.*.id, [""]), 0)
}
