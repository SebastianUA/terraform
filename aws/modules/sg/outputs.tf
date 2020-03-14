#---------------------------------------------------------------
# Security group
#---------------------------------------------------------------
output "security_group_id" {
    description = "The ID of the security group"
    value       = element(concat(aws_security_group.security_group.*.id, [""]), 0)
}

output "security_group_arn" {
    description = "The ARN of the security group"
    value       = element(concat(aws_security_group.security_group.*.arn, [""]), 0)
}

output "security_group_vpc_id" {
    description = "The VPC ID."
    value       = element(concat(aws_security_group.security_group.*.vpc_id, [""]), 0)
}

output "security_group_owner_id" {
    description = "The owner ID."
    value       = element(concat(aws_security_group.security_group.*.owner_id, [""]), 0)
}

output "security_group_name" {
    description = "The name of the security group"
    value       = element(concat(aws_security_group.security_group.*.name, [""]), 0)
}

output "security_group_description" {
    description = "The description of the security group"
    value       = element(concat(aws_security_group.security_group.*.description, [""]), 0)
}

output "security_group_ingress" {
    description = "The ingress rules. See above for more."
    value       = element(concat(aws_security_group.security_group.*.ingress, [""]), 0)
}

output "security_group_egress" {
    description = "The egress rules. See above for more."
    value       = element(concat(aws_security_group.security_group.*.egress, [""]), 0)
}

#---------------------------------------------------
# Security group rules
#---------------------------------------------------
