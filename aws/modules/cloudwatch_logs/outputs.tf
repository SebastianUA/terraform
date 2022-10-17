#---------------------------------------------------
# AWS CloudWatch Log
#---------------------------------------------------
output "cw_log_group_id" {
  description = "The ID specifying the log group"
  value       = element(concat(aws_cloudwatch_log_group.cw_log_group.*.id, [""]), 0)
}

output "cw_log_group_name" {
  description = "The name specifying the log group"
  value       = element(concat(aws_cloudwatch_log_group.cw_log_group.*.name, [""]), 0)
}

output "cw_log_group_arn" {
  description = "The Amazon Resource Name (ARN) specifying the log group. Any :* suffix added by the API, denoting all CloudWatch Log Streams under the CloudWatch Log Group, is removed for greater compatibility with other AWS services that do not accept the suffix."
  value       = element(concat(aws_cloudwatch_log_group.cw_log_group.*.arn, [""]), 0)
}

#---------------------------------------------------
# AWS CW log stream
#---------------------------------------------------
output "cw_log_stream_arns" {
  description = "The Amazon Resource Name (ARN) specifying the log stream."
  value       = compact(concat(aws_cloudwatch_log_stream.cw_log_stream.*.arn, [""]))
}

output "cw_log_stream_names" {
  description = "The name specifying the log stream."
  value       = compact(concat(aws_cloudwatch_log_stream.cw_log_stream.*.name, [""]))
}

output "cw_log_stream_ids" {
  description = "The ID specifying the log stream."
  value       = compact(concat(aws_cloudwatch_log_stream.cw_log_stream.*.id, [""]))
}

#---------------------------------------------------
# AWS CW log metric filter
#---------------------------------------------------
output "cw_log_metric_filter_id" {
  description = "The name of the metric filter."
  value       = element(concat(aws_cloudwatch_log_metric_filter.cw_log_metric_filter.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS CloudWatch LOG subscription filter
#---------------------------------------------------
output "cw_log_subscription_filterid" {
  description = "The name of the log subscription filter."
  value       = element(concat(aws_cloudwatch_log_subscription_filter.cw_log_subscription_filter.*.id, [""]), 0)
}
