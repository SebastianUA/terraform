#---------------------------------------------------
# AWS EFS file system
#---------------------------------------------------
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

#---------------------------------------------------
# AWS EFS mount target
#---------------------------------------------------
output "efs_mount_target_id" {
  description = "The ID of the mount target."
  value       = element(concat(aws_efs_mount_target.efs_mount_target.*.id, [""]), 0)
}

output "efs_mount_target_dns_name" {
  description = "The DNS name for the EFS file system."
  value       = element(concat(aws_efs_mount_target.efs_mount_target.*.dns_name, [""]), 0)
}

output "efs_mount_target_mount_target_dns_name" {
  description = "The DNS name for the given subnet/AZ per documented convention."
  value       = element(concat(aws_efs_mount_target.efs_mount_target.*.mount_target_dns_name, [""]), 0)
}

output "efs_mount_target_file_system_arn" {
  description = "Amazon Resource Name of the file system."
  value       = element(concat(aws_efs_mount_target.efs_mount_target.*.file_system_arn, [""]), 0)
}

output "efs_mount_target_network_interface_id" {
  description = "The ID of the network interface that Amazon EFS created when it created the mount target."
  value       = element(concat(aws_efs_mount_target.efs_mount_target.*.network_interface_id, [""]), 0)
}

output "efs_mount_target_availability_zone_name" {
  description = "The name of the Availability Zone (AZ) that the mount target resides in."
  value       = element(concat(aws_efs_mount_target.efs_mount_target.*.availability_zone_name, [""]), 0)
}

output "efs_mount_target_availability_zone_id" {
  description = "The unique and consistent identifier of the Availability Zone (AZ) that the mount target resides in."
  value       = element(concat(aws_efs_mount_target.efs_mount_target.*.availability_zone_id, [""]), 0)
}

output "efs_mount_target_owner_id" {
  description = "AWS account ID that owns the resource."
  value       = element(concat(aws_efs_mount_target.efs_mount_target.*.owner_id, [""]), 0)
}

#---------------------------------------------------
# AWS EFS file system policy
#---------------------------------------------------
output "efs_file_system_policy_id" {
  description = "The ID that identifies the file system (e.g. fs-ccfc0d65)."
  value       = element(concat(aws_efs_file_system_policy.efs_file_system_policy.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS EFS access point
#---------------------------------------------------
output "efs_access_point_id" {
  description = "The ID of the access point."
  value       = element(concat(aws_efs_access_point.efs_access_point.*.id, [""]), 0)
}

output "efs_access_point_arn" {
  description = "Amazon Resource Name of the access point."
  value       = element(concat(aws_efs_access_point.efs_access_point.*.arn, [""]), 0)
}

output "efs_access_point_file_system_arn" {
  description = "Amazon Resource Name of the file system."
  value       = element(concat(aws_efs_access_point.efs_access_point.*.file_system_arn, [""]), 0)
}
