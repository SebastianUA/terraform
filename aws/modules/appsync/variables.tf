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
  description = "A list of tag blocks. Each element should have keys named key, value, etc."
  type        = map(string)
  default     = {}
}

#---------------------------------------------------
# AWS Appsync api key
#---------------------------------------------------
variable "enable_appsync_api_key" {
  description = "Enable appsync api key usage"
  default     = false
}

variable "appsync_api_key_api_id" {
  description = "The ID of the associated AppSync API"
  default     = ""
}

variable "appsync_api_key_description" {
  description = "(Optional) The API key description. Defaults to 'Managed by Terraform'."
  default     = "Managed by Terraform"
}

variable "appsync_api_key_expires" {
  description = "(Optional) RFC3339 string representation of the expiry date. Rounded down to nearest hour. By default, it is 7 days from the date of creation."
  default     = null
}

#---------------------------------------------------
# AWS Appsync graphql api
#---------------------------------------------------
variable "enable_appsync_graphql_api" {
  description = "Enable appsync graphql api usage"
  default     = false
}

variable "appsync_graphql_api_name" {
  description = "A user-supplied name for the GraphqlApi."
  default     = ""
}

variable "appsync_graphql_api_authentication_type" {
  description = "(Required) The authentication type. Valid values: API_KEY, AWS_IAM, AMAZON_COGNITO_USER_POOLS, OPENID_CONNECT"
  default     = "API_KEY"
}

variable "appsync_graphql_api_schema" {
  description = "(Optional) The schema definition, in GraphQL schema language format. Terraform cannot perform drift detection of this configuration."
  default     = null
}

variable "appsync_graphql_api_xray_enabled" {
  description = "(Optional) Whether tracing with X-ray is enabled. Defaults to false."
  default     = false
}

variable "appsync_graphql_api_log_config" {
  description = "(Optional) Nested argument containing logging configuration."
  default     = []
}

variable "appsync_graphql_api_openid_connect_config" {
  description = "(Optional) Nested argument containing OpenID Connect configuration."
  default     = []
}

variable "appsync_graphql_api_user_pool_config" {
  description = "(Optional) The Amazon Cognito User Pool configuration."
  default     = []
}

variable "appsync_graphql_api_additional_authentication_provider" {
  description = "(Optional) One or more additional authentication providers for the GraphqlApi."
  default     = []
}

#---------------------------------------------------
# AWS Appsync datasource
#---------------------------------------------------
variable "enable_appsync_datasource" {
  description = "Enable appsync datasource usage"
  default     = false
}

variable "appsync_datasource_name" {
  description = "A user-supplied name for the DataSource."
  default     = ""
}

variable "appsync_datasource_api_id" {
  description = "The API ID for the GraphQL API for the DataSource."
  default     = ""
}

variable "appsync_datasource_type" {
  description = "(Required) The type of the DataSource. Valid values: AWS_LAMBDA, AMAZON_DYNAMODB, AMAZON_ELASTICSEARCH, HTTP, NONE."
  default     = "NONE"
}

variable "appsync_datasource_description" {
  description = "(Optional) A description of the DataSource."
  default     = null
}

variable "appsync_datasource_service_role_arn" {
  description = "(Optional) The IAM service role ARN for the data source."
  default     = null
}

variable "appsync_datasource_dynamodb_config" {
  description = "(Optional) DynamoDB settings."
  default     = []
}

variable "appsync_datasource_elasticsearch_config" {
  description = "(Optional) Amazon Elasticsearch settings. "
  default     = []
}

variable "appsync_datasource_http_config" {
  description = "(Optional) HTTP settings."
  default     = []
}

variable "appsync_datasource_lambda_config" {
  description = "(Optional) AWS Lambda settings."
  default     = []
}

#---------------------------------------------------
# AWS Appsync function
#---------------------------------------------------
variable "enable_appsync_function" {
  description = "Enable appsync function usage"
  default     = false
}

variable "appsync_function_name" {
  description = "The Function name. The function name does not have to be unique."
  default     = ""
}

variable "appsync_function_api_id" {
  description = "The ID of the associated AppSync API."
  default     = ""
}

variable "appsync_function_data_source" {
  description = "The Function DataSource name."
  default     = ""
}

variable "appsync_function_request_mapping_template" {
  description = "(Required) The Function request mapping template. Functions support only the 2018-05-29 version of the request mapping template."
  default     = null
}

variable "appsync_function_response_mapping_template" {
  description = "(Required) The Function response mapping template."
  default     = null
}

variable "appsync_function_description" {
  description = "(Optional) The Function description."
  default     = null
}

variable "appsync_function_function_version" {
  description = "(Optional) The version of the request mapping template. Currently the supported value is 2018-05-29."
  default     = null
}

#---------------------------------------------------
# AWS Appsync resolver
#---------------------------------------------------
variable "enable_appsync_resolver" {
  description = "Enable appsync resolver usage"
  default     = false
}

variable "appsync_resolver_api_id" {
  description = "The API ID for the GraphQL API."
  default     = ""
}

variable "appsync_resolver_type" {
  description = "The type name from the schema defined in the GraphQL API."
  default     = "Query"
}

variable "appsync_resolver_field" {
  description = "(Required) The field name from the schema defined in the GraphQL API."
  default     = "singlePost"
}

variable "appsync_resolver_request_template" {
  description = "(Required) The request mapping template for UNIT resolver or 'before mapping template' for PIPELINE resolver."
  default     = null
}

variable "appsync_resolver_response_template" {
  description = "(Required) The response mapping template for UNIT resolver or 'after mapping template' for PIPELINE resolver."
  default     = null
}

variable "appsync_resolver_data_source" {
  description = "(Optional) The DataSource name."
  default     = null
}

variable "appsync_resolver_pipeline_config" {
  description = "(Optional) The PipelineConfig. "
  default     = []
}

variable "appsync_resolver_kind" {
  description = "(Optional) The resolver type. Valid values are UNIT and PIPELINE."
  default     = null
}
