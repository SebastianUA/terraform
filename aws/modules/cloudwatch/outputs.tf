#---------------------------------------------------
# Create AWS CloudWatch dashboard
#---------------------------------------------------
output "cw_dashboard_id" {
  description = "The Amazon ID of the dashboard."
  value       = element(concat(aws_cloudwatch_dashboard.cw_dashboard.*.id, [""]), 0)
}

output "cw_dashboard_arn" {
  description = "The Amazon Resource Name (ARN) of the dashboard."
  value       = element(concat(aws_cloudwatch_dashboard.cw_dashboard.*.dashboard_arn, [""]), 0)
}

#---------------------------------------------------
# cloudwatch composite alarm
#---------------------------------------------------
output "cw_composite_alarm_id" {
  description = "The ID of the composite alarm resource, which is equivalent to its alarm_name."
  value       = element(concat(aws_cloudwatch_composite_alarm.cw_composite_alarm.*.id, [""]), 0)
}

output "cw_composite_alarm_arn" {
  description = "The ARN of the composite alarm."
  value       = element(concat(aws_cloudwatch_composite_alarm.cw_composite_alarm.*.arn, [""]), 0)
}

#---------------------------------------------------
# Cloudwatch metric alarm
#---------------------------------------------------
output "cw_metric_alarm_id" {
  description = "The ID of the health check."
  value       = element(concat(aws_cloudwatch_metric_alarm.cw_metric_alarm.*.id, [""]), 0)
}

output "cw_metric_alarm_arm" {
  description = "The ARN of the CloudWatch Metric Alarm."
  value       = element(concat(aws_cloudwatch_metric_alarm.cw_metric_alarm.*.arn, [""]), 0)
}

#---------------------------------------------------
# AWS CloudWatch metric stream
#---------------------------------------------------
output "cw_metric_stream_id" {
  description = "The ID of metric stream."
  value       = element(concat(aws_cloudwatch_metric_stream.cw_metric_stream.*.id, [""]), 0)
}

output "cw_metric_stream_arn" {
  description = "ARN of the metric stream."
  value       = element(concat(aws_cloudwatch_metric_stream.cw_metric_stream.*.arn, [""]), 0)
}

output "cw_metric_stream_creation_date" {
  description = "Date and time in RFC3339 format that the metric stream was created."
  value       = element(concat(aws_cloudwatch_metric_stream.cw_metric_stream.*.creation_date, [""]), 0)
}

output "cw_metric_stream_last_update_date" {
  description = "Date and time in RFC3339 format that the metric stream was last updated."
  value       = element(concat(aws_cloudwatch_metric_stream.cw_metric_stream.*.last_update_date, [""]), 0)
}

output "cw_metric_stream_state" {
  description = "State of the metric stream. Possible values are running and stopped."
  value       = element(concat(aws_cloudwatch_metric_stream.cw_metric_stream.*.state, [""]), 0)
}

