output "lb_name" {
    description = ""
    value       = "${aws_lb.alb.name}"
}

output "lb_arn" {
    description = "ARN of the lb itself. Useful for debug output, for example when attaching a WAF."
    value       = "${aws_lb.alb.arn}"
}

output "lb_arn_suffix" {
    description = "ARN suffix of our lb - can be used with CloudWatch"
    value       = "${aws_lb.alb.arn_suffix}"
}

output "lb_dns_name" {
    description = "The DNS name of the lb presumably to be used with a friendlier CNAME."
    value       = "${aws_lb.alb.dns_name}"
}

output "lb_id" {
    description = "The ID of the lb we created."
    value       = "${aws_lb.alb.id}"
}

output "lb_zone_id" {
    description = "The zone_id of the lb to assist with creating DNS records."
    value       = "${aws_lb.alb.zone_id}"
}
    
output "lb_listener_https_arn" {
    description = "The ARN of the HTTPS lb Listener we created."
    value       = "${element(concat(aws_lb_listener.frontend_https.*.arn, list("")), 0)}"
}

output "lb_listener_http_arn" {
    description = "The ARN of the HTTP lb Listener we created."
    value       = "${element(concat(aws_lb_listener.frontend_http.*.arn, list("")), 0)}"
}

output "lb_listener_https_id" {
    description = "The ID of the lb Listener we created."
    value       = "${element(concat(aws_lb_listener.frontend_https.*.id, list("")), 0)}"
}

output "lb_listener_http_id" {
    description = "The ID of the lb Listener we created."
    value       = "${element(concat(aws_lb_listener.frontend_http.*.id, list("")), 0)}"
}

output "target_group_arn" {
    description = "ARN of the target group. Useful for passing to your Auto Scaling group module."
    value       = "${aws_lb_target_group.alb_target_group.arn}"
}
