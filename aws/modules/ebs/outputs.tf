#---------------------------------------------------
# EBS volume
#---------------------------------------------------
output "ebs_volume_id" {
    description = "The ID of the enable ebs volume"
    value       = "${element(concat(aws_ebs_volume.ebs_volume.*.id, list("")), 0)}"
}

output "ebs_volume_arn" {
    description = "The volume ARN (e.g. arn:aws:ec2:us-east-1:0123456789012:volume/vol-59fcb34e)."
    value       = "${element(concat(aws_ebs_volume.ebs_volume.*.arn, list("")), 0)}"
}
