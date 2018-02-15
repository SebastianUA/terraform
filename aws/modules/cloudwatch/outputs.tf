output "cw_metric_alarm_ids" {
    description = ""
    value       = "${aws_cloudwatch_metric_alarm.cw_metric_alarm.*.id}"
}

output "cw_event_permission_ids" {   
    description = ""                                        
    value       = "${aws_cloudwatch_event_permission.cw_event_permission.*.id}"
}

output "cw_event_rule_ids" {
    description = ""
    value       = "${aws_cloudwatch_event_rule.cw_event_rule.*.id}"
}

output "cw_event_rule_names" {
    description = ""
    value       = "${aws_cloudwatch_event_rule.cw_event_rule.*.name}"
}

output "cloudwatch_dashboard_ids" {
    description = ""
    value       = "${aws_cloudwatch_dashboard.cloudwatch_dashboard.*.id}"
}

output "cloudwatch_dashboard_names" {
    description = ""
    value       = "${aws_cloudwatch_dashboard.cloudwatch_dashboard.*.name}"
}

output "cw_log_group_ids" {
    description = ""
    value       = "${aws_cloudwatch_log_group.cw_log_group.*.id}"
}

output "cw_log_group_names" {
    description = ""
    value       = "${aws_cloudwatch_log_group.cw_log_group.*.name}"
}

output "cloudwatch_log_metric_filter_ids" {
    description = ""
    value       = "${aws_cloudwatch_log_metric_filter.cloudwatch_log_metric_filter.*.ids}"
}

output "cloudwatch_log_metric_filter_names" {
    description = ""
    value       = "${aws_cloudwatch_log_metric_filter.cloudwatch_log_metric_filter.*.names}"
}
 
output "cloudwatch_log_stream_ids" {
    description = ""
    value       = "${aws_cloudwatch_log_stream.cloudwatch_log_stream.*.id}"
}

output "cloudwatch_log_stream_names" {
    description = ""
    value       = "${aws_cloudwatch_log_stream.cloudwatch_log_stream.*.name}"
}

