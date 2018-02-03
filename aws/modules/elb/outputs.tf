# ELB
output "elb_id" {
  description = "The name of the ELB"
  value       = "${aws_elb.elb.id}"
}

output "elb_name" {
  description = "The name of the ELB"
  value       = "${aws_elb.elb.name}"
}

output "elb_dns_name" {
  description = "The DNS name of the ELB"
  value       = "${aws_elb.elb.dns_name}"
}

output "elb_instances" {
  description = "The list of instances in the ELB"
  value       = ["${aws_elb.elb.instances}"]
}

output "elb_source_security_group_id" {
  description = "The ID of the security group that you can use as part of your inbound rules for your load balancer's back-end application instances"
  value       = "${aws_elb.elb.source_security_group_id}"
}

output "elb_zone_id" {
  description = "The canonical hosted zone ID of the ELB (to be used in a Route 53 Alias record)"
  value       = "${aws_elb.elb.zone_id}"
}
