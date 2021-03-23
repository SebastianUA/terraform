#---------------------------------------------------
# AWS codestarnotifications notification rule
#---------------------------------------------------
output "aws_codestarconnections_connection_id" {
  description = "The codestar connection ARN."
  value       = element(concat(aws_codestarconnections_connection.codestarconnections_connection.*.id, [""]), 0)
}

output "aws_codestarconnections_connection_arn" {
  description = "The codestar connection ARN."
  value       = element(concat(aws_codestarconnections_connection.codestarconnections_connection.*.arn, [""]), 0)
}

output "aws_codestarconnections_connection_connection_status" {
  description = "The codestar connection status. Possible values are PENDING, AVAILABLE and ERROR."
  value       = element(concat(aws_codestarconnections_connection.codestarconnections_connection.*.arn, [""]), 0)
}
