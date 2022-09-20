#---------------------------------------------------
# AWS Lambda function
#---------------------------------------------------
output "lambda_function_id" {
  description = "The Amazon Resource Name (ID) identifying your Lambda Function."
  value       = element(concat(aws_lambda_function.lambda_function.*.id, [""]), 0)
}

output "lambda_function_name" {
  description = "The Amazon Resource Name (name) identifying your Lambda Function."
  value       = element(concat(aws_lambda_function.lambda_function.*.function_name, [""]), 0)
}

output "lambda_function_arn" {
  description = "The Amazon Resource Name (ARN) identifying your Lambda Function."
  value       = element(concat(aws_lambda_function.lambda_function.*.arn, [""]), 0)
}

output "lambda_function_qualified_arn" {
  description = "The Amazon Resource Name (ARN) identifying your Lambda Function Version (if versioning is enabled via publish = true)."
  value       = element(concat(aws_lambda_function.lambda_function.*.qualified_arn, [""]), 0)
}

output "lambda_function_last_modified" {
  description = "The date this resource was last modified."
  value       = element(concat(aws_lambda_function.lambda_function.*.last_modified, [""]), 0)
}

output "lambda_function_kms_key_arn" {
  description = "(Optional) The ARN for the KMS encryption key."
  value       = element(concat(aws_lambda_function.lambda_function.*.kms_key_arn, [""]), 0)
}

output "lambda_function_source_code_hash" {
  description = "Base64-encoded representation of raw SHA-256 sum of the zip file, provided either via filename or s3_* parameters."
  value       = element(concat(aws_lambda_function.lambda_function.*.source_code_hash, [""]), 0)
}

output "lambda_function_source_code_size" {
  description = "The size in bytes of the function .zip file."
  value       = element(concat(aws_lambda_function.lambda_function.*.source_code_size, [""]), 0)
}

output "lambda_function_invoke_arn" {
  description = "ARN to be used for invoking Lambda Function from API Gateway - to be used in aws_api_gateway_integration's uri."
  value       = element(concat(aws_lambda_function.lambda_function.*.invoke_arn, [""]), 0)
}

#---------------------------------------------------
# AWS lambda alias
#---------------------------------------------------
output "lambda_alias_arn" {
  description = "The Amazon Resource Name (ARN) identifying your Lambda function alias."
  value       = element(concat(aws_lambda_alias.lambda_alias.*.arn, [""]), 0)
}

output "lambda_alias_invoke_arn" {
  description = "The ARN to be used for invoking Lambda Function from API Gateway - to be used in aws_api_gateway_integration's uri"
  value       = element(concat(aws_lambda_alias.lambda_alias.*.invoke_arn, [""]), 0)
}

#---------------------------------------------------
# AWS lambda event source mapping
#---------------------------------------------------
output "lambda_event_source_mapping_last_modifiedn" {
  description = "The date this resource was last modified."
  value       = element(concat(aws_lambda_event_source_mapping.lambda_event_source_mapping.*.last_modified, [""]), 0)
}

output "lambda_event_source_mapping_last_processing_result" {
  description = "The result of the last AWS Lambda invocation of your Lambda function."
  value       = element(concat(aws_lambda_event_source_mapping.lambda_event_source_mapping.*.last_processing_result, [""]), 0)
}

output "lambda_event_source_mapping_state" {
  description = "The state of the event source mapping."
  value       = element(concat(aws_lambda_event_source_mapping.lambda_event_source_mapping.*.state, [""]), 0)
}

output "lambda_event_source_mapping_state_transition_reason" {
  description = "The reason the event source mapping is in its current state."
  value       = element(concat(aws_lambda_event_source_mapping.lambda_event_source_mapping.*.state_transition_reason, [""]), 0)
}

output "lambda_event_source_mapping_uuid" {
  description = "The UUID of the created event source mapping."
  value       = element(concat(aws_lambda_event_source_mapping.lambda_event_source_mapping.*.uuid, [""]), 0)
}

#---------------------------------------------------
# AWS lambda function event invoke config
#---------------------------------------------------
output "lambda_function_event_invoke_config_id" {
  description = "Fully qualified Lambda Function name or Amazon Resource Name (ARN)"
  value       = element(concat(aws_lambda_function_event_invoke_config.lambda_function_event_invoke_config.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS lambda layer version
#---------------------------------------------------
output "lambda_layer_version_arn" {
  description = "The Amazon Resource Name (ARN) of the Lambda Layer with version."
  value       = element(concat(aws_lambda_layer_version.lambda_layer_version.*.arn, [""]), 0)
}

output "lambda_layer_version_layer_arn" {
  description = "The Amazon Resource Name (ARN) of the Lambda Layer without version."
  value       = element(concat(aws_lambda_layer_version.lambda_layer_version.*.layer_arn, [""]), 0)
}

output "lambda_layer_version_created_date" {
  description = "The date this resource was created."
  value       = element(concat(aws_lambda_layer_version.lambda_layer_version.*.created_date, [""]), 0)
}

output "lambda_layer_version_source_code_size" {
  description = "The size in bytes of the function .zip file."
  value       = element(concat(aws_lambda_layer_version.lambda_layer_version.*.source_code_size, [""]), 0)
}

output "lambda_layer_version_version" {
  description = "This Lamba Layer version."
  value       = element(concat(aws_lambda_layer_version.lambda_layer_version.*.version, [""]), 0)
}

#---------------------------------------------------
# AWS lambda provisioned concurrency config
#---------------------------------------------------
output "lambda_provisioned_concurrency_config_id" {
  description = "Lambda Function name and qualifier separated by a colon (:)."
  value       = element(concat(aws_lambda_provisioned_concurrency_config.lambda_provisioned_concurrency_config.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS lambda permission
#---------------------------------------------------
output "lambda_permission_id" {
  description = "ID of lambda permission"
  value       = element(concat(aws_lambda_permission.lambda_permission.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS lambda code signing config
#---------------------------------------------------
output "lambda_code_signing_config_id" {
  description = "ID of lambda code signing config"
  value       = element(concat(aws_lambda_code_signing_config.lambda_code_signing_config.*.id, [""]), 0)
}

output "lambda_code_signing_config_arn" {
  description = "The Amazon Resource Name (ARN) of the code signing configuration."
  value       = element(concat(aws_lambda_code_signing_config.lambda_code_signing_config.*.arn, [""]), 0)
}

output "lambda_code_signing_config_config_id" {
  description = "Unique identifier for the code signing configuration."
  value       = element(concat(aws_lambda_code_signing_config.lambda_code_signing_config.*.config_id, [""]), 0)
}

output "lambda_code_signing_config_last_modified" {
  description = "The date and time that the code signing configuration was last modified."
  value       = element(concat(aws_lambda_code_signing_config.lambda_code_signing_config.*.last_modified, [""]), 0)
}
