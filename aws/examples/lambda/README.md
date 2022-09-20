# Work with LAMBDA via terraform

A terraform module for making LAMBDA.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#

terraform {
  required_version = "~> 1.0"
}

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
  profile                 = "default"
}

module "lambda" {
  source      = "../../modules/lambda"
  name        = "mylambdaonpython"
  environment = "dev"

  # AWS Lambda
  enable_lambda_function  = true
  lambda_function_name    = ""
  lambda_function_handler = "lambda_function.lambda_handler"
  lambda_function_role    = "arn:aws:iam::167127734783:role/test-lambda-role"
  lambda_function_runtime = "python3.7"

  lambda_function_filename         = "./additional_files/lambda_function_payload.zip"
  lambda_function_source_code_hash = filebase64sha256("./additional_files/lambda_function_payload.zip")

  lambda_function_environment = {
    key = "value",
    Env = "dev"
  }

  # AWS Lambda Alias
  enable_lambda_alias           = true
  lambda_alias_name             = ""
  lambda_alias_function_version = "$LATEST"
  lambda_alias_routing_config = {
    additional_version_weights = {
      "2" = 0.5
      "1" = 1
    }
  }

  # Add lambda event source mapping
  enable_lambda_event_source_mapping           = false
  lambda_event_source_mapping_event_source_arn = "SQS_ARN_HERE"
  ## for DynamoDB or Kinessis need to add:
  lambda_event_source_mapping_starting_position = null

  # Lambda fun event invoke config
  enable_lambda_function_event_invoke_config = false
  lambda_function_event_invoke_config_destination_config = [{
    destination_on_failure = "SQS_ARN_HERE"
    destination_on_success = "SNS_ARN_HERE"
  }]

  # Lambda provisioned concurrency config
  enable_lambda_provisioned_concurrency_config = true

  # Lambda permission
  enable_lambda_permission    = false
  lambda_permission_action    = "lambda:InvokeFunction"
  lambda_permission_principal = "events.amazonaws.com"

  lambda_permission_source_arn = "arn:aws:events:eu-west-1:111122223333:rule/RunDaily"

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. (`default = {}`)
- `enable_lambda_function` - Enable lambda function usage (`default = False`)
- `lambda_function_name` - A unique name for your Lambda Function. (`default = ""`)
- `lambda_function_handler` - (Required) The function entrypoint in your code. (`default = null`)
- `lambda_function_role` - (Required) IAM role attached to the Lambda Function. This governs both who / what can invoke your Lambda Function, as well as what resources our Lambda Function has access to. See Lambda Permission Model for more details. (`default = null`)
- `lambda_function_runtime` - (Required) See Runtimes for valid values. Valid Values: nodejs10.x | nodejs12.x | java8 | java11 | python2.7 | python3.6 | python3.7 | python3.8 | dotnetcore2.1 | dotnetcore3.1 | go1.x | ruby2.5 | ruby2.7 | provided (`default = python3.7`)
- `lambda_function_filename` - (Optional) The path to the function's deployment package within the local filesystem. If defined, The s3_-prefixed options cannot be used. (`default = null`)
- `lambda_function_s3_bucket` - (Optional) The S3 bucket location containing the function's deployment package. Conflicts with lambda_function_filename. This bucket must reside in the same AWS region where you are creating the Lambda function. (`default = null`)
- `lambda_function_s3_key` - (Optional) The S3 key of an object containing the function's deployment package. Conflicts with lambda_function_filename. (`default = null`)
- `lambda_function_s3_object_version` - (Optional) The object version containing the function's deployment package. Conflicts with lambda_function_filename. (`default = null`)
- `lambda_function_dead_letter_config` - (Optional) Nested block to configure the function's dead letter queue. (`default = []`)
- `lambda_function_tracing_config` - Use tracing config (`default = []`)
- `lambda_function_description` - (Optional) Description of what your Lambda Function does. (`default = null`)
- `lambda_function_layers` - (Optional) List of Lambda Layer Version ARNs (maximum of 5) to attach to your Lambda Function. See Lambda Layers (`default = null`)
- `lambda_function_memory_size` - (Optional) Amount of memory in MB your Lambda Function can use at runtime. Defaults to 128 (`default = 128`)
- `lambda_function_timeout` - (Optional) The amount of time your Lambda Function has to run in seconds. Defaults to 3. (`default = 3`)
- `lambda_function_reserved_concurrent_executions` - (Optional) The amount of reserved concurrent executions for this lambda function. A value of 0 disables lambda from being triggered and -1 removes any concurrency limitations. Defaults to Unreserved Concurrency Limits -1 (`default = -1`)
- `lambda_function_publish` - (Optional) Whether to publish creation/change as new Lambda Function Version. Defaults to false. (`default = False`)
- `lambda_function_vpc_config` - (Optional) Provide this to allow your function to access your VPC. (`default = []`)
- `lambda_function_kms_key_arn` - (Optional) Amazon Resource Name (ARN) of the AWS Key Management Service (KMS) key that is used to encrypt environment variables. If this configuration is not provided when environment variables are in use, AWS Lambda uses a default service key. If this configuration is provided when environment variables are not in use, the AWS Lambda API does not save this configuration and Terraform will show a perpetual difference of adding the key. To fix the perpetual difference, remove this configuration. (`default = null`)
- `lambda_function_source_code_hash` - (Optional) Used to trigger updates. Must be set to a base64-encoded SHA256 hash of the package file specified with either filename or s3_key. The usual way to set this is filebase64sha256('file.zip') (Terraform 0.11.12 and later) or base64sha256(file('file.zip')) (Terraform 0.11.11 and earlier), where 'file.zip' is the local filename of the lambda function source archive. (`default = null`)
- `lambda_function_environment` - (Optional) The Lambda environment's configuration settings. (`default = null`)
- `lambda_function_timeouts` - Set timeouts for AWS Lambda (`default = {}`)
- `enable_lambda_alias` - Enable AWS LAmbda alias usage (`default = False`)
- `lambda_alias_name` - Name for the alias you are creating. Pattern: (?!^[0-9]+$)([a-zA-Z0-9-_]+) (`default = ""`)
- `lambda_alias_description` - (Optional) Description of the alias. (`default = null`)
- `lambda_alias_function_name` - The function ARN of the Lambda function for which you want to create an alias. (`default = ""`)
- `lambda_alias_function_version` - (Required) Lambda function version for which you are creating the alias. (`default = $LATEST`)
- `lambda_alias_routing_config` - (Optional) The Lambda alias' route configuration settings. (`default = {}`)
- `enable_lambda_event_source_mapping` - Enable lambda event source mapping usage (`default = False`)
- `lambda_event_source_mapping_event_source_arn` - (Required) The event source ARN - can be a Kinesis stream, DynamoDB stream, or SQS queue. (`default = null`)
- `lambda_event_source_mapping_function_name` - The name or the ARN of the Lambda function that will be subscribing to events. (`default = ""`)
- `lambda_event_source_mapping_starting_position` - (Optional) The position in the stream where AWS Lambda should start reading. Must be one of AT_TIMESTAMP (Kinesis only), LATEST or TRIM_HORIZON if getting events from Kinesis or DynamoDB. Must not be provided if getting events from SQS. More information about these positions can be found in the AWS DynamoDB Streams API Reference and AWS Kinesis API Reference. (`default = null`)
- `lambda_event_source_mapping_batch_size` - (Optional) The largest number of records that Lambda will retrieve from your event source at the time of invocation. Defaults to 100 for DynamoDB and Kinesis, 10 for SQS (`default = 100`)
- `lambda_event_source_mapping_maximum_batching_window_in_seconds` - (Optional) The maximum amount of time to gather records before invoking the function, in seconds. Records will continue to buffer until either maximum_batching_window_in_seconds expires or batch_size has been met. Defaults to as soon as records are available in the stream. If the batch it reads from the stream only has one record in it, Lambda only sends one record to the function. (`default = null`)
- `lambda_event_source_mapping_enabled` - (Optional) Determines if the mapping will be enabled on creation. Defaults to true. (`default = True`)
- `lambda_event_source_mapping_starting_position_timestamp` - (Optional) A timestamp in RFC3339 format of the data record which to start reading when using starting_position set to AT_TIMESTAMP. If a record with this exact timestamp does not exist, the next later record is chosen. If the timestamp is older than the current trim horizon, the oldest available record is chosen. (`default = null`)
- `lambda_event_source_mapping_parallelization_factor` - (Optional) The number of batches to process from each shard concurrently. Only available for stream sources (DynamoDB and Kinesis). Minimum and default of 1, maximum of 10. (`default = 1`)
- `lambda_event_source_mapping_maximum_retry_attempts` - (Optional) The maximum number of times to retry when the function returns an error. Only available for stream sources (DynamoDB and Kinesis). Minimum of 0, maximum and default of 10000. (`default = 10000`)
- `lambda_event_source_mapping_maximum_record_age_in_seconds` - (Optional) The maximum age of a record that Lambda sends to a function for processing. Only available for stream sources (DynamoDB and Kinesis). Minimum of 60, maximum and default of 604800. (`default = 604800`)
- `lambda_event_source_mapping_bisect_batch_on_function_error` - (Optional) If the function returns an error, split the batch in two and retry. Only available for stream sources (DynamoDB and Kinesis). Defaults to false. (`default = False`)
- `lambda_event_source_mapping_destination_config` - (Optional) An Amazon SQS queue or Amazon SNS topic destination for failed records. Only available for stream sources (DynamoDB and Kinesis).  (`default = []`)
- `enable_lambda_function_event_invoke_config` - Enable lambda function event invoke config usage (`default = False`)
- `lambda_function_event_invoke_config_function_name` - Name or Amazon Resource Name (ARN) of the Lambda Function, omitting any version or alias qualifier. (`default = ""`)
- `lambda_function_event_invoke_config_qualifier` - (Optional) Lambda Function published version, $LATEST, or Lambda Alias name. (`default = ""`)
- `lambda_function_event_invoke_config_maximum_event_age_in_seconds` - (Optional) Maximum age of a request that Lambda sends to a function for processing in seconds. Valid values between 60 and 21600. (`default = null`)
- `lambda_function_event_invoke_config_maximum_retry_attempts` - (Optional) Maximum number of times to retry when the function returns an error. Valid values between 0 and 2. Defaults to 2. (`default = 2`)
- `lambda_function_event_invoke_config_destination_config` - (Optional) Configuration block with destination configuration with on_failure + on_success usage  (`default = []`)
- `enable_lambda_layer_version` - Enable lambda layer version usage (`default = False`)
- `lambda_layer_version_layer_name` - A unique name for your Lambda Layer (`default = ""`)
- `lambda_layer_version_filename` - (Optional) The path to the function's deployment package within the local filesystem. If defined, The s3_-prefixed options cannot be used. (`default = null`)
- `lambda_layer_version_compatible_runtimes` - (Optional) A list of Runtimes this layer is compatible with. Up to 5 runtimes can be specified. (`default = null`)
- `lambda_layer_version_s3_bucket` - (Optional) The S3 bucket location containing the function's deployment package. Conflicts with filename. This bucket must reside in the same AWS region where you are creating the Lambda function. (`default = null`)
- `lambda_layer_version_s3_key` - (Optional) The S3 key of an object containing the function's deployment package. Conflicts with filename. (`default = null`)
- `lambda_layer_version_s3_object_version` - (Optional) The object version containing the function's deployment package. Conflicts with filename. (`default = null`)
- `lambda_layer_version_description` - (Optional) Description of what your Lambda Layer does. (`default = null`)
- `lambda_layer_version_license_info` - (Optional) License info for your Lambda Layer. See License Info. (`default = null`)
- `lambda_layer_version_source_code_hash` - (Optional) Used to trigger updates. Must be set to a base64-encoded SHA256 hash of the package file specified with either filename or s3_key. The usual way to set this is filebase64sha256. (`default = null`)
- `enable_lambda_provisioned_concurrency_config` - Enable lambda provisioned concurrency config usage (`default = False`)
- `lambda_provisioned_concurrency_config_function_name` - Name or Amazon Resource Name (ARN) of the Lambda Function. (`default = ""`)
- `lambda_provisioned_concurrency_config_qualifier` - Lambda Function version or Lambda Alias name. (`default = ""`)
- `lambda_provisioned_concurrency_config_provisioned_concurrent_executions` - (Required) Amount of capacity to allocate. Must be greater than or equal to 1. (`default = 1`)
- `lambda_provisioned_concurrency_config_timeouts` - aws_lambda_provisioned_concurrency_config provides the following Timeouts configuration options that can be set up (`default = {}`)
- `enable_lambda_permission` - Enable lambda permission (`default = False`)
- `lambda_permission_action` - (Required) The AWS Lambda action you want to allow in this statement. (e.g. lambda:InvokeFunction) (`default = null`)
- `lambda_permission_function_name` - Name of the Lambda function whose resource policy you are updating (`default = ""`)
- `lambda_permission_principal` - (Required) The principal who is getting this permission. e.g. s3.amazonaws.com, an AWS account ID, or any valid AWS service principal such as events.amazonaws.com or sns.amazonaws.com. (`default = null`)
- `lambda_permission_event_source_token` - (Optional) The Event Source Token to validate. Used with Alexa Skills. (`default = null`)
- `lambda_permission_qualifier` - (Optional) Query parameter to specify function version or alias name. The permission will then apply to the specific qualified ARN. e.g. arn:aws:lambda:aws-region:acct-id:function:function-name:2 (`default = null`)
- `lambda_permission_source_account` - (Optional) This parameter is used for S3 and SES. The AWS account ID (without a hyphen) of the source owner. (`default = null`)
- `lambda_permission_source_arn` - (Optional) When granting Amazon S3 or CloudWatch Events permission to invoke your function, you should specify this field with the Amazon Resource Name (ARN) for the S3 Bucket or CloudWatch Events Rule as its value. This ensures that only events generated from the specified bucket or rule can invoke the function. API Gateway ARNs have a unique structure. (`default = null`)
- `lambda_permission_statement_id` - (Optional) A unique statement identifier. By default generated by Terraform. (`default = null`)
- `lambda_permission_statement_id_prefix` - (Optional) A statement identifier prefix. Terraform will generate a unique suffix. Conflicts with statement_id. (`default = null`)
- `enable_code_signing_config` - Enable code signing config usage (`default = False`)
- `lambda_code_signing_config_allowed_publishers` - (Required) A configuration block of allowed publishers as signing profiles for this code signing configuration.  (`default = []`)
- `lambda_code_signing_config_description` - (Optional) Descriptive name for this code signing configuration. (`default = null`)
- `lambda_code_signing_config_policies` - (Optional) A configuration block of code signing policies that define the actions to take if the validation checks fail.  (`default = []`)

## Module Output Variables
----------------------
- `lambda_function_id` - The Amazon Resource Name (ID) identifying your Lambda Function.
- `lambda_function_name` - The Amazon Resource Name (name) identifying your Lambda Function.
- `lambda_function_arn` - The Amazon Resource Name (ARN) identifying your Lambda Function.
- `lambda_function_qualified_arn` - The Amazon Resource Name (ARN) identifying your Lambda Function Version (if versioning is enabled via publish = true).
- `lambda_function_last_modified` - The date this resource was last modified.
- `lambda_function_kms_key_arn` - (Optional) The ARN for the KMS encryption key.
- `lambda_function_source_code_hash` - Base64-encoded representation of raw SHA-256 sum of the zip file, provided either via filename or s3_* parameters.
- `lambda_function_source_code_size` - The size in bytes of the function .zip file.
- `lambda_function_invoke_arn` - ARN to be used for invoking Lambda Function from API Gateway - to be used in aws_api_gateway_integration's uri.
- `lambda_alias_arn` - The Amazon Resource Name (ARN) identifying your Lambda function alias.
- `lambda_alias_invoke_arn` - The ARN to be used for invoking Lambda Function from API Gateway - to be used in aws_api_gateway_integration's uri
- `lambda_event_source_mapping_last_modifiedn` - The date this resource was last modified.
- `lambda_event_source_mapping_last_processing_result` - The result of the last AWS Lambda invocation of your Lambda function.
- `lambda_event_source_mapping_state` - The state of the event source mapping.
- `lambda_event_source_mapping_state_transition_reason` - The reason the event source mapping is in its current state.
- `lambda_event_source_mapping_uuid` - The UUID of the created event source mapping.
- `lambda_function_event_invoke_config_id` - Fully qualified Lambda Function name or Amazon Resource Name (ARN)
- `lambda_layer_version_arn` - The Amazon Resource Name (ARN) of the Lambda Layer with version.
- `lambda_layer_version_layer_arn` - The Amazon Resource Name (ARN) of the Lambda Layer without version.
- `lambda_layer_version_created_date` - The date this resource was created.
- `lambda_layer_version_source_code_size` - The size in bytes of the function .zip file.
- `lambda_layer_version_version` - This Lamba Layer version.
- `lambda_provisioned_concurrency_config_id` - Lambda Function name and qualifier separated by a colon (:).
- `lambda_permission_id` - ID of lambda permission
- `lambda_code_signing_config_id` - ID of lambda code signing config
- `lambda_code_signing_config_arn` - The Amazon Resource Name (ARN) of the code signing configuration.
- `lambda_code_signing_config_config_id` - Unique identifier for the code signing configuration.
- `lambda_code_signing_config_last_modified` - The date and time that the code signing configuration was last modified.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
