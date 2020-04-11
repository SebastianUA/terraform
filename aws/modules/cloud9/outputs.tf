#---------------------------------------------------
# AWS cloud9 environment ec2
#---------------------------------------------------
output "cloud9_environment_ec2_id" {
    description = "The ID of the environment."
    value       = element(concat(aws_cloud9_environment_ec2.cloud9_environment_ec2.*.id, [""]), 0)
}

output "cloud9_environment_ec2_arn" {
    description = "The ARN of the environment."
    value       = element(concat(aws_cloud9_environment_ec2.cloud9_environment_ec2.*.arn, [""]), 0)
}

output "cloud9_environment_ec2_type" {
    description = "The type of the environment (e.g. ssh or ec2)"
    value       = element(concat(aws_cloud9_environment_ec2.cloud9_environment_ec2.*.type, [""]), 0)
}
