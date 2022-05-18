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
# AWS API Gateway v2 api mapping
#---------------------------------------------------
variable "enable_apigatewayv2_api_mapping" {
  description = "Enable apigatewayv2 api mapping usage"
  default     = false
}

variable "apigatewayv2_api_mapping_api_id" {
  description = "The API identifier."
  default     = ""
}

variable "apigatewayv2_api_mapping_domain_name" {
  description = "The domain name. Use the aws_apigatewayv2_domain_name resource to configure a domain name."
  default     = ""
}

variable "apigatewayv2_api_mapping_stage" {
  description = "The API stage. Use the aws_apigatewayv2_stage resource to configure an API stage."
  default     = ""
}

variable "apigatewayv2_api_mapping_api_mapping_key" {
  description = "(Optional) The API mapping key."
  default     = null
}

#---------------------------------------------------
# AWS API Gateway v2 api
#---------------------------------------------------
variable "enable_apigatewayv2_api" {
  description = "Enable apigatewayv2 api usage"
  default     = false
}

variable "apigatewayv2_api_name" {
  description = "The name of the API. Must be less than or equal to 128 characters in length."
  default     = ""
}

variable "apigatewayv2_api_protocol_type" {
  description = "(Required) The API protocol. Valid values: HTTP, WEBSOCKET."
  default     = null
}

variable "apigatewayv2_api_api_key_selection_expression" {
  description = "(Optional) An API key selection expression. Valid values: $context.authorizer.usageIdentifierKey, $request.header.x-api-key. Defaults to $request.header.x-api-key. Applicable for WebSocket APIs."
  default     = null
}

variable "apigatewayv2_api_credentials_arn" {
  description = "(Optional) Part of quick create. Specifies any credentials required for the integration. Applicable for HTTP APIs."
  default     = null
}

variable "apigatewayv2_api_description" {
  description = "(Optional) The description of the API. Must be less than or equal to 1024 characters in length."
  default     = null
}

variable "apigatewayv2_api_disable_execute_api_endpoint" {
  description = "(Optional) Whether clients can invoke the API by using the default execute-api endpoint. By default, clients can invoke the API with the default {api_id}.execute-api.{region}.amazonaws.com endpoint. To require that clients use a custom domain name to invoke the API, disable the default endpoint."
  default     = null
}

variable "apigatewayv2_api_route_key" {
  description = "(Optional) Part of quick create. Specifies any route key. Applicable for HTTP APIs."
  default     = null
}

variable "apigatewayv2_api_route_selection_expression" {
  description = "(Optional) The route selection expression for the API. Defaults to $request.method $request.path"
  default     = null
}

variable "apigatewayv2_api_target" {
  description = "(Optional) Part of quick create. Quick create produces an API with an integration, a default catch-all route, and a default stage which is configured to automatically deploy changes. For HTTP integrations, specify a fully qualified URL. For Lambda integrations, specify a function ARN. The type of the integration will be HTTP_PROXY or AWS_PROXY, respectively. Applicable for HTTP APIs."
  default     = null
}

variable "apigatewayv2_api_body" {
  description = "(Optional) An OpenAPI specification that defines the set of routes and integrations to create as part of the HTTP APIs. Supported only for HTTP APIs."
  default     = null
}

variable "apigatewayv2_api_version" {
  description = "(Optional) A version identifier for the API. Must be between 1 and 64 characters in length."
  default     = null
}

variable "apigatewayv2_api_fail_on_warnings" {
  description = "(Optional) Whether warnings should return an error while API Gateway is creating or updating the resource using an OpenAPI specification. Defaults to false. Applicable for HTTP APIs."
  default     = null
}

variable "apigatewayv2_api_cors_configuration" {
  description = "(Optional) The cross-origin resource sharing (CORS) configuration. Applicable for HTTP APIs."
  default     = {}
}

#---------------------------------------------------
# AWS API Gateway v2 domain name
#---------------------------------------------------
variable "enable_apigatewayv2_domain_name" {
  description = "Enable apigatewayv2 domain name usage"
  default     = false
}

variable "apigatewayv2_domain_name_domain_name" {
  description = "(Required) Domain name. Must be between 1 and 512 characters in length."
  default     = null
}

variable "apigatewayv2_domain_name_domain_name_configuration" {
  description = "(Required) Domain name configuration."
  default     = {}
}

variable "apigatewayv2_domain_name_mutual_tls_authentication" {
  description = "(Optional) Mutual TLS authentication configuration for the domain name."
  default     = {}
}

variable "apigatewayv2_domain_name_timeouts" {
  description = "Set timeouts for apigatewayv2 domain name"
  default     = {}
}

#---------------------------------------------------
# AWS API Gateway v2 stage
#---------------------------------------------------
variable "enable_apigatewayv2_stage" {
  description = "Enable apigatewayv2 stage usage"
  default     = false
}

variable "apigatewayv2_stage_name" {
  description = "The name of the stage. Must be between 1 and 128 characters in length."
  default     = ""
}

variable "apigatewayv2_stage_api_id" {
  description = "The API identifier."
  default     = ""
}

variable "apigatewayv2_stage_auto_deploy" {
  description = "(Optional) Whether updates to an API automatically trigger a new deployment. Defaults to false. Applicable for HTTP APIs."
  default     = null
}

variable "apigatewayv2_stage_client_certificate_id" {
  description = "(Optional) The identifier of a client certificate for the stage. Use the aws_api_gateway_client_certificate resource to configure a client certificate. Supported only for WebSocket APIs."
  default     = null
}

variable "apigatewayv2_stage_deployment_id" {
  description = "(Optional) The deployment identifier of the stage. Use the aws_apigatewayv2_deployment resource to configure a deployment."
  default     = null
}

variable "apigatewayv2_stage_description" {
  description = "(Optional) The description for the stage. Must be less than or equal to 1024 characters in length."
  default     = null
}

variable "apigatewayv2_stage_stage_variables" {
  description = "(Optional) A map that defines the stage variables for the stage."
  default     = null
}

variable "apigatewayv2_stage_access_log_settings" {
  description = "(Optional) Settings for logging access in this stage. Use the aws_api_gateway_account resource to configure permissions for CloudWatch Logging."
  default     = {}
}

variable "apigatewayv2_stage_default_route_settings" {
  description = "(Optional) The default route settings for the stage."
  default     = {}
}

variable "apigatewayv2_stage_route_settings" {
  description = "(Optional) Route settings for the stage."
  default     = {}
}

#---------------------------------------------------
# AWS API Gateway v2 authorizer
#---------------------------------------------------
variable "enable_apigatewayv2_authorizer" {
  description = "Enable apigatewayv2 authorizer usage"
  default     = false
}

variable "apigatewayv2_authorizer_name" {
  description = "The name of the authorizer. Must be between 1 and 128 characters in length."
  default     = ""
}

variable "apigatewayv2_authorizer_api_id" {
  description = "The API identifier."
  default     = ""
}

variable "apigatewayv2_authorizer_authorizer_type" {
  description = "(Required) The authorizer type. Valid values: JWT, REQUEST. Specify REQUEST for a Lambda function using incoming request parameters. For HTTP APIs, specify JWT to use JSON Web Tokens."
  default     = null
}

variable "apigatewayv2_authorizer_authorizer_credentials_arn" {
  description = "(Optional) The required credentials as an IAM role for API Gateway to invoke the authorizer. Supported only for REQUEST authorizers."
  default     = null
}

variable "apigatewayv2_authorizer_authorizer_payload_format_version" {
  description = "Optional) The format of the payload sent to an HTTP API Lambda authorizer. Required for HTTP API Lambda authorizers. Valid values: 1.0, 2.0."
  default     = null
}

variable "apigatewayv2_authorizer_authorizer_result_ttl_in_seconds" {
  description = "(Optional) The time to live (TTL) for cached authorizer results, in seconds. If it equals 0, authorization caching is disabled. If it is greater than 0, API Gateway caches authorizer responses. The maximum value is 3600, or 1 hour. Defaults to 300. Supported only for HTTP API Lambda authorizers."
  default     = null
}

variable "apigatewayv2_authorizer_authorizer_uri" {
  description = "(Optional) The authorizer's Uniform Resource Identifier (URI). For REQUEST authorizers this must be a well-formed Lambda function URI, such as the invoke_arn attribute of the aws_lambda_function resource. Supported only for REQUEST authorizers. Must be between 1 and 2048 characters in length."
  default     = null
}

variable "apigatewayv2_authorizer_enable_simple_responses" {
  description = "(Optional) Whether a Lambda authorizer returns a response in a simple format. If enabled, the Lambda authorizer can return a boolean value instead of an IAM policy. Supported only for HTTP APIs."
  default     = null
}

variable "apigatewayv2_authorizer_identity_sources" {
  description = "(Optional) The identity sources for which authorization is requested. For REQUEST authorizers the value is a list of one or more mapping expressions of the specified request parameters. For JWT authorizers the single entry specifies where to extract the JSON Web Token (JWT) from inbound requests."
  default     = null
}

variable "apigatewayv2_authorizer_jwt_configuration" {
  description = "(Optional) The configuration of a JWT authorizer. Required for the JWT authorizer type. Supported only for HTTP APIs."
  default     = {}
}

#---------------------------------------------------
# AWS API Gateway v2 deployment
#---------------------------------------------------
variable "enable_apigatewayv2_deployment" {
  description = "Enable apigatewayv2 deployment usage"
  default     = false
}

variable "apigatewayv2_deployment_api_id" {
  description = "The API identifier."
  default     = ""
}

variable "apigatewayv2_deployment_description" {
  description = "(Optional) The description for the deployment resource. Must be less than or equal to 1024 characters in length."
  default     = null
}

variable "apigatewayv2_deployment_triggers" {
  description = "(Optional) A map of arbitrary keys and values that, when changed, will trigger a redeployment. To force a redeployment without changing these keys/values, use the terraform taint command."
  default     = null
}

#---------------------------------------------------
# AWS API Gateway v2 integration
#---------------------------------------------------
variable "enable_apigatewayv2_integration" {
  description = "Enable apigatewayv2 integration usage"
  default     = false
}

variable "apigatewayv2_integration_api_id" {
  description = "The API identifier."
  default     = ""
}

variable "apigatewayv2_integration_integration_type" {
  description = "(Required) The integration type of an integration. Valid values: AWS (supported only for WebSocket APIs), AWS_PROXY, HTTP (supported only for WebSocket APIs), HTTP_PROXY, MOCK (supported only for WebSocket APIs). For an HTTP API private integration, use HTTP_PROXY."
  default     = null
}

variable "apigatewayv2_integration_connection_id" {
  description = "(Optional) The ID of the VPC link for a private integration. Supported only for HTTP APIs. Must be between 1 and 1024 characters in length."
  default     = null
}

variable "apigatewayv2_integration_connection_type" {
  description = "(Optional) The type of the network connection to the integration endpoint. Valid values: INTERNET, VPC_LINK. Default is INTERNET."
  default     = null
}

variable "apigatewayv2_integration_content_handling_strategy" {
  description = "Optional) How to handle response payload content type conversions. Valid values: CONVERT_TO_BINARY, CONVERT_TO_TEXT. Supported only for WebSocket APIs."
  default     = null
}

variable "apigatewayv2_integration_credentials_arn" {
  description = "(Optional) The credentials required for the integration, if any."
  default     = null
}

variable "apigatewayv2_integration_description" {
  description = "(Optional) The description of the integration."
  default     = null
}

variable "apigatewayv2_integration_integration_method" {
  description = "(Optional) The integration's HTTP method. Must be specified if integration_type is not MOCK."
  default     = null
}

variable "apigatewayv2_integration_integration_subtype" {
  description = "(Optional) Specifies the AWS service action to invoke. Supported only for HTTP APIs when integration_type is AWS_PROXY. See the AWS service integration reference documentation for supported values. Must be between 1 and 128 characters in length."
  default     = null
}

variable "apigatewayv2_integration_integration_uri" {
  description = "(Optional) The URI of the Lambda function for a Lambda proxy integration, when integration_type is AWS_PROXY. For an HTTP integration, specify a fully-qualified URL. For an HTTP API private integration, specify the ARN of an Application Load Balancer listener, Network Load Balancer listener, or AWS Cloud Map service."
  default     = null
}

variable "apigatewayv2_integration_passthrough_behavior" {
  description = "(Optional) The pass-through behavior for incoming requests based on the Content-Type header in the request, and the available mapping templates specified as the request_templates attribute. Valid values: WHEN_NO_MATCH, WHEN_NO_TEMPLATES, NEVER. Default is WHEN_NO_MATCH. Supported only for WebSocket APIs."
  default     = null
}

variable "apigatewayv2_integration_payload_format_version" {
  description = "(Optional) The format of the payload sent to an integration. Valid values: 1.0, 2.0. Default is 1.0."
  default     = null
}

variable "apigatewayv2_integration_request_parameters" {
  description = "(Optional) For WebSocket APIs, a key-value map specifying request parameters that are passed from the method request to the backend. For HTTP APIs with a specified integration_subtype, a key-value map specifying parameters that are passed to AWS_PROXY integrations. For HTTP APIs without a specified integration_subtype, a key-value map specifying how to transform HTTP requests before sending them to the backend. See the Amazon API Gateway Developer Guide for details."
  default     = null
}

variable "apigatewayv2_integration_request_templates" {
  description = "(Optional) A map of Velocity templates that are applied on the request payload based on the value of the Content-Type header sent by the client. Supported only for WebSocket APIs."
  default     = null
}

variable "apigatewayv2_integration_template_selection_expression" {
  description = "(Optional) Mappings to transform the HTTP response from a backend integration before returning the response to clients. Supported only for HTTP APIs."
  default     = null
}

variable "apigatewayv2_integration_timeout_milliseconds" {
  description = "(Optional) Custom timeout between 50 and 29,000 milliseconds for WebSocket APIs and between 50 and 30,000 milliseconds for HTTP APIs. The default timeout is 29 seconds for WebSocket APIs and 30 seconds for HTTP APIs. Terraform will only perform drift detection of its value when present in a configuration."
  default     = null
}

variable "apigatewayv2_integration_response_parameters" {
  description = "(Optional) Mappings to transform the HTTP response from a backend integration before returning the response to clients. Supported only for HTTP APIs."
  default     = {}
}

variable "apigatewayv2_integration_tls_config" {
  description = "(Optional) The TLS configuration for a private integration. Supported only for HTTP APIs."
  default     = {}
}

#---------------------------------------------------
# AWS API Gateway v2 integration response
#---------------------------------------------------
variable "enable_apigatewayv2_integration_response" {
  description = "Enable apigatewayv2 integration response usage"
  default     = false
}

variable "apigatewayv2_integration_response_api_id" {
  description = "The API identifier."
  default     = ""
}

variable "apigatewayv2_integration_response_integration_id" {
  description = "The identifier of the aws_apigatewayv2_integration."
  default     = ""
}

variable "apigatewayv2_integration_response_integration_response_key" {
  description = "(Required) The integration response key."
  default     = null
}

variable "apigatewayv2_integration_response_content_handling_strategy" {
  description = "(Optional) How to handle response payload content type conversions. Valid values: CONVERT_TO_BINARY, CONVERT_TO_TEXT"
  default     = null
}

variable "apigatewayv2_integration_response_response_templates" {
  description = "(Optional) A map of Velocity templates that are applied on the request payload based on the value of the Content-Type header sent by the client."
  default     = null
}

variable "apigatewayv2_integration_response_template_selection_expression" {
  description = "(Optional) The template selection expression for the integration response."
  default     = null
}

#---------------------------------------------------
# AWS API Gateway vpc link
#---------------------------------------------------
variable "enable_apigatewayv2_vpc_link" {
  description = "Enable apigatewayv2 vpc link usage"
  default     = false
}

variable "apigatewayv2_vpc_link_name" {
  description = "The name of the VPC Link. Must be between 1 and 128 characters in length."
  default     = ""
}

variable "apigatewayv2_vpc_link_security_group_ids" {
  description = "(Required) Security group IDs for the VPC Link."
  default     = null
}

variable "apigatewayv2_vpc_link_subnet_ids" {
  description = "(Required) Subnet IDs for the VPC Link."
  default     = null
}

#---------------------------------------------------
# AWS API Gateway v2 model
#---------------------------------------------------
variable "enable_apigatewayv2_model" {
  description = "Enable apigatewayv2 model usage"
  default     = false
}

variable "apigatewayv2_model_name" {
  description = "The name of the model. Must be alphanumeric. Must be between 1 and 128 characters in length."
  default     = ""
}

variable "apigatewayv2_model_api_id" {
  description = "The API identifier."
  default     = ""
}

variable "apigatewayv2_model_content_type" {
  description = "(Required) The content-type for the model, for example, application/json. Must be between 1 and 256 characters in length."
  default     = null
}

variable "apigatewayv2_model_schema" {
  description = "(Required) The schema for the model. This should be a JSON schema draft 4 model. Must be less than or equal to 32768 characters in length."
  default     = null
}

variable "apigatewayv2_model_description" {
  description = "(Optional) The description of the model. Must be between 1 and 128 characters in length."
  default     = null
}

#---------------------------------------------------
# AWS API Gateway v2 route
#---------------------------------------------------
variable "enable_apigatewayv2_route" {
  description = "Enable apigatewayv2 route usage"
  default     = false
}

variable "apigatewayv2_route_api_id" {
  description = "The API identifier."
  default     = ""
}

variable "apigatewayv2_route_route_key" {
  description = "(Required) The route key for the route. For HTTP APIs, the route key can be either $default, or a combination of an HTTP method and resource path, for example, GET /pets."
  default     = null
}

variable "apigatewayv2_route_api_key_required" {
  description = "(Optional) Boolean whether an API key is required for the route. Defaults to false. Supported only for WebSocket APIs."
  default     = null
}

variable "apigatewayv2_route_authorization_scopes" {
  description = "(Optional) The authorization scopes supported by this route. The scopes are used with a JWT authorizer to authorize the method invocation."
  default     = null
}

variable "apigatewayv2_route_authorization_type" {
  description = "(Optional) The authorization type for the route. For WebSocket APIs, valid values are NONE for open access, AWS_IAM for using AWS IAM permissions, and CUSTOM for using a Lambda authorizer. For HTTP APIs, valid values are NONE for open access, JWT for using JSON Web Tokens, AWS_IAM for using AWS IAM permissions, and CUSTOM for using a Lambda authorizer. Defaults to NONE"
  default     = null
}

variable "apigatewayv2_route_authorizer_id" {
  description = "(Optional) The identifier of the aws_apigatewayv2_authorizer resource to be associated with this route."
  default     = null
}

variable "apigatewayv2_route_model_selection_expression" {
  description = "(Optional) The model selection expression for the route. Supported only for WebSocket APIs."
  default     = null
}

variable "apigatewayv2_route_operation_name" {
  description = "(Optional) The operation name for the route. Must be between 1 and 64 characters in length."
  default     = null
}

variable "apigatewayv2_route_request_models" {
  description = "(Optional) The request models for the route. Supported only for WebSocket APIs."
  default     = null
}

variable "apigatewayv2_route_route_response_selection_expression" {
  description = "(Optional) The route response selection expression for the route. Supported only for WebSocket APIs."
  default     = null
}

variable "apigatewayv2_route_target" {
  description = "(Optional) The target for the route, of the form integrations/IntegrationID, where IntegrationID is the identifier of an aws_apigatewayv2_integration resource."
  default     = null
}

variable "apigatewayv2_route_request_parameter" {
  description = "Optional) The request parameters for the route. Supported only for WebSocket APIs."
  default     = {}
}

#---------------------------------------------------
# AWS API Gateway v2 route response
#---------------------------------------------------
variable "enable_apigatewayv2_route_response" {
  description = "Enable apigatewayv2 route response usage"
  default     = false
}

variable "apigatewayv2_route_response_api_id" {
  description = "The API identifier."
  default     = ""
}

variable "apigatewayv2_route_response_route_id" {
  description = "The identifier of the aws_apigatewayv2_route."
  default     = ""
}

variable "apigatewayv2_route_response_route_response_key" {
  description = "(Required) The route response key."
  default     = null
}

variable "apigatewayv2_route_response_model_selection_expression" {
  description = "(Optional) The model selection expression for the route response."
  default     = null
}

variable "apigatewayv2_route_response_response_models" {
  description = "(Optional) The response models for the route response."
  default     = null
}