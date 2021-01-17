#---------------------------------------------------
# AWS ALB
#---------------------------------------------------
output "lb_name" {
  description = "LB name"
  value = element(
    concat(
      aws_lb.alb.*.name,
      [""],
    ),
    0,
  )
}

output "lb_arn" {
  description = "ARN of the lb itself. Useful for debug output, for example when attaching a WAF."
  value = element(
    concat(
      aws_lb.alb.*.arn,
      [""],
    ),
    0,
  )
}

output "lb_arn_suffix" {
  description = "ARN suffix of our lb - can be used with CloudWatch"
  value = element(
    concat(
      aws_lb.alb.*.arn_suffix,
      [""],
    ),
    0,
  )
}

output "lb_dns_name" {
  description = "The DNS name of the lb presumably to be used with a friendlier CNAME."
  value = element(
    concat(
      aws_lb.alb.*.dns_name,
      [""],
    ),
    0,
  )
}

output "lb_id" {
  description = "The ID of the lb we created."
  value = element(
    concat(
      aws_lb.alb.*.id,
      [""],
    ),
    0,
  )
}

output "lb_zone_id" {
  description = "The zone_id of the lb to assist with creating DNS records."
  value = element(
    concat(
      aws_lb.alb.*.zone_id,
      [""],
    ),
    0,
  )
}

#---------------------------------------------------
# AWS ALB target group
#---------------------------------------------------
output "lb_tg_id" {
  description = "The ARN of the Target Group (matches arn)"
  value = element(
    concat(
      aws_lb_target_group.alb_target_group.*.id,
      [""],
    ),
    0,
  )
}

output "lb_tg_arn" {
  description = "The ARN of the Target Group (matches id)"
  value = element(
    concat(
      aws_lb_target_group.alb_target_group.*.arn,
      [""],
    ),
    0,
  )
}

output "lb_tg_arn_suffix" {
  description = "The ARN suffix for use with CloudWatch Metrics."
  value = element(
    concat(
      aws_lb_target_group.alb_target_group.*.arn_suffix,
      [""],
    ),
    0,
  )
}

output "lb_tg_name" {
  description = "The name of the Target Group"
  value = element(
    concat(
      aws_lb_target_group.alb_target_group.*.name,
      [""],
    ),
    0,
  )
}

#---------------------------------------------------
# AWS ALB target group attachment
#---------------------------------------------------
output "lb_tg_attachment_id" {
  description = "A unique identifier for the attachment"
  value = element(
    concat(
      aws_lb_target_group_attachment.alb_target_group_attachment.*.id,
      [""],
    ),
    0,
  )
}

#---------------------------------------------------
# AWS ALB listener
#---------------------------------------------------
output "alb_listener_arn" {
  description = "The ARN of the HTTPS lb Listener we created."
  value = element(
    concat(
      aws_lb_listener.alb_listener.*.arn,
      [""],
    ),
    0,
  )
}

output "alb_listener_id" {
  description = "The ID of the lb Listener we created."
  value = element(
    concat(
      aws_lb_listener.alb_listener.*.id,
      [""],
    ),
    0,
  )
}

#---------------------------------------------------
# AWS LB listener rule
#---------------------------------------------------
output "alb_listener_rule_arn" {
  description = "The ARN of the rule (matches id)"
  value = element(
    concat(
      aws_lb_listener_rule.alb_listener_rule.*.id,
      [""],
    ),
    0,
  )
}

output "alb_listener_rule_id" {
  description = "The ARN of the rule (matches arn)"
  value = element(
    concat(
      aws_lb_listener_rule.alb_listener_rule.*.id,
      [""],
    ),
    0,
  )
}
