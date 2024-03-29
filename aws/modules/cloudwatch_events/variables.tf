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
  description = "Add additional tags"
  default     = {}
}

#---------------------------------------------------
# AWS CloudWatch event rule
#---------------------------------------------------
variable "enable_cloudwatch_event_rule" {
  description = "Enable cloudwatch event rule usage"
  default     = false
}

variable "cloudwatch_event_rule_name" {
  description = "(Optional) The name of the rule. If omitted, Terraform will assign a random, unique name. Conflicts with name_prefix"
  default     = null
}

variable "cloudwatch_event_rule_name_prefix" {
  description = "(Optional) Creates a unique name beginning with the specified prefix. Conflicts with name. Note: Due to the length of the generated suffix, must be 38 characters or less."
  default     = null
}

variable "cloudwatch_event_rule_description" {
  description = "(Optional) The description of the rule."
  default     = null
}

variable "cloudwatch_event_rule_schedule_expression" {
  description = "(Optional) The scheduling expression. For example, cron(0 20 * * ? *) or rate(5 minutes). At least one of schedule_expression or event_pattern is required. Can only be used on the default event bus. For more information, refer to the AWS documentation Schedule Expressions for Rules."
  default     = null
}

variable "cloudwatch_event_rule_event_bus_name" {
  description = "(Optional) The name or ARN of the event bus to associate with this rule. If you omit this, the default event bus is used."
  default     = null
}

variable "cloudwatch_event_rule_event_pattern" {
  description = "(Optional) The event pattern described a JSON object. At least one of schedule_expression or event_pattern is required. See full documentation of Events and Event Patterns in EventBridge for details."
  default     = null
}

variable "cloudwatch_event_rule_role_arn" {
  description = "(Optional) The Amazon Resource Name (ARN) associated with the role that is used for target invocation."
  default     = null
}

variable "cloudwatch_event_rule_is_enabled" {
  description = "(Optional) Whether the rule should be enabled (defaults to true)."
  default     = null
}

#---------------------------------------------------
# Cloudwatch event permission
#---------------------------------------------------
variable "enable_cloudwatch_event_permission" {
  description = "Enable cloudwatch event permission usage"
  default     = false
}

variable "cloudwatch_event_permission_principal" {
  description = "Required) The 12-digit AWS account ID that you are permitting to put events to your default event bus. Specify * to permit any account to put events to your default event bus, optionally limited by condition."
  default     = null
}

variable "cloudwatch_event_permission_statement_id" {
  description = "(Required) An identifier string for the external account that you are granting permissions to."
  default     = null
}

variable "cloudwatch_event_permission_action" {
  description = "(Optional) The action that you are enabling the other account to perform. Defaults to events:PutEvents."
  default     = null
}

variable "cloudwatch_event_permission_event_bus_name" {
  description = "(Optional) The name of the event bus to set the permissions on. If you omit this, the permissions are set on the default event bus."
  default     = null
}

variable "cloudwatch_event_permission_condition" {
  description = "(Optional) Configuration block to limit the event bus permissions you are granting to only accounts that fulfill the condition"
  default     = []
}

#---------------------------------------------------
# Cloudwatch event api destination
#---------------------------------------------------
variable "enable_cloudwatch_event_api_destination" {
  description = "Enable cloudwatch event api destination usage"
  default     = false
}

variable "cloudwatch_event_api_destination_name" {
  description = "(Required) The name of the new API Destination. The name must be unique for your account. Maximum of 64 characters consisting of numbers, lower/upper case letters, .,-,_."
  default     = ""
}

variable "cloudwatch_event_api_destination_invocation_endpoint" {
  description = "(Required) URL endpoint to invoke as a target. This could be a valid endpoint generated by a partner service. You can include " * " as path parameters wildcards to be set from the Target HttpParameters."
  default     = null
}

variable "cloudwatch_event_api_destination_http_method" {
  description = "(Required) Select the HTTP method used for the invocation endpoint, such as GET, POST, PUT, etc."
  default     = null
}

variable "cloudwatch_event_api_destination_connection_arn" {
  description = "(Required) ARN of the EventBridge Connection to use for the API Destination."
  default     = null
}

variable "cloudwatch_event_api_destination_description" {
  description = "(Optional) The description of the new API Destination. Maximum of 512 characters."
  default     = null
}

variable "cloudwatch_event_api_destination_invocation_rate_limit_per_second" {
  description = "(Optional) Enter the maximum number of invocations per second to allow for this destination. Enter a value greater than 0 (default 300)."
  default     = null
}

#---------------------------------------------------
# Cloudwatch event archive
#---------------------------------------------------
variable "enable_cloudwatch_event_archive" {
  description = "Enable cloudwatch event archive usage"
  default     = false
}

variable "cloudwatch_event_archive_name" {
  description = "The name of the new event archive. The archive name cannot exceed 48 characters."
  default     = ""
}

variable "cloudwatch_event_archive_event_source_arn" {
  description = "(Required) Event bus source ARN from where these events should be archived."
  default     = null
}

variable "cloudwatch_event_archive_description" {
  description = "(Optional) The description of the new event archive."
  default     = null
}

variable "cloudwatch_event_archive_event_pattern" {
  description = "(Optional) Instructs the new event archive to only capture events matched by this pattern. By default, it attempts to archive every event received in the event_source_arn."
  default     = null
}

variable "cloudwatch_event_archive_retention_days" {
  description = "(Optional) The maximum number of days to retain events in the new event archive. By default, it archives indefinitely."
  default     = null
}

#---------------------------------------------------
# Cloudwatch event bus policy
#---------------------------------------------------
variable "enable_cloudwatch_event_bus_policy" {
  description = "Enable cloudwatch event bus policy usage"
  default     = false
}

variable "cloudwatch_event_bus_policy_policy" {
  description = "(Required) The text of the policy. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide."
  default     = null
}

variable "cloudwatch_event_bus_policy_event_bus_name" {
  description = "(Optional) The name of the event bus to set the permissions on. If you omit this, the permissions are set on the default event bus."
  default     = null
}

#---------------------------------------------------
# Cloudwatch event bus
#---------------------------------------------------
variable "enable_cloudwatch_event_bus" {
  description = "Enable cloudwatch event bus usage"
  default     = false
}

variable "cloudwatch_event_bus_name" {
  description = "The name of the new event bus. The names of custom event buses can't contain the / character. To create a partner event bus, ensure the name matches the event_source_name."
  default     = ""
}

variable "cloudwatch_event_bus_event_source_name" {
  description = "(Optional) The partner event source that the new event bus will be matched with. Must match name."
  default     = null
}

#---------------------------------------------------
# Cloudwatch event target
#---------------------------------------------------
variable "enable_cloudwatch_event_target" {
  description = "Enable cloudwatch event target usage"
  default     = false
}

variable "cloudwatch_event_target_rule" {
  description = "(Required) The name of the rule you want to add targets to."
  default     = ""
}

variable "cloudwatch_event_target_arn" {
  description = "Required) The Amazon Resource Name (ARN) of the target."
  default     = null
}

variable "cloudwatch_event_target_event_bus_name" {
  description = "(Optional) The name or ARN of the event bus to associate with the rule. If you omit this, the default event bus is used."
  default     = null
}

variable "cloudwatch_event_target_input" {
  description = "(Optional) Valid JSON text passed to the target. Conflicts with input_path and input_transformer."
  default     = null
}

variable "cloudwatch_event_target_input_path" {
  description = "(Optional) The value of the JSONPath that is used for extracting part of the matched event when passing it to the target. Conflicts with input and input_transformer."
  default     = null
}

variable "cloudwatch_event_target_input_transformer" {
  description = "(Optional) Parameters used when you are providing a custom input to a target based on certain event data. Conflicts with input and input_path"
  default     = null
}

variable "cloudwatch_event_target_role_arn" {
  description = "(Optional) The Amazon Resource Name (ARN) of the IAM role to be used for this target when the rule is triggered. Required if ecs_target is used or target in arn is EC2 instance, Kinesis data stream, Step Functions state machine, or Event Bus in different account or region."
  default     = null
}

variable "cloudwatch_event_target_target_id" {
  description = "(Optional) The unique target assignment ID. If missing, will generate a random, unique id."
  default     = null
}

variable "cloudwatch_event_target_batch_target" {
  description = "(Optional) Parameters used when you are using the rule to invoke an Amazon Batch Job"
  default     = {}
}

variable "cloudwatch_event_target_dead_letter_config" {
  description = "(Optional) Parameters used when you are providing a dead letter config. A maximum of 1 are allowed."
  default     = {}
}

variable "cloudwatch_event_target_ecs_target" {
  description = "(Optional) Parameters used when you are using the rule to invoke Amazon ECS Task. A maximum of 1 are allowed."
  default     = {}
}

variable "cloudwatch_event_target_http_target" {
  description = "(Optional) Parameters used when you are using the rule to invoke an API Gateway REST endpoint. A maximum of 1 is allowed."
  default     = {}
}

variable "cloudwatch_event_target_kinesis_target" {
  description = "(Optional) Parameters used when you are using the rule to invoke an Amazon Kinesis Stream. A maximum of 1 are allowed."
  default     = {}
}

variable "cloudwatch_event_target_run_command_targets" {
  description = "(Optional) Parameters used when you are using the rule to invoke Amazon EC2 Run Command. A maximum of 5 are allowed."
  default     = []
}

variable "cloudwatch_event_target_redshift_target" {
  description = "(Optional) Parameters used when you are using the rule to invoke an Amazon Redshift Statement. A maximum of 1 are allowed."
  default     = {}
}

variable "cloudwatch_event_target_retry_policy" {
  description = "(Optional) Parameters used when you are providing retry policies. A maximum of 1 are allowed."
  default     = {}
}

variable "cloudwatch_event_target_sagemaker_pipeline_target" {
  description = "(Optional) Parameters used when you are using the rule to invoke an Amazon SageMaker Pipeline. A maximum of 1 are allowed."
  default     = {}
}

variable "cloudwatch_event_target_sqs_target" {
  description = "(Optional) Parameters used when you are using the rule to invoke an Amazon SQS Queue. A maximum of 1 are allowed."
  default     = {}
}

#---------------------------------------------------
# AWS CloudWatch event endpoint
#---------------------------------------------------
variable "enable_cloudwatch_event_endpoint" {
  description = "Enable cloudwatch event endpoint usage"
  default     = false
}

variable "cloudwatch_event_endpoint_description" {
  description = "(Optional) A description of the global endpoint."
  default     = null
}

variable "cloudwatch_event_endpoint_role_arn" {
  description = "(Optional) The ARN of the IAM role used for replication between event buses."
  default     = null
}

variable "cloudwatch_event_endpoint_event_bus" {
  description = "(Required) The event buses to use. The names of the event buses must be identical in each Region. Exactly two event buses are required."
  default     = {}
}

variable "cloudwatch_event_endpoint_replication_config" {
  description = "(Optional) Parameters used for replication"
  default     = {}
}

variable "cloudwatch_event_endpoint_routing_config" {
  description = "(Required) Parameters used for routing, including the health check and secondary Region"
  default     = {}
}

#---------------------------------------------------
# Cloudwatch event connection
#---------------------------------------------------
variable "enable_cloudwatch_event_connection" {
  description = "Enable cloudwatch event connection usage"
  default     = false
}

variable "cloudwatch_event_connection_name" {
  description = "The name of the new connection. Maximum of 64 characters consisting of numbers, lower/upper case letters, .,-,_."
  default     = ""
}

variable "cloudwatch_event_connection_authorization_type" {
  description = "(Required) Choose the type of authorization to use for the connection. One of API_KEY,BASIC,OAUTH_CLIENT_CREDENTIALS."
  default     = null
}

variable "cloudwatch_event_connection_description" {
  description = "(Optional) Enter a description for the connection. Maximum of 512 characters."
  default     = null
}

variable "cloudwatch_event_connection_invocation_http_parameters" {
  description = "(Optional) Invocation Http Parameters are additional credentials used to sign each Invocation of the ApiDestination created from this Connection. If the ApiDestination Rule Target has additional HttpParameters, the values will be merged together, with the Connection Invocation Http Parameters taking precedence. Secret values are stored and managed by AWS Secrets Manager. A maximum of 1 are allowed."
  default     = {}
}

variable "cloudwatch_event_connection_auth_parameters" {
  description = "(Required) Parameters used for authorization. A maximum of 1 are allowed"
  default     = {}
}