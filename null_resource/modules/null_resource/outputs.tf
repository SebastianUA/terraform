#---------------------------------------------------
# Using depends_on
#---------------------------------------------------
output "depends_on_id" {
  description = "The ID for depends_on"
  value       = element(concat(null_resource.depends_on.*.id, [""]), 0)
}

#---------------------------------------------------
# Provisioner file
#---------------------------------------------------
output "provisioner_file_id" {
  description = "An arbitrary value that changes each time the resource is replaced. Can be used to cause other resources to be updated or replaced in response to null_resource changes."
  value       = element(concat(null_resource.provisioner_file.*.id, [""]), 0)
}

#---------------------------------------------------
# Provisioner local-exec
#---------------------------------------------------
output "provisioner_local_exec_id" {
  description = "The ID"
  value       = element(concat(null_resource.provisioner_local_exec.*.id, [""]), 0)
}

#---------------------------------------------------
# Provisioner remote-exec
#---------------------------------------------------
output "provisioner_remote_exec_id" {
  description = "The ID"
  value = element(concat(
    null_resource.provisioner_remote_exec_inline.*.id,
    null_resource.provisioner_remote_exec_script.*.id,
    null_resource.provisioner_remote_exec_scripts.*.id,
  [""]), 0)
}
