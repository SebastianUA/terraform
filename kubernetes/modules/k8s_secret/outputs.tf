#---------------------------------------------------
# Kubernetes secret
#---------------------------------------------------
output "secret_id" {
  description = "ID of Kubernetes secret"
  value       = element(concat(kubernetes_secret.secret.*.id, [""]), 0)
}
