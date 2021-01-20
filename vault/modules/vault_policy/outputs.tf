#---------------------------------------------------
# Vault policy
#---------------------------------------------------
output "vault_policy_id" {
  description = "ID of Vault policy"
  value       = element(concat(vault_policy.policy.*.id, [""]), 0)
}

#---------------------------------------------------
# Vault rgp policy
#---------------------------------------------------
output "vault_rgp_policy_id" {
  description = "ID of Vault rgp policy"
  value       = element(concat(vault_rgp_policy.rgp_policy.*.id, [""]), 0)
}

#---------------------------------------------------
# Vault egp policy
#---------------------------------------------------
output "vault_egp_policy_id" {
  description = "ID of Vault egp policy"
  value       = element(concat(vault_egp_policy.egp_policy.*.id, [""]), 0)
}
