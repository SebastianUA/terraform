#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST"
}

variable "environment" {
  description = "Environment for service"
  default     = "STAGE"
}

variable "tags" {
  description = "A list of tag blocks."
  type        = map(string)
  default     = {}
}

#---------------------------------------------------
# AWS Lambda function
#---------------------------------------------------
variable "enable_lambda_function" {
  description = "Enable lambda function usage"
  default     = false
}

variable "lambda_function_name" {
  description = "A unique name for your Lambda Function."
  default     = ""
}

variable "lambda_function_handler" {
  description = "(Required) The function entrypoint in your code."
  default     = null
}

variable "lambda_function_role" {
  description = "(Required) IAM role attached to the Lambda Function. This governs both who / what can invoke your Lambda Function, as well as what resources our Lambda Function has access to. See Lambda Permission Model for more details."
  default     = null
}

variable "lambda_function_runtime" {
  description = "(Required) See Runtimes for valid values. Valid Values: nodejs10.x | nodejs12.x | java8 | java11 | python2.7 | python3.6 | python3.7 | python3.8 | dotnetcore2.1 | dotnetcore3.1 | go1.x | ruby2.5 | ruby2.7 | provided"
  default     = "python3.7"
}

variable "lambda_function_filename" {
  description = "(Optional) The path to the function's deployment package within the local filesystem. If defined, The s3_-prefixed options cannot be used."
  default     = null
}

variable "lambda_function_s3_bucket" {
  description = "(Optional) The S3 bucket location containing the function's deployment package. Conflicts with lambda_function_filename. This bucket must reside in the same AWS region where you are creating the Lambda function."
  default     = null
}

variable "lambda_function_s3_key" {
  description = "(Optional) The S3 key of an object containing the function's deployment package. Conflicts with lambda_function_filename."
  default     = null
}

variable "lambda_function_s3_object_version" {
  description = "(Optional) The object version containing the function's deployment package. Conflicts with lambda_function_filename."
  default     = null
}

variable "lambda_function_dead_letter_config" {
  description = "(Optional) Nested block to configure the function's dead letter queue."
  default     = []
}

variable "lambda_function_tracing_config" {
  description = "Use tracing config"
  default     = []
}

variable "lambda_function_description" {
  description = "(Optional) Description of what your Lambda Function does."
  default     = null
}

variable "lambda_function_layers" {
  description = "(Optional) List of Lambda Layer Version ARNs (maximum of 5) to attach to your Lambda Function. See Lambda Layers"
  default     = null
}

variable "lambda_function_memory_size" {
  description = "(Optional) Amount of memory in MB your Lambda Function can use at runtime. Defaults to 128"
  default     = 128
}

variable "lambda_function_timeout" {
  description = "(Optional) The amount of time your Lambda Function has to run in seconds. Defaults to 3."
  default     = 3
}

variable "lambda_function_reserved_concurrent_executions" {
  description = "(Optional) The amount of reserved concurrent executions for this lambda function. A value of 0 disables lambda from being triggered and -1 removes any concurrency limitations. Defaults to Unreserved Concurrency Limits -1"
  default     = "-1"
}

variable "lambda_function_publish" {
  description = "(Optional) Whether to publish creation/change as new Lambda Function Version. Defaults to false."
  default     = false
}

variable "lambda_function_vpc_config" {
  description = "(Optional) Provide this to allow your function to access your VPC."
  default     = []
}

variable "lambda_function_kms_key_arn" {
  description = "(Optional) Amazon Resource Name (ARN) of the AWS Key Management Service (KMS) key that is used to encrypt environment variables. If this configuration is not provided when environment variables are in use, AWS Lambda uses a default service key. If this configuration is provided when environment variables are not in use, the AWS Lambda API does not save this configuration and Terraform will show a perpetual difference of adding the key. To fix the perpetual difference, remove this configuration."
  default     = null
}

variable "lambda_function_source_code_hash" {
  description = "(Optional) Used to trigger updates. Must be set to a base64-encoded SHA256 hash of the package file specified with either filename or s3_key. The usual way to set this is filebase64sha256('file.zip') (Terraform 0.11.12 and later) or base64sha256(file('file.zip')) (Terraform 0.11.11 and earlier), where 'file.zip' is the local filename of the lambda function source archive."
  default     = null
}

variable "lambda_function_environment" {
  description = "(Optional) The Lambda environment's configuration settings."
  default     = null
}

variable "lambda_function_timeouts" {
  description = "Set timeouts for AWS Lambda"
  default     = {}
}

#---------------------------------------------------
# AWS lambda alias
#---------------------------------------------------
variable "enable_lambda_alias" {
  description = "Enable AWS LAmbda alias usage"
  default     = false
}

variable "lambda_alias_name" {
  description = "Name for the alias you are creating. Pattern: (?!^[0-9]+$)([a-zA-Z0-9-_]+)"
  default     = ""
}

variable "lambda_alias_description" {
  description = "(Optional) Description of the alias."
  default     = null
}

variable "lambda_alias_function_name" {
  description = "The function ARN of the Lambda function for which you want to create an alias."
  default     = ""
}

variable "lambda_alias_function_version" {
  description = "(Required) Lambda function version for which you are creating the alias."
  default     = "$LATEST"
}

variable "lambda_alias_routing_config" {
  description = "(Optional) The Lambda alias' route configuration settings."
  default     = {}
}

#---------------------------------------------------
# AWS lambda event source mapping
#---------------------------------------------------
variable "enable_lambda_event_source_mapping" {
  description = "Enable lambda event source mapping usage"
  default     = false
}

variable "lambda_event_source_mapping_event_source_arn" {
  description = "(Required) The event source ARN - can be a Kinesis stream, DynamoDB stream, or SQS queue."
  default     = null
}

variable "lambda_event_source_mapping_function_name" {
  description = "The name or the ARN of the Lambda function that will be subscribing to events."
  default     = ""
}

variable "lambda_event_source_mapping_starting_position" {
  description = "(Optional) The position in the stream where AWS Lambda should start reading. Must be one of AT_TIMESTAMP (Kinesis only), LATEST or TRIM_HORIZON if getting events from Kinesis or DynamoDB. Must not be provided if getting events from SQS. More information about these positions can be found in the AWS DynamoDB Streams API Reference and AWS Kinesis API Reference."
  default     = null
}

variable "lambda_event_source_mapping_batch_size" {
  description = "(Optional) The largest number of records that Lambda will retrieve from your event source at the time of invocation. Defaults to 100 for DynamoDB and Kinesis, 10 for SQS"
  default     = 100
}

variable "lambda_event_source_mapping_maximum_batching_window_in_seconds" {
  description = "(Optional) The maximum amount of time to gather records before invoking the function, in seconds. Records will continue to buffer until either maximum_batching_window_in_seconds expires or batch_size has been met. Defaults to as soon as records are available in the stream. If the batch it reads from the stream only has one record in it, Lambda only sends one record to the function."
  default     = null
}

variable "lambda_event_source_mapping_enabled" {
  description = "(Optional) Determines if the mapping will be enabled on creation. Defaults to true."
  default     = true
}

variable "lambda_event_source_mapping_starting_position_timestamp" {
  description = "(Optional) A timestamp in RFC3339 format of the data record which to start reading when using starting_position set to AT_TIMESTAMP. If a record with this exact timestamp does not exist, the next later record is chosen. If the timestamp is older than the current trim horizon, the oldest available record is chosen."
  default     = null
}

variable "lambda_event_source_mapping_parallelization_factor" {
  description = "(Optional) The number of batches to process from each shard concurrently. Only available for stream sources (DynamoDB and Kinesis). Minimum and default of 1, maximum of 10."
  default     = 1
}

variable "lambda_event_source_mapping_maximum_retry_attempts" {
  description = "(Optional) The maximum number of times to retry when the function returns an error. Only available for stream sources (DynamoDB and Kinesis). Minimum of 0, maximum and default of 10000."
  default     = 10000
}

variable "lambda_event_source_mapping_maximum_record_age_in_seconds" {
  description = "(Optional) The maximum age of a record that Lambda sends to a function for processing. Only available for stream sources (DynamoDB and Kinesis). Minimum of 60, maximum and default of 604800."
  default     = 604800
}

variable "lambda_event_source_mapping_bisect_batch_on_function_error" {
  description = "(Optional) If the function returns an error, split the batch in two and retry. Only available for stream sources (DynamoDB and Kinesis). Defaults to false."
  default     = false
}

variable "lambda_event_source_mapping_destination_config" {
  description = "(Optional) An Amazon SQS queue or Amazon SNS topic destination for failed records. Only available for stream sources (DynamoDB and Kinesis). "
  default     = []
}

#---------------------------------------------------
# AWS lambda function event invoke config
#---------------------------------------------------
variable "enable_lambda_function_event_invoke_config" {
  description = "Enable lambda function event invoke config usage"
  default     = false
}

variable "lambda_function_event_invoke_config_function_name" {
  description = "Name or Amazon Resource Name (ARN) of the Lambda Function, omitting any version or alias qualifier."
  default     = ""
}

variable "lambda_function_event_invoke_config_qualifier" {
  description = "(Optional) Lambda Function published version, $LATEST, or Lambda Alias name."
  default     = ""
}

variable "lambda_function_event_invoke_config_maximum_event_age_in_seconds" {
  description = "(Optional) Maximum age of a request that Lambda sends to a function for processing in seconds. Valid values between 60 and 21600."
  default     = null
}

variable "lambda_function_event_invoke_config_maximum_retry_attempts" {
  description = "(Optional) Maximum number of times to retry when the function returns an error. Valid values between 0 and 2. Defaults to 2."
  default     = 2
}

variable "lambda_function_event_invoke_config_destination_config" {
  description = "(Optional) Configuration block with destination configuration with on_failure + on_success usage "
  default     = []
}

#---------------------------------------------------
# AWS lambda layer version
#---------------------------------------------------
variable "enable_lambda_layer_version" {
  description = "Enable lambda layer version usage"
  default     = false
}

variable "lambda_layer_version_layer_name" {
  description = "A unique name for your Lambda Layer"
  default     = ""
}

variable "lambda_layer_version_filename" {
  description = "(Optional) The path to the function's deployment package within the local filesystem. If defined, The s3_-prefixed options cannot be used."
  default     = null
}

variable "lambda_layer_version_compatible_runtimes" {
  description = "(Optional) A list of Runtimes this layer is compatible with. Up to 5 runtimes can be specified."
  default     = null
}

variable "lambda_layer_version_s3_bucket" {
  description = "(Optional) The S3 bucket location containing the function's deployment package. Conflicts with filename. This bucket must reside in the same AWS region where you are creating the Lambda function."
  default     = null
}

variable "lambda_layer_version_s3_key" {
  description = "(Optional) The S3 key of an object containing the function's deployment package. Conflicts with filename."
  default     = null
}

variable "lambda_layer_version_s3_object_version" {
  description = "(Optional) The object version containing the function's deployment package. Conflicts with filename."
  default     = null
}

variable "lambda_layer_version_description" {
  description = "(Optional) Description of what your Lambda Layer does."
  default     = null
}

variable "lambda_layer_version_license_info" {
  description = "(Optional) License info for your Lambda Layer. See License Info."
  default     = null
}

variable "lambda_layer_version_source_code_hash" {
  description = "(Optional) Used to trigger updates. Must be set to a base64-encoded SHA256 hash of the package file specified with either filename or s3_key. The usual way to set this is filebase64sha256."
  default     = null
}

#---------------------------------------------------
# AWS lambda provisioned concurrency config
#---------------------------------------------------
variable "enable_lambda_provisioned_concurrency_config" {
  description = "Enable lambda provisioned concurrency config usage"
  default     = false
}

variable "lambda_provisioned_concurrency_config_function_name" {
  description = "Name or Amazon Resource Name (ARN) of the Lambda Function."
  default     = ""
}

variable "lambda_provisioned_concurrency_config_qualifier" {
  description = "Lambda Function version or Lambda Alias name."
  default     = ""
}

variable "lambda_provisioned_concurrency_config_provisioned_concurrent_executions" {
  description = "(Required) Amount of capacity to allocate. Must be greater than or equal to 1."
  default     = 1
}

variable "lambda_provisioned_concurrency_config_timeouts" {
  description = "aws_lambda_provisioned_concurrency_config provides the following Timeouts configuration options that can be set up"
  default     = {}
}

#---------------------------------------------------
# AWS lambda permission
#---------------------------------------------------
variable "enable_lambda_permission" {
  description = "Enable lambda permission"
  default     = false
}

variable "lambda_permission_action" {
  description = "(Required) The AWS Lambda action you want to allow in this statement. (e.g. lambda:InvokeFunction)"
  default     = null
}

variable "lambda_permission_function_name" {
  description = "Name of the Lambda function whose resource policy you are updating"
  default     = ""
}

variable "lambda_permission_principal" {
  description = "(Required) The principal who is getting this permission. e.g. s3.amazonaws.com, an AWS account ID, or any valid AWS service principal such as events.amazonaws.com or sns.amazonaws.com."
  default     = null
}

variable "lambda_permission_event_source_token" {
  description = "(Optional) The Event Source Token to validate. Used with Alexa Skills."
  default     = null
}

variable "lambda_permission_qualifier" {
  description = "(Optional) Query parameter to specify function version or alias name. The permission will then apply to the specific qualified ARN. e.g. arn:aws:lambda:aws-region:acct-id:function:function-name:2"
  default     = null
}

variable "lambda_permission_source_account" {
  description = "(Optional) This parameter is used for S3 and SES. The AWS account ID (without a hyphen) of the source owner."
  default     = null
}

variable "lambda_permission_source_arn" {
  description = "(Optional) When granting Amazon S3 or CloudWatch Events permission to invoke your function, you should specify this field with the Amazon Resource Name (ARN) for the S3 Bucket or CloudWatch Events Rule as its value. This ensures that only events generated from the specified bucket or rule can invoke the function. API Gateway ARNs have a unique structure."
  default     = null
}

variable "lambda_permission_statement_id" {
  description = "(Optional) A unique statement identifier. By default generated by Terraform."
  default     = null
}

variable "lambda_permission_statement_id_prefix" {
  description = "(Optional) A statement identifier prefix. Terraform will generate a unique suffix. Conflicts with statement_id."
  default     = null
}

#---------------------------------------------------
# AWS lambda code signing config
#---------------------------------------------------
variable "enable_code_signing_config" {
  description = "Enable code signing config usage"
  default     = false
}

variable "lambda_code_signing_config_allowed_publishers" {
  description = "(Required) A configuration block of allowed publishers as signing profiles for this code signing configuration. "
  default     = []
}

variable "lambda_code_signing_config_description" {
  description = "(Optional) Descriptive name for this code signing configuration."
  default     = null
}

variable "lambda_code_signing_config_policies" {
  description = "(Optional) A configuration block of code signing policies that define the actions to take if the validation checks fail. "
  default     = []
}
