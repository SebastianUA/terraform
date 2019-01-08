#---------------------------------------------------
# EBS volume
#---------------------------------------------------
output "ebs_volume_id" {
    description = "The ID of the enable ebs volume"
    value       = "${element(concat(aws_ebs_volume.ebs_volume.*.id, list("")), 0)}"
}