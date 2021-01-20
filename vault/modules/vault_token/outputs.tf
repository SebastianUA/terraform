#---------------------------------------------------
# Vault token
#---------------------------------------------------
output "vault_token_id" {
  description = "ID of Vault token"
  value       = element(concat(vault_token.token.*.id, [""]), 0)
}

output "vault_token_lease_duration" {
  description = "String containing the token lease duration if present in state file"
  value       = element(concat(vault_token.token.*.lease_duration, [""]), 0)
}

output "vault_token_lease_started" {
  description = "String containing the token lease started time if present in state file"
  value       = element(concat(vault_token.token.*.lease_started, [""]), 0)
}

output "vault_token_client_token" {
  description = "String containing the client token if stored in present file"
  value       = element(concat(vault_token.token.*.client_token, [""]), 0)
}

output "vault_token_encrypted_client_token" {
  description = "String containing the client token encrypted with the given pgp_key if stored in present file"
  value       = element(concat(vault_token.token.*.encrypted_client_token, [""]), 0)
}

#---------------------------------------------------
# Vault token auth backend role
#---------------------------------------------------
output "token_auth_backend_role_id" {
  description = "ID of Vault token auth backend role"
  value       = element(concat(vault_token_auth_backend_role.token_auth_backend_role.*.id, [""]), 0)
}
