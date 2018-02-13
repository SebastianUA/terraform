output "lb_name" {
    description = ""
    value       = "${aws_lb.lb.name}"
}

output "lb_arn" {
    description = "ARN of the lb itself. Useful for debug output, for example when attaching a WAF."
    value       = "${aws_lb.lb.arn}"
}

output "lb_arn_suffix" {
    description = "ARN suffix of our lb - can be used with CloudWatch"
    value       = "${aws_lb.lb.arn_suffix}"
}

output "lb_dns_name" {
    description = "The DNS name of the lb presumably to be used with a friendlier CNAME."
    value       = "${aws_lb.lb.dns_name}"
}

output "lb_id" {
    description = "The ID of the lb we created."
    value       = "${aws_lb.lb.id}"
}

output "lb_zone_id" {
    description = "The zone_id of the lb to assist with creating DNS records."
    value       = "${aws_lb.lb.zone_id}"
}
    
output "lb_listener_frontend_tcp_80_arn" {
    description = "The ARN of the HTTPS lb Listener we created."
    value       = "${element(concat(aws_lb_listener.frontend_tcp_80.*.arn, list("")), 0)}"
}

output "lb_listener_frontend_tcp_443_arn" {
    description = "The ARN of the HTTP lb Listener we created."
    value       = "${element(concat(aws_lb_listener.frontend_tcp_443.*.arn, list("")), 0)}"
}

output "lb_listener_frontend_tcp_80_id" {
    description = "The ID of the lb Listener we created."
    value       = "${element(concat(aws_lb_listener.frontend_tcp_80.*.id, list("")), 0)}"
}

output "lb_listener_frontend_tcp_443_id" {
    description = "The ID of the lb Listener we created."
    value       = "${element(concat(aws_lb_listener.frontend_tcp_443.*.id, list("")), 0)}"
}

output "target_group_arn" {
    description = "ARN of the target group. Useful for passing to your Auto Scaling group module."
    value       = "${aws_lb_target_group.lb_target_group.arn}"
}
