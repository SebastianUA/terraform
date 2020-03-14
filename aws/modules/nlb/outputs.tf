#---------------------------------------------------
# NLB
#---------------------------------------------------
output "nlb_name" {
    description = "Get NLB name"
    value       = element(concat(aws_lb.nlb.*.name, [""]), 0)
}

output "nlb_arn" {
    description = "ARN of the lb itself. Useful for debug output, for example when attaching a WAF."
    value       = element(concat(aws_lb.nlb.*.arn, [""]), 0)
}

output "nlb_arn_suffix" {
    description = "ARN suffix of our lb - can be used with CloudWatch"
    value       = element(concat(aws_lb.nlb.*.arn_suffix, [""]), 0)
}

output "nlb_dns_name" {
    description = "The DNS name of the lb presumably to be used with a friendlier CNAME."
    value       = element(concat(aws_lb.nlb.*.dns_name, [""]), 0)
}

output "nlb_id" {
    description = "The ID of the lb we created."
    value       = element(concat(aws_lb.nlb.*.id, [""]), 0)
}

output "nlb_zone_id" {
    description = "The zone_id of the lb to assist with creating DNS records."
    value       = element(concat(aws_lb.nlb.*.zone_id, [""]), 0)
}

#
#
#
output "nlb_listener1_arn" {
    description = "The ARN of the HTTPS lb Listener we created."
    value       = element(concat(aws_lb_listener.nlb_listener1.*.arn, [""]), 0)
}

output "nlb_listener2_arn" {
    description = "The ARN of the HTTP lb Listener we created."
    value       = element(concat(aws_lb_listener.nlb_listener2.*.arn, [""]), 0)
}

output "nlb_listener1_id" {
    description = "The ID of the lb Listener we created."
    value       = element(concat(aws_lb_listener.nlb_listener1.*.id, [""]), 0)
}

output "nlb_listener2_id" {
    description = "The ID of the lb Listener we created."
    value       = element(concat(aws_lb_listener.nlb_listener2.*.id, [""]), 0)
}

#---------------------------------------------------
# NLB target group
#---------------------------------------------------
output "nlb_target_group_arn" {
    description = "ARN of the target group. Useful for passing to your Auto Scaling group module."
    value       = element(concat(aws_lb_target_group.nlb_target_group.*.arn, [""]), 0)
}

output "nlb_target_group_id" {
    description = "The ARN of the Target Group (matches arn)"
    value       = element(concat(aws_lb_target_group.nlb_target_group.*.id, [""]), 0)
}

output "nlb_target_group_arn_suffix" {
    description = "The ARN suffix for use with CloudWatch Metrics."
    value       = element(concat(aws_lb_target_group.nlb_target_group.*.arn_suffix, [""]), 0)
}

output "nlb_target_group_name" {
    description = "The name of the Target Group"
    value       = element(concat(aws_lb_target_group.nlb_target_group.*.name, [""]), 0)
}

#---------------------------------------------------
# NLB listeners
#---------------------------------------------------
