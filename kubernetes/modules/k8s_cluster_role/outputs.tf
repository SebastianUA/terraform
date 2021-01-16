#---------------------------------------------------
# Kubernetes cluster role
#---------------------------------------------------
output "cluster_role_id" {
  description = "ID of Kubernetes cluster_role"
  value       = element(concat(kubernetes_cluster_role.cluster_role.*.id, [""]), 0)
}

#---------------------------------------------------
# Kubernetes cluster role binding
#---------------------------------------------------
output "cluster_role_binding_id" {
  description = "ID of Kubernetes cluster_role_binding"
  value       = element(concat(kubernetes_cluster_role_binding.cluster_role_binding.*.id, [""]), 0)
}