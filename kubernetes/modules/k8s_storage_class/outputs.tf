#---------------------------------------------------
# Kubernetes storage_class
#---------------------------------------------------
output "storage_class_id" {
  description = "ID of Kubernetes storage_class"
  value       = element(concat(kubernetes_storage_class.storage_class.*.id, [""]), 0)
}
