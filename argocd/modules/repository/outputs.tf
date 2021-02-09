#-----------------------------------------------------------
# ArgoCD repository
#-----------------------------------------------------------
output "argocd_repository_id" {
  description = "The ID of argocd repository"
  value       = element(concat(argocd_repository.repository.*.id, [""]), 0)
}

output "argocd_repository_connection_state_status" {
  description = "string, repository connection state status."
  value       = element(concat(argocd_repository.repository.*.connection_state_status, [""]), 0)
}

output "argocd_repository_inherited_creds" {
  description = "boolean, whether credentials wre inherited fron a credential set."
  value       = element(concat(argocd_repository.repository.*.inherited_creds, [""]), 0)
}

#---------------------------------------------------
# ArgoCD repository credentials
#---------------------------------------------------
output "argocd_repository_credentials_id" {
  description = "The ID of argocd repository credentials"
  value       = element(concat(argocd_repository_credentials.repository_credentials.*.id, [""]), 0)
}