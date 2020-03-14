output "efs_file_system_id" {
    description = "The ID that identifies the file system (e.g. fs-ccfc0d65)."
    value       = element(concat(aws_efs_file_system.efs_file_system.*.id, [""]), 0)
}

output "efs_file_system_arn" {
    description = "Amazon Resource Name of the file system."
    value       = element(concat(aws_efs_file_system.efs_file_system.*.arn, [""]), 0)
}

output "efs_file_system_kms_key_id" {
    description = ""
    value       = element(concat(aws_efs_file_system.efs_file_system.*.kms_key_id, [""]), 0)
}

output "efs_file_system_dns_name" {
    description = "The DNS name for the filesystem per documented convention."
    value       = element(concat(aws_efs_file_system.efs_file_system.*.dns_name, [""]), 0)
}
