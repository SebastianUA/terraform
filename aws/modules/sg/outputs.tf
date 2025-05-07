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
output "security_group_rule_id" {
  description = "The ID of the security group rules"
  value = concat(
    aws_security_group_rule.ingress_ports_all.*.id,
    aws_security_group_rule.egress_ports_all.*.id,
    [""]
  )
}

output "security_group_rule_type" {
  description = "The type of rule, ingress or egress"
  value = concat(
    aws_security_group_rule.ingress_ports_all.*.type,
    aws_security_group_rule.egress_ports_all.*.type,
    [""]
  )
}

output "security_group_rule_from_port" {
  description = "The start port (or ICMP type number if protocol is 'icmp')"
  value = concat(
    aws_security_group_rule.ingress_ports_all.*.from_port,
    aws_security_group_rule.egress_ports_all.*.from_port,
    [""]
  )
}

output "security_group_rule_to_port" {
  description = "The end port (or ICMP code if protocol is 'icmp')"
  value = concat(
    aws_security_group_rule.ingress_ports_all.*.to_port,
    aws_security_group_rule.egress_ports_all.*.to_port,
    [""]
  )
}

output "security_group_rule_protocol" {
  description = "The protocol used"
  value = concat(
    aws_security_group_rule.ingress_ports_all.*.protocol,
    aws_security_group_rule.egress_ports_all.*.protocol,
    [""]
  )
}

output "security_group_rule_description" {
  description = "Description of the rule"
  value = concat(
    aws_security_group_rule.ingress_ports_all.*.description,
    aws_security_group_rule.egress_ports_all.*.description,
    [""]
  )
}

#---------------------------------------------------
# AWS security group (default)
#---------------------------------------------------
output "default_security_group_id" {
  description = "ID of the security group."
  value       = element(concat(aws_default_security_group.default_security_group.*.id, [""]), 0)
}

output "default_security_group_arn" {
  description = "ARN of the security group."
  value       = element(concat(aws_default_security_group.default_security_group.*.arn, [""]), 0)
}

output "default_security_group_description" {
  description = "Description of the security group."
  value       = element(concat(aws_default_security_group.default_security_group.*.description, [""]), 0)
}

output "default_security_group_name" {
  description = "Name of the security group."
  value       = element(concat(aws_default_security_group.default_security_group.*.name, [""]), 0)
}

output "default_security_group_owner_id" {
  description = "Owner ID."
  value       = element(concat(aws_default_security_group.default_security_group.*.owner_id, [""]), 0)
}
