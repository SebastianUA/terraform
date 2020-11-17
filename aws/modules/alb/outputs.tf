#---------------------------------------------------
# AWS ALB
#---------------------------------------------------
output "lb_name" {
  description = "LB name"
  value = element(
    concat(
      aws_lb.alb.*.name,
      aws_lb.alb_prefix.*.name,
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
      aws_lb.alb_prefix.*.arn,
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
      aws_lb.alb_prefix.*.arn_suffix,
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
      aws_lb.alb_prefix.*.dns_name,
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
      aws_lb.alb_prefix.*.id,
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
      aws_lb.alb_prefix.*.zone_id,
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
      aws_lb_target_group.alb_target_group_prefix.*.id,
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
      aws_lb_target_group.alb_target_group_prefix.*.arn,
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
      aws_lb_target_group.alb_target_group_prefix.*.arn_suffix,
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
      aws_lb_target_group.alb_target_group_prefix.*.name,
      [""],
    ),
    0,
  )
}

#---------------------------------------------------
# AWS ALB listener
#---------------------------------------------------
output "lb_listener_https_arn" {
  description = "The ARN of the HTTPS lb Listener we created."
  value = element(
    concat(
      aws_lb_listener.frontend_https.*.arn,
      aws_lb_listener.frontend_https_prefix.*.arn,
      [""],
    ),
    0,
  )
}

output "lb_listener_http_arn" {
  description = "The ARN of the HTTP lb Listener we created."
  value = element(
    concat(
      aws_lb_listener.frontend_http.*.arn,
      aws_lb_listener.frontend_http_prefix.*.arn,
      [""],
    ),
    0,
  )
}

output "lb_listener_https_id" {
  description = "The ID of the lb Listener we created."
  value = element(
    concat(
      aws_lb_listener.frontend_https.*.id,
      aws_lb_listener.frontend_https_prefix.*.id,
      [""],
    ),
    0,
  )
}

output "lb_listener_http_id" {
  description = "The ID of the lb Listener we created."
  value = element(
    concat(
      aws_lb_listener.frontend_http.*.id,
      aws_lb_listener.frontend_http_prefix.*.id,
      [""],
    ),
    0,
  )
}
