output "efs_file_system_ids" {
    description = ""
    value       = element(concat(aws_efs_file_system.efs_file_system.*.id, [""]), 0)
}

output "efs_file_system_kms_key_ids" {
    description = ""
    value       = element(concat(aws_efs_file_system.efs_file_system.*.kms_key_id, [""]), 0)
}

output "efs_file_system_dns_names" {
    description = ""
    value       = element(concat(aws_efs_file_system.efs_file_system.*.dns_name, [""]), 0)
}