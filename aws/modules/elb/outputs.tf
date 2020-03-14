# ELB
output "elb_id" {
  description = "The name of the ELB"
  value       = element(concat(aws_elb.elb.*.id, [""]), 0)
}

output "elb_name" {
  description = "The name of the ELB"
  value       = element(concat(aws_elb.elb.*.name, [""]), 0)
}

output "elb_dns_name" {
  description = "The DNS name of the ELB"
  value       = element(concat(aws_elb.elb.*.dns_name, [""]), 0)
}

output "elb_instances" {
  description = "The list of instances in the ELB"
  value       = element(concat(aws_elb.elb.*.instances, [""]), 0)
}

output "elb_source_security_group_id" {
  description = "The ID of the security group that you can use as part of your inbound rules for your load balancer's back-end application instances"
  value       = element(concat(aws_elb.elb.*.source_security_group_id, [""]), 0)
}

output "elb_zone_id" {
  description = "The canonical hosted zone ID of the ELB (to be used in a Route 53 Alias record)"
  value       = element(concat(aws_elb.elb.*.zone_id, [""]), 0)
}
