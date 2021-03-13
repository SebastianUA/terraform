#---------------------------------------------------
# AWS ELB
#---------------------------------------------------
output "elb_id" {
  description = "The ID of the ELB"
  value       = element(concat(aws_elb.elb.*.id, [""]), 0)
}

output "elb_arn" {
  description = "The ARN of the ELB"
  value       = element(concat(aws_elb.elb.*.arn, [""]), 0)
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

output "elb_source_security_group" {
  description = "The name of the security group that you can use as part of your inbound rules for your load balancer's back-end application instances. Use this for Classic or Default VPC only."
  value       = element(concat(aws_elb.elb.*.source_security_group, [""]), 0)
}

output "elb_zone_id" {
  description = "The canonical hosted zone ID of the ELB (to be used in a Route 53 Alias record)"
  value       = element(concat(aws_elb.elb.*.zone_id, [""]), 0)
}

#---------------------------------------------------
# AWS ELB attachment
#---------------------------------------------------
output "elb_attachment_id" {
  description = "The ID of the ELB attachmnet"
  value       = element(concat(aws_elb_attachment.elb_attachment.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS ELB app cookie stickiness policy
#---------------------------------------------------
output "app_cookie_stickiness_policy_id" {
  description = "The ID of the policy."
  value       = element(concat(aws_app_cookie_stickiness_policy.app_cookie_stickiness_policy.*.id, [""]), 0)
}

output "app_cookie_stickiness_policy_name" {
  description = "The name of the stickiness policy."
  value       = element(concat(aws_app_cookie_stickiness_policy.app_cookie_stickiness_policy.*.name, [""]), 0)
}

output "app_cookie_stickiness_policy_load_balancer" {
  description = "The name of load balancer to which the policy is attached."
  value       = element(concat(aws_app_cookie_stickiness_policy.app_cookie_stickiness_policy.*.load_balancer, [""]), 0)
}

output "app_cookie_stickiness_policy_lb_port" {
  description = "The load balancer port to which the policy is applied."
  value       = element(concat(aws_app_cookie_stickiness_policy.app_cookie_stickiness_policy.*.lb_port, [""]), 0)
}

output "app_cookie_stickiness_policy_cookie_name" {
  description = "The application cookie whose lifetime the ELB's cookie should follow."
  value       = element(concat(aws_app_cookie_stickiness_policy.app_cookie_stickiness_policy.*.cookie_name, [""]), 0)
}

#---------------------------------------------------
# AWS ELB lb cookie stickiness policy
#---------------------------------------------------
output "lb_cookie_stickiness_policy_id" {
  description = "The ID of the policy."
  value       = element(concat(aws_lb_cookie_stickiness_policy.lb_cookie_stickiness_policy.*.id, [""]), 0)
}

output "lb_cookie_stickiness_policy_name" {
  description = "The name of the stickiness policy."
  value       = element(concat(aws_lb_cookie_stickiness_policy.lb_cookie_stickiness_policy.*.name, [""]), 0)
}

output "lb_cookie_stickiness_policy_load_balancer" {
  description = "The load balancer to which the policy is attached."
  value       = element(concat(aws_lb_cookie_stickiness_policy.lb_cookie_stickiness_policy.*.load_balancer, [""]), 0)
}

output "lb_cookie_stickiness_policy_lb_port" {
  description = "The load balancer port to which the policy is applied."
  value       = element(concat(aws_lb_cookie_stickiness_policy.lb_cookie_stickiness_policy.*.lb_port, [""]), 0)
}

output "lb_cookie_stickiness_policy_cookie_expiration_period" {
  description = "The time period after which the session cookie is considered stale, expressed in seconds."
  value       = element(concat(aws_lb_cookie_stickiness_policy.lb_cookie_stickiness_policy.*.cookie_expiration_period, [""]), 0)
}

#---------------------------------------------------
# AWS ELB lb ssl negotiation policy
#---------------------------------------------------
output "lb_ssl_negotiation_policy_id" {
  description = "The ID of the policy."
  value       = element(concat(aws_lb_ssl_negotiation_policy.lb_ssl_negotiation_policy.*.id, [""]), 0)
}

output "lb_ssl_negotiation_policy_name" {
  description = "The name of the stickiness policy."
  value       = element(concat(aws_lb_ssl_negotiation_policy.lb_ssl_negotiation_policy.*.name, [""]), 0)
}

output "lb_ssl_negotiation_policy_load_balancer" {
  description = "The load balancer to which the policy is attached."
  value       = element(concat(aws_lb_ssl_negotiation_policy.lb_ssl_negotiation_policy.*.load_balancer, [""]), 0)
}

output "lb_ssl_negotiation_policy_lb_port" {
  description = "The load balancer port to which the policy is applied."
  value       = element(concat(aws_lb_ssl_negotiation_policy.lb_ssl_negotiation_policy.*.lb_port, [""]), 0)
}

output "lb_ssl_negotiation_policy_attribute" {
  description = "The SSL Negotiation policy attributes."
  value       = concat(aws_lb_ssl_negotiation_policy.lb_ssl_negotiation_policy.*.attribute, [""])
}

#---------------------------------------------------
# AWS ELB proxy protocol policy
#---------------------------------------------------
output "proxy_protocol_policy_id" {
  description = "The ID of the ELB attachmnet"
  value       = element(concat(aws_proxy_protocol_policy.proxy_protocol_policy.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS load balancer policy
#---------------------------------------------------
output "load_balancer_policy_id" {
  description = "The ID of the load balancer policy"
  value       = element(concat(aws_load_balancer_policy.load_balancer_policy.*.id, [""]), 0)
}

output "load_balancer_policy_policy_name" {
  description = "The name of the stickiness policy."
  value       = element(concat(aws_load_balancer_policy.load_balancer_policy.*.policy_name, [""]), 0)
}

output "load_balancer_policy_policy_type_name" {
  description = "The policy type of the policy."
  value       = element(concat(aws_load_balancer_policy.load_balancer_policy.*.policy_type_name, [""]), 0)
}

output "load_balancer_policy_load_balancer_name" {
  description = "The load balancer on which the policy is defined."
  value       = element(concat(aws_load_balancer_policy.load_balancer_policy.*.load_balancer_name, [""]), 0)
}

#---------------------------------------------------
# AWS load balancer backend server policy
#---------------------------------------------------
output "load_balancer_backend_server_policy_id" {
  description = "The ID of the policy."
  value       = element(concat(aws_load_balancer_backend_server_policy.load_balancer_backend_server_policy.*.id, [""]), 0)
}

output "load_balancer_backend_server_policy_load_balancer_name" {
  description = "The load balancer on which the policy is defined."
  value       = element(concat(aws_load_balancer_backend_server_policy.load_balancer_backend_server_policy.*.load_balancer_name, [""]), 0)
}

output "load_balancer_backend_server_policy_instance_port" {
  description = "The backend port the policies are applied to"
  value       = element(concat(aws_load_balancer_backend_server_policy.load_balancer_backend_server_policy.*.instance_port, [""]), 0)
}

#---------------------------------------------------
# AWS load balancer listener policy
#---------------------------------------------------
output "load_balancer_listener_policy_id" {
  description = "The ID of the policy."
  value       = element(concat(aws_load_balancer_listener_policy.load_balancer_listener_policy.*.id, [""]), 0)
}

output "load_balancer_listener_policy_load_balancer_name" {
  description = "The load balancer on which the policy is defined."
  value       = element(concat(aws_load_balancer_listener_policy.load_balancer_listener_policy.*.load_balancer_name, [""]), 0)
}

output "load_balancer_listener_policy_load_balancer_port" {
  description = "The load balancer listener port the policies are applied to"
  value       = element(concat(aws_load_balancer_listener_policy.load_balancer_listener_policy.*.load_balancer_port, [""]), 0)
}
