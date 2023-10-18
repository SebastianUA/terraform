#---------------------------------------------------
# AWS CloudWatch event rule
#---------------------------------------------------
output "cloudwatch_event_rule_id" {
  description = "The name of the rule."
  value       = element(concat(aws_cloudwatch_event_rule.cloudwatch_event_rule.*.id, [""]), 0)
}

output "cloudwatch_event_rule_arn" {
  description = "The Amazon Resource Name (ARN) of the rule."
  value       = element(concat(aws_cloudwatch_event_rule.cloudwatch_event_rule.*.arn, [""]), 0)
}

#---------------------------------------------------
# Cloudwatch event permission
#---------------------------------------------------
output "cloudwatch_event_permission_id" {
  description = "The statement ID of the EventBridge permission."
  value       = element(concat(aws_cloudwatch_event_permission.cloudwatch_event_permission.*.id, [""]), 0)
}

#---------------------------------------------------
# Cloudwatch event api destination
#---------------------------------------------------
output "cloudwatch_event_api_destination_id" {
  description = "The ID of the event API Destination."
  value       = element(concat(aws_cloudwatch_event_api_destination.cloudwatch_event_api_destination.*.id, [""]), 0)
}

output "cloudwatch_event_api_destination_arn" {
  description = "The Amazon Resource Name (ARN) of the event API Destination."
  value       = element(concat(aws_cloudwatch_event_api_destination.cloudwatch_event_api_destination.*.arn, [""]), 0)
}

#---------------------------------------------------
# Cloudwatch event archive
#---------------------------------------------------
output "cloudwatch_event_archive_id" {
  description = "The ID of the event archive."
  value       = element(concat(aws_cloudwatch_event_archive.cloudwatch_event_archive.*.id, [""]), 0)
}

output "cloudwatch_event_archive_arn" {
  description = "The Amazon Resource Name (ARN) of the event archive."
  value       = element(concat(aws_cloudwatch_event_archive.cloudwatch_event_archive.*.arn, [""]), 0)
}

#---------------------------------------------------
# Cloudwatch event bus policy
#---------------------------------------------------
output "cloudwatch_event_bus_policy_id" {
  description = "The name of the EventBridge event bus policy."
  value       = element(concat(aws_cloudwatch_event_bus_policy.cloudwatch_event_bus_policy.*.id, [""]), 0)
}

#---------------------------------------------------
# Cloudwatch event bus
#---------------------------------------------------
output "cloudwatch_event_bus_id" {
  description = "The ID of the EventBridge event bus."
  value       = element(concat(aws_cloudwatch_event_bus.cloudwatch_event_bus.*.id, [""]), 0)
}

output "cloudwatch_event_bus_arn" {
  description = "The Amazon Resource Name (ARN) of the event bus."
  value       = element(concat(aws_cloudwatch_event_bus.cloudwatch_event_bus.*.arn, [""]), 0)
}

#---------------------------------------------------
# Cloudwatch event target
#---------------------------------------------------
output "cloudwatch_event_target_id" {
  description = "The ID of the EventBridge event target."
  value       = element(concat(aws_cloudwatch_event_target.cloudwatch_event_target.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS CloudWatch event endpoint
#---------------------------------------------------
output "cloudwatch_event_endpoint_id" {
  description = "The ID of the EventBridge event endpoint."
  value       = element(concat(aws_cloudwatch_event_endpoint.cloudwatch_event_endpoint.*.id, [""]), 0)
}

output "cloudwatch_event_endpoint_arn" {
  description = "The ARN of the endpoint that was created."
  value       = element(concat(aws_cloudwatch_event_endpoint.cloudwatch_event_endpoint.*.arn, [""]), 0)
}

output "cloudwatch_event_endpoint_endpoint_url" {
  description = "The URL of the endpoint that was created."
  value       = element(concat(aws_cloudwatch_event_endpoint.cloudwatch_event_endpoint.*.endpoint_url, [""]), 0)
}

#---------------------------------------------------
# Cloudwatch event connection
#---------------------------------------------------
output "cloudwatch_event_connection_id" {
  description = "The ID of the EventBridge event connection."
  value       = element(concat(aws_cloudwatch_event_connection.cloudwatch_event_connection.*.id, [""]), 0)
}

output "cloudwatch_event_connection_arn" {
  description = "The Amazon Resource Name (ARN) of the connection."
  value       = element(concat(aws_cloudwatch_event_connection.cloudwatch_event_connection.*.arn, [""]), 0)
}

output "cloudwatch_event_connection_secret_arn" {
  description = "The Amazon Resource Name (ARN) of the secret created from the authorization parameters specified for the connection."
  value       = element(concat(aws_cloudwatch_event_connection.cloudwatch_event_connection.*.secret_arn, [""]), 0)
}
