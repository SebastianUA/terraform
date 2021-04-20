#---------------------------------------------------
# Kubernetes role
#---------------------------------------------------
output "role_id" {
  description = "ID of Kubernetes role"
  value       = element(concat(kubernetes_role.role.*.id, [""]), 0)
}

#---------------------------------------------------
# Kubernetes cluster role binding
#---------------------------------------------------
output "role_binding_id" {
  description = "ID of Kubernetes role_binding"
  value       = element(concat(kubernetes_role_binding.role_binding.*.id, [""]), 0)
}
