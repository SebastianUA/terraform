output "efs_file_system_ids" {
    description = ""
    value       = "${aws_efs_file_system.efs_file_system.*.id}"
}

output "efs_file_system_kms_key_ids" {
    description = ""
    value       = "${aws_efs_file_system.efs_file_system.*.kms_key_id}"
}

output "efs_file_system_dns_names" {
    description = ""
    value       = "${aws_efs_file_system.efs_file_system.*.dns_name}"
}

