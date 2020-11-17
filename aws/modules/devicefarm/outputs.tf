#---------------------------------------------------
# AWS devicefarm project
#---------------------------------------------------
output "devicefarm_project_id" {
  description = "The ID of this project"
  value       = element(concat(aws_devicefarm_project.devicefarm_project.*.id, [""], ), 0)
}

output "devicefarm_project_arn" {
  description = "The Amazon Resource Name of this project"
  value       = element(concat(aws_devicefarm_project.devicefarm_project.*.arn, [""], ), 0)
}
