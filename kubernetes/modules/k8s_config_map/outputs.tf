#---------------------------------------------------
# Kubernetes config_map
#---------------------------------------------------
output "config_map_id" {
  description = "ID of Kubernetes config_map"
  value       = element(concat(kubernetes_config_map.config_map.*.id, [""]), 0)
}
