#---------------------------------------------------
# Create AWS CloudWatch metric
#---------------------------------------------------
output "cw_metric_alarm_arn" {
  description = "The ARN of the Cloudwatch metric alarm."
  value       = element(concat(aws_cloudwatch_metric_alarm.cw_metric_alarm.*.arn, [""]), 0)
}

output "cw_metric_alarm_id" {
  description = "The ID of the Cloudwatch metric alarm."
  value       = element(concat(aws_cloudwatch_metric_alarm.cw_metric_alarm.*.id, [""]), 0)
}

#---------------------------------------------------
# Create AWS CloudWatch LOG
#---------------------------------------------------
output "cw_log_group_id" {
    description = ""
    value       = element(concat(aws_cloudwatch_log_group.cw_log_group.*.id, [""]), 0)
}

output "cw_log_group_name" {
    description = ""
    value       = element(concat(aws_cloudwatch_log_group.cw_log_group.*.name, [""]), 0)
}

output "cw_log_group_arn" {
    description = ""
    value       = element(concat(aws_cloudwatch_log_group.cw_log_group.*.arn, [""]), 0)
}

output "cw_log_stream_arn" {
    description = ""
    value       = element(concat(aws_cloudwatch_log_stream.cw_log_stream.*.arn, [""]), 0)
}

output "cw_log_metric_filter_id" {
    description = ""
    value       = element(concat(aws_cloudwatch_log_metric_filter.cw_log_metric_filter.*.id, [""]), 0)
}

#---------------------------------------------------
# Create AWS CloudWatch dashboard
#---------------------------------------------------
output "cw_dashboard_arn" {
    description = ""
    value       = element(concat(aws_cloudwatch_dashboard.cw_dashboard.*.dashboard_arn, [""]), 0)
}

#---------------------------------------------------
# Create AWS CloudWatch event
#---------------------------------------------------
output "cw_event_permission_id" {
    description = ""
    value       = element(concat(aws_cloudwatch_event_permission.cw_event_permission.*.id, [""]), 0)
}

output "cw_event_rule_id" {
    description = ""
    value       = element(concat(aws_cloudwatch_event_rule.cw_event_rule.*.id, [""]), 0)
}

output "cw_event_target_id" {
    description = ""
    value       = element(concat(aws_cloudwatch_event_target.cw_event_target.*.id, [""]), 0)
}
