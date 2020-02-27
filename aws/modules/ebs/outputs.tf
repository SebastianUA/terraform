#---------------------------------------------------
# EBS volume
#---------------------------------------------------
output "ebs_volume_id" {
    description = "The volume ID (e.g. vol-59fcb34e)."
    value       = element(concat(aws_ebs_volume.ebs_volume.*.id, [""]), 0)
}

output "ebs_volume_arn" {
    description = "The volume ARN (e.g. arn:aws:ec2:us-east-1:0123456789012:volume/vol-59fcb34e)."
    value       = element(concat(aws_ebs_volume.ebs_volume.*.arn, [""]), 0)
}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
output "ebs_volume_attachment_device_name" {
    description = "The device name exposed to the instance"
    value       = element(concat(aws_volume_attachment.ebs_volume_attachment.*.device_name, [""]), 0)
}

output "ebs_volume_attachment_instance_id" {
    description = "ID of the Instance"
    value       = element(concat(aws_volume_attachment.ebs_volume_attachment.*.instance_id, [""]), 0)
}

output "ebs_volume_attachment_volume_id" {
    description = "ID of the Volume"
    value       = element(concat(aws_volume_attachment.ebs_volume_attachment.*.volume_id, [""]), 0)
}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
output "ebs_snapshot_owner_id" {
    description = "The device name exposed to the instance"
    value       = element(concat(aws_ebs_snapshot.ebs_snapshot.*.owner_id, [""]), 0)
}

output "ebs_snapshot_id" {
    description = "ID of the Instance"
    value       = element(concat(aws_ebs_snapshot.ebs_snapshot.*.id, [""]), 0)
}

output "ebs_snapshot_owner_alias" {
    description = "ID of the Volume"
    value       = element(concat(aws_ebs_snapshot.ebs_snapshot.*.owner_alias, [""]), 0)
}

output "ebs_snapshot_owner_encrypted" {
    description = "The device name exposed to the instance"
    value       = element(concat(aws_ebs_snapshot.ebs_snapshot.*.encrypted, [""]), 0)
}

output "ebs_snapshot_kms_key_id" {
    description = "ID of the Instance"
    value       = element(concat(aws_ebs_snapshot.ebs_snapshot.*.kms_key_id, [""]), 0)
}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
output "ebs_snapshot_copy_owner_id" {
    description = "The device name exposed to the instance"
    value       = element(concat(aws_ebs_snapshot_copy.ebs_snapshot_copy.*.owner_id, [""]), 0)
}

output "ebs_snapshot_copy_id" {
    description = "ID of the Instance"
    value       = element(concat(aws_ebs_snapshot_copy.ebs_snapshot_copy.*.id, [""]), 0)
}

output "ebs_snapshot_copy_owner_alias" {
    description = "ID of the Volume"
    value       = element(concat(aws_ebs_snapshot_copy.ebs_snapshot_copy.*.owner_alias, [""]), 0)
}

output "ebs_snapshot_copy_owner_encrypted" {
    description = "The device name exposed to the instance"
    value       = element(concat(aws_ebs_snapshot_copy.ebs_snapshot_copy.*.encrypted, [""]), 0)
}

output "ebs_snapshot_copy_kms_key_id" {
    description = "ID of the Instance"
    value       = element(concat(aws_ebs_snapshot_copy.ebs_snapshot_copy.*.kms_key_id, [""]), 0)
}
