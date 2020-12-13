#---------------------------------------------------
# Kubernetes namespace
#---------------------------------------------------
output "namespace_id" {
  description = "ID of Kubernetes namespace"
  value       = element(concat(kubernetes_namespace.namespace.*.id, [""]), 0)
}
