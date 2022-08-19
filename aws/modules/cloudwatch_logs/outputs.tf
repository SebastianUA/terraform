#---------------------------------------------------
# AWS CloudWatch Log
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

output "cw_log_stream_name" {
  description = ""
  value       = element(concat(aws_cloudwatch_log_stream.cw_log_stream.*.name, [""]), 0)
}

output "cw_log_stream_id" {
  description = ""
  value       = element(concat(aws_cloudwatch_log_stream.cw_log_stream.*.id, [""]), 0)
}

output "cw_log_metric_filter_id" {
  description = ""
  value       = element(concat(aws_cloudwatch_log_metric_filter.cw_log_metric_filter.*.id, [""]), 0)
}
