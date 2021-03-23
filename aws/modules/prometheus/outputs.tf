#---------------------------------------------------
# AWS prometheus workspace
#---------------------------------------------------
output "prometheus_workspace_id" {
  description = "Identifier of the workspace"
  value       = element(concat(aws_prometheus_workspace.prometheus_workspace.*.id, [""]), 0)
}

output "prometheus_workspace_arn" {
  description = "Amazon Resource Name (ARN) of the workspace."
  value       = element(concat(aws_prometheus_workspace.prometheus_workspace.*.arn, [""]), 0)
}

output "prometheus_workspace_prometheus_endpoint" {
  description = "Prometheus endpoint available for this workspace."
  value       = element(concat(aws_prometheus_workspace.prometheus_workspace.*.prometheus_endpoint, [""]), 0)
}
