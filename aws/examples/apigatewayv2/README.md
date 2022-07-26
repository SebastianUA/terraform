# Work with APIGATEWAYV2 via terraform

A terraform module for making APIGATEWAYV2.


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
  region                  = "us-west-2"
  profile                 = "default"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "apigatewayv2" {
  source = "../../modules/apigatewayv2"


  // API gateway v2 api
  enable_apigatewayv2_api        = true
  apigatewayv2_api_name          = ""
  apigatewayv2_api_protocol_type = "HTTP"

  // API gateway v2 api domain name
  enable_apigatewayv2_domain_name      = true
  apigatewayv2_domain_name_domain_name = "domain.org"
  apigatewayv2_domain_name_domain_name_configuration = {
    certificate_arn = "aws_acm_certificate_arn"
    endpoint_type   = "REGIONAL"
    security_policy = "TLS_1_2"
  }

  // API gateway v2 api stage
  enable_apigatewayv2_stage = true
  apigatewayv2_stage_name   = ""

  // API gateway v2 api mapping
  enable_apigatewayv2_api_mapping = true

  tags = tomap({
    "Environment" = "dev",
    "Createdby"   = "Vitaliy Natarov"
  })

}

#---------------------------------------------------------------
# lambda for Firehose
#---------------------------------------------------------------
module "api_gateway_staging_firehose" {
  source = "git@github.com:sebastianua/terraform.git//aws/modules/apigatewayv2?ref=dev"

  providers = {
    aws = aws.default
  }

  name        = "test-api-gateway-staging-firehose"
  environment = "staging"

  // API gateway v2 api
  enable_apigatewayv2_api        = true
  apigatewayv2_api_name          = "test-firehose-staging-apigatewayv2"
  apigatewayv2_api_protocol_type = "HTTP"

  // API gateway v2 api stage
  enable_apigatewayv2_stage      = true
  apigatewayv2_stage_name        = "default"
  apigatewayv2_stage_auto_deploy = true

  // apigatewayv2_api_cors_configuration = {
  //   allow_credentials = ""
  //   allow_headers     = ""
  //   allow_methods     = ""
  //   allow_origins     = ""
  //   expose_headers    = ""
  //   max_age           = 3600
  // }

  depends_on = []
}

module "api_gateway_stage_staging_firehose" {
  source = "git@github.com:sebastianua/terraform.git//aws/modules/apigatewayv2?ref=dev"

  providers = {
    aws = aws.default
  }

  name        = "test-api-gateway-staging-firehose"
  environment = "staging"

  // API gateway v2 api stage
  enable_apigatewayv2_stage      = true
  apigatewayv2_stage_name        = "firehose"
  apigatewayv2_stage_auto_deploy = true
  apigatewayv2_stage_api_id      = module.api_gateway_staging_firehose.apigatewayv2_api_id

  depends_on = [
    module.api_gateway_staging_firehose
  ]
}

module "api_gateway_route_staging_firehose" {
  source = "git@github.com:sebastianua/terraform.git//aws/modules/apigatewayv2?ref=dev"

  providers = {
    aws = aws.default
  }

  name        = "test-api-gateway-staging-firehose"
  environment = "staging"

  // API gateway route
  enable_apigatewayv2_route      = true
  apigatewayv2_route_route_key   = "ANY /firehose"
  apigatewayv2_stage_auto_deploy = false
  apigatewayv2_route_api_id      = module.api_gateway_staging_firehose.apigatewayv2_api_id

  apigatewayv2_route_target = "integrations/${module.api_gateway_integration_staging_firehose.apigatewayv2_integration_id}"

  depends_on = [
    module.api_gateway_staging_firehose,
    module.api_gateway_integration_staging_firehose
  ]
}

module "api_gateway_domain_name_staging_firehose" {
  source = "git@github.com:sebastianua/terraform.git//aws/modules/apigatewayv2?ref=dev"

  providers = {
    aws = aws.default
  }

  name        = "test-api-gateway-staging-firehose"
  environment = "staging"

  // API gateway v2 api domain name
  enable_apigatewayv2_domain_name      = true
  apigatewayv2_domain_name_domain_name = "firehose.internal.test.io"
  apigatewayv2_domain_name_domain_name_configuration = {
    certificate_arn = "arn:aws:acm:us-east-1:${data.aws_caller_identity.default.account_id}:certificate/802132ce-c944-4e44-8365-8fd8d7616aab"
    endpoint_type   = "REGIONAL"
    security_policy = "TLS_1_2"
  }

  depends_on = []
}

module "api_gateway_integration_staging_firehose" {
  source = "git@github.com:sebastianua/terraform.git//aws/modules/apigatewayv2?ref=dev"

  providers = {
    aws = aws.default
  }

  name        = "test-api-gateway-staging-firehose"
  environment = "staging"

  // API gateway integration
  enable_apigatewayv2_integration           = true
  apigatewayv2_integration_integration_type = "AWS_PROXY" // "PROXY" // "AWS" // "HTTP_PROXY" // "AWS_PROXY"

  apigatewayv2_integration_connection_type    = "INTERNET"
  apigatewayv2_integration_description        = "Lambda firehose"
  apigatewayv2_integration_integration_method = "ANY" # "POST"
  apigatewayv2_integration_integration_uri    = data.terraform_remote_state.testio_lambda_staging_firehose.outputs.lambda_staging_firehose_lambda_function_arn
  apigatewayv2_integration_api_id             = module.api_gateway_staging_firehose.apigatewayv2_api_id

  depends_on = [
    module.api_gateway_staging_firehose
  ]
}

module "api_gateway_authorizer_staging_firehose" {
  source = "git@github.com:sebastianua/terraform.git//aws/modules/apigatewayv2?ref=dev"

  providers = {
    aws = aws.default
  }

  name        = "test-api-gateway-staging-firehose"
  environment = "staging"

  // API gateway authorizer
  enable_apigatewayv2_authorizer = true
  apigatewayv2_authorizer_name   = ""
  apigatewayv2_authorizer_api_id = module.api_gateway_staging_firehose.apigatewayv2_api_id

  apigatewayv2_authorizer_authorizer_type                   = "REQUEST"
  apigatewayv2_authorizer_authorizer_uri                    = data.terraform_remote_state.testio_lambda_staging_firehose.outputs.lambda_staging_firehose_lambda_invoke_arn
  apigatewayv2_authorizer_identity_sources                  = []
  apigatewayv2_authorizer_authorizer_result_ttl_in_seconds  = 0
  apigatewayv2_authorizer_authorizer_payload_format_version = "2.0"

  depends_on = [
    data.terraform_remote_state.testio_lambda_staging_firehose,
    module.api_gateway_staging_firehose
  ]
}

// not working fine for now
module "api_gateway_deployment_staging_firehose" {
  source = "git@github.com:sebastianua/terraform.git//aws/modules/apigatewayv2?ref=dev"

  providers = {
    aws = aws.default
  }

  name        = "test-api-gateway-staging-firehose"
  environment = "staging"

  // API gateway deployment
  enable_apigatewayv2_deployment      = true
  apigatewayv2_deployment_description = "Firehose deployment"
  apigatewayv2_deployment_triggers    = {}
  apigatewayv2_deployment_api_id      = module.api_gateway_staging_firehose.apigatewayv2_api_id

  depends_on = [
    module.api_gateway_staging_firehose
  ]
}

#---------------------------------------------------------------
# lambda trigger for Firehose
#---------------------------------------------------------------
module "lambda_staging_firehose_trigger" {
  source = "git@github.com:sebastianua/terraform.git//aws/modules/lambda?ref=dev"

  providers = {
    aws = aws.default
  }

  name        = "test-lambda-firehose"
  environment = "staging"

  enable_lambda_permission        = true
  lambda_permission_function_name = "test-lambda-staging-firehose"
  lambda_permission_source_arn    = "arn:aws:execute-api:${data.aws_region.default.name}:${data.aws_caller_identity.default.account_id}:${module.api_gateway_staging_firehose.apigatewayv2_api_id}/default/*"

  lambda_permission_action    = "lambda:InvokeFunction"
  lambda_permission_principal = "apigateway.amazonaws.com"

  tags = tomap({
    "Environment"   = "staging",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

  depends_on = [
    module.api_gateway_staging_firehose
  ]
}

#---------------------------------------------------------------
# Route53 for Firehose
#---------------------------------------------------------------
module "route53_lambda_staging_firehose" {
  source = "git@github.com:sebastianua/terraform.git//aws/modules/route53?ref=dev"

  # Route53 alias
  enable_route53_record         = true
  route53_record_parent_zone_id = "Z16BИТIERZ9NH6" # internal.test.io
  route53_record_type           = "A"
  route53_record_name           = module.api_gateway_domain_name_staging_firehose.apigatewayv2_domain_name_domain_name
  route53_record_records        = null
  route53_record_alias = [
    {
      name                   = module.api_gateway_domain_name_staging_firehose.apigatewayv2_domain_name_domain_name_configuration[0][0]["target_domain_name"]
      zone_id                = module.api_gateway_domain_name_staging_firehose.apigatewayv2_domain_name_domain_name_configuration[0][0]["hosted_zone_id"]
      evaluate_target_health = false
    }
  ]

  tags = tomap({
    "Environment"   = "staging",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

  depends_on = [
    module.api_gateway_domain_name_staging_firehose
  ]
}

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default = {}`)
- `enable_apigatewayv2_api_mapping` - Enable apigatewayv2 api mapping usage (`default = False`)
- `apigatewayv2_api_mapping_api_id` - The API identifier. (`default = ""`)
- `apigatewayv2_api_mapping_domain_name` - The domain name. Use the aws_apigatewayv2_domain_name resource to configure a domain name. (`default = ""`)
- `apigatewayv2_api_mapping_stage` - The API stage. Use the aws_apigatewayv2_stage resource to configure an API stage. (`default = ""`)
- `apigatewayv2_api_mapping_api_mapping_key` - (Optional) The API mapping key. (`default = null`)
- `enable_apigatewayv2_api` - Enable apigatewayv2 api usage (`default = False`)
- `apigatewayv2_api_name` - The name of the API. Must be less than or equal to 128 characters in length. (`default = ""`)
- `apigatewayv2_api_protocol_type` - (Required) The API protocol. Valid values: HTTP, WEBSOCKET. (`default = null`)
- `apigatewayv2_api_api_key_selection_expression` - (Optional) An API key selection expression. Valid values: $context.authorizer.usageIdentifierKey, $request.header.x-api-key. Defaults to $request.header.x-api-key. Applicable for WebSocket APIs. (`default = null`)
- `apigatewayv2_api_credentials_arn` - (Optional) Part of quick create. Specifies any credentials required for the integration. Applicable for HTTP APIs. (`default = null`)
- `apigatewayv2_api_description` - (Optional) The description of the API. Must be less than or equal to 1024 characters in length. (`default = null`)
- `apigatewayv2_api_disable_execute_api_endpoint` - (Optional) Whether clients can invoke the API by using the default execute-api endpoint. By default, clients can invoke the API with the default {api_id}.execute-api.{region}.amazonaws.com endpoint. To require that clients use a custom domain name to invoke the API, disable the default endpoint. (`default = null`)
- `apigatewayv2_api_route_key` - (Optional) Part of quick create. Specifies any route key. Applicable for HTTP APIs. (`default = null`)
- `apigatewayv2_api_route_selection_expression` - (Optional) The route selection expression for the API. Defaults to $request.method $request.path (`default = null`)
- `apigatewayv2_api_target` - (Optional) Part of quick create. Quick create produces an API with an integration, a default catch-all route, and a default stage which is configured to automatically deploy changes. For HTTP integrations, specify a fully qualified URL. For Lambda integrations, specify a function ARN. The type of the integration will be HTTP_PROXY or AWS_PROXY, respectively. Applicable for HTTP APIs. (`default = null`)
- `apigatewayv2_api_body` - (Optional) An OpenAPI specification that defines the set of routes and integrations to create as part of the HTTP APIs. Supported only for HTTP APIs. (`default = null`)
- `apigatewayv2_api_version` - (Optional) A version identifier for the API. Must be between 1 and 64 characters in length. (`default = null`)
- `apigatewayv2_api_fail_on_warnings` - (Optional) Whether warnings should return an error while API Gateway is creating or updating the resource using an OpenAPI specification. Defaults to false. Applicable for HTTP APIs. (`default = null`)
- `apigatewayv2_api_cors_configuration` - (Optional) The cross-origin resource sharing (CORS) configuration. Applicable for HTTP APIs. (`default = {}`)
- `enable_apigatewayv2_domain_name` - Enable apigatewayv2 domain name usage (`default = False`)
- `apigatewayv2_domain_name_domain_name` - (Required) Domain name. Must be between 1 and 512 characters in length. (`default = null`)
- `apigatewayv2_domain_name_domain_name_configuration` - (Required) Domain name configuration. (`default = {}`)
- `apigatewayv2_domain_name_mutual_tls_authentication` - (Optional) Mutual TLS authentication configuration for the domain name. (`default = {}`)
- `apigatewayv2_domain_name_timeouts` - Set timeouts for apigatewayv2 domain name (`default = {}`)
- `enable_apigatewayv2_stage` - Enable apigatewayv2 stage usage (`default = False`)
- `apigatewayv2_stage_name` - The name of the stage. Must be between 1 and 128 characters in length. (`default = ""`)
- `apigatewayv2_stage_api_id` - The API identifier. (`default = ""`)
- `apigatewayv2_stage_auto_deploy` - (Optional) Whether updates to an API automatically trigger a new deployment. Defaults to false. Applicable for HTTP APIs. (`default = null`)
- `apigatewayv2_stage_client_certificate_id` - (Optional) The identifier of a client certificate for the stage. Use the aws_api_gateway_client_certificate resource to configure a client certificate. Supported only for WebSocket APIs. (`default = null`)
- `apigatewayv2_stage_deployment_id` - (Optional) The deployment identifier of the stage. Use the aws_apigatewayv2_deployment resource to configure a deployment. (`default = null`)
- `apigatewayv2_stage_description` - (Optional) The description for the stage. Must be less than or equal to 1024 characters in length. (`default = null`)
- `apigatewayv2_stage_stage_variables` - (Optional) A map that defines the stage variables for the stage. (`default = null`)
- `apigatewayv2_stage_access_log_settings` - (Optional) Settings for logging access in this stage. Use the aws_api_gateway_account resource to configure permissions for CloudWatch Logging. (`default = {}`)
- `apigatewayv2_stage_default_route_settings` - (Optional) The default route settings for the stage. (`default = {}`)
- `apigatewayv2_stage_route_settings` - (Optional) Route settings for the stage. (`default = {}`)
- `enable_apigatewayv2_authorizer` - Enable apigatewayv2 authorizer usage (`default = False`)
- `apigatewayv2_authorizer_name` - The name of the authorizer. Must be between 1 and 128 characters in length. (`default = ""`)
- `apigatewayv2_authorizer_api_id` - The API identifier. (`default = ""`)
- `apigatewayv2_authorizer_authorizer_type` - (Required) The authorizer type. Valid values: JWT, REQUEST. Specify REQUEST for a Lambda function using incoming request parameters. For HTTP APIs, specify JWT to use JSON Web Tokens. (`default = null`)
- `apigatewayv2_authorizer_authorizer_credentials_arn` - (Optional) The required credentials as an IAM role for API Gateway to invoke the authorizer. Supported only for REQUEST authorizers. (`default = null`)
- `apigatewayv2_authorizer_authorizer_payload_format_version` - Optional) The format of the payload sent to an HTTP API Lambda authorizer. Required for HTTP API Lambda authorizers. Valid values: 1.0, 2.0. (`default = null`)
- `apigatewayv2_authorizer_authorizer_result_ttl_in_seconds` - (Optional) The time to live (TTL) for cached authorizer results, in seconds. If it equals 0, authorization caching is disabled. If it is greater than 0, API Gateway caches authorizer responses. The maximum value is 3600, or 1 hour. Defaults to 300. Supported only for HTTP API Lambda authorizers. (`default = null`)
- `apigatewayv2_authorizer_authorizer_uri` - (Optional) The authorizer's Uniform Resource Identifier (URI). For REQUEST authorizers this must be a well-formed Lambda function URI, such as the invoke_arn attribute of the aws_lambda_function resource. Supported only for REQUEST authorizers. Must be between 1 and 2048 characters in length. (`default = null`)
- `apigatewayv2_authorizer_enable_simple_responses` - (Optional) Whether a Lambda authorizer returns a response in a simple format. If enabled, the Lambda authorizer can return a boolean value instead of an IAM policy. Supported only for HTTP APIs. (`default = null`)
- `apigatewayv2_authorizer_identity_sources` - (Optional) The identity sources for which authorization is requested. For REQUEST authorizers the value is a list of one or more mapping expressions of the specified request parameters. For JWT authorizers the single entry specifies where to extract the JSON Web Token (JWT) from inbound requests. (`default = null`)
- `apigatewayv2_authorizer_jwt_configuration` - (Optional) The configuration of a JWT authorizer. Required for the JWT authorizer type. Supported only for HTTP APIs. (`default = {}`)
- `enable_apigatewayv2_deployment` - Enable apigatewayv2 deployment usage (`default = False`)
- `apigatewayv2_deployment_api_id` - The API identifier. (`default = ""`)
- `apigatewayv2_deployment_description` - (Optional) The description for the deployment resource. Must be less than or equal to 1024 characters in length. (`default = null`)
- `apigatewayv2_deployment_triggers` - (Optional) A map of arbitrary keys and values that, when changed, will trigger a redeployment. To force a redeployment without changing these keys/values, use the terraform taint command. (`default = null`)
- `enable_apigatewayv2_integration` - Enable apigatewayv2 integration usage (`default = False`)
- `apigatewayv2_integration_api_id` - The API identifier. (`default = ""`)
- `apigatewayv2_integration_integration_type` - (Required) The integration type of an integration. Valid values: AWS (supported only for WebSocket APIs), AWS_PROXY, HTTP (supported only for WebSocket APIs), HTTP_PROXY, MOCK (supported only for WebSocket APIs). For an HTTP API private integration, use HTTP_PROXY. (`default = null`)
- `apigatewayv2_integration_connection_id` - (Optional) The ID of the VPC link for a private integration. Supported only for HTTP APIs. Must be between 1 and 1024 characters in length. (`default = null`)
- `apigatewayv2_integration_connection_type` - (Optional) The type of the network connection to the integration endpoint. Valid values: INTERNET, VPC_LINK. Default is INTERNET. (`default = null`)
- `apigatewayv2_integration_content_handling_strategy` - Optional) How to handle response payload content type conversions. Valid values: CONVERT_TO_BINARY, CONVERT_TO_TEXT. Supported only for WebSocket APIs. (`default = null`)
- `apigatewayv2_integration_credentials_arn` - (Optional) The credentials required for the integration, if any. (`default = null`)
- `apigatewayv2_integration_description` - (Optional) The description of the integration. (`default = null`)
- `apigatewayv2_integration_integration_method` - (Optional) The integration's HTTP method. Must be specified if integration_type is not MOCK. (`default = null`)
- `apigatewayv2_integration_integration_subtype` - (Optional) Specifies the AWS service action to invoke. Supported only for HTTP APIs when integration_type is AWS_PROXY. See the AWS service integration reference documentation for supported values. Must be between 1 and 128 characters in length. (`default = null`)
- `apigatewayv2_integration_integration_uri` - (Optional) The URI of the Lambda function for a Lambda proxy integration, when integration_type is AWS_PROXY. For an HTTP integration, specify a fully-qualified URL. For an HTTP API private integration, specify the ARN of an Application Load Balancer listener, Network Load Balancer listener, or AWS Cloud Map service. (`default = null`)
- `apigatewayv2_integration_passthrough_behavior` - (Optional) The pass-through behavior for incoming requests based on the Content-Type header in the request, and the available mapping templates specified as the request_templates attribute. Valid values: WHEN_NO_MATCH, WHEN_NO_TEMPLATES, NEVER. Default is WHEN_NO_MATCH. Supported only for WebSocket APIs. (`default = null`)
- `apigatewayv2_integration_payload_format_version` - (Optional) The format of the payload sent to an integration. Valid values: 1.0, 2.0. Default is 1.0. (`default = null`)
- `apigatewayv2_integration_request_parameters` - (Optional) For WebSocket APIs, a key-value map specifying request parameters that are passed from the method request to the backend. For HTTP APIs with a specified integration_subtype, a key-value map specifying parameters that are passed to AWS_PROXY integrations. For HTTP APIs without a specified integration_subtype, a key-value map specifying how to transform HTTP requests before sending them to the backend. See the Amazon API Gateway Developer Guide for details. (`default = null`)
- `apigatewayv2_integration_request_templates` - (Optional) A map of Velocity templates that are applied on the request payload based on the value of the Content-Type header sent by the client. Supported only for WebSocket APIs. (`default = null`)
- `apigatewayv2_integration_template_selection_expression` - (Optional) Mappings to transform the HTTP response from a backend integration before returning the response to clients. Supported only for HTTP APIs. (`default = null`)
- `apigatewayv2_integration_timeout_milliseconds` - (Optional) Custom timeout between 50 and 29,000 milliseconds for WebSocket APIs and between 50 and 30,000 milliseconds for HTTP APIs. The default timeout is 29 seconds for WebSocket APIs and 30 seconds for HTTP APIs. Terraform will only perform drift detection of its value when present in a configuration. (`default = null`)
- `apigatewayv2_integration_response_parameters` - (Optional) Mappings to transform the HTTP response from a backend integration before returning the response to clients. Supported only for HTTP APIs. (`default = {}`)
- `apigatewayv2_integration_tls_config` - (Optional) The TLS configuration for a private integration. Supported only for HTTP APIs. (`default = {}`)
- `enable_apigatewayv2_integration_response` - Enable apigatewayv2 integration response usage (`default = False`)
- `apigatewayv2_integration_response_api_id` - The API identifier. (`default = ""`)
- `apigatewayv2_integration_response_integration_id` - The identifier of the aws_apigatewayv2_integration. (`default = ""`)
- `apigatewayv2_integration_response_integration_response_key` - (Required) The integration response key. (`default = null`)
- `apigatewayv2_integration_response_content_handling_strategy` - (Optional) How to handle response payload content type conversions. Valid values: CONVERT_TO_BINARY, CONVERT_TO_TEXT (`default = null`)
- `apigatewayv2_integration_response_response_templates` - (Optional) A map of Velocity templates that are applied on the request payload based on the value of the Content-Type header sent by the client. (`default = null`)
- `apigatewayv2_integration_response_template_selection_expression` - (Optional) The template selection expression for the integration response. (`default = null`)
- `enable_apigatewayv2_vpc_link` - Enable apigatewayv2 vpc link usage (`default = False`)
- `apigatewayv2_vpc_link_name` - The name of the VPC Link. Must be between 1 and 128 characters in length. (`default = ""`)
- `apigatewayv2_vpc_link_security_group_ids` - (Required) Security group IDs for the VPC Link. (`default = null`)
- `apigatewayv2_vpc_link_subnet_ids` - (Required) Subnet IDs for the VPC Link. (`default = null`)
- `enable_apigatewayv2_model` - Enable apigatewayv2 model usage (`default = False`)
- `apigatewayv2_model_name` - The name of the model. Must be alphanumeric. Must be between 1 and 128 characters in length. (`default = ""`)
- `apigatewayv2_model_api_id` - The API identifier. (`default = ""`)
- `apigatewayv2_model_content_type` - (Required) The content-type for the model, for example, application/json. Must be between 1 and 256 characters in length. (`default = null`)
- `apigatewayv2_model_schema` - (Required) The schema for the model. This should be a JSON schema draft 4 model. Must be less than or equal to 32768 characters in length. (`default = null`)
- `apigatewayv2_model_description` - (Optional) The description of the model. Must be between 1 and 128 characters in length. (`default = null`)
- `enable_apigatewayv2_route` - Enable apigatewayv2 route usage (`default = False`)
- `apigatewayv2_route_api_id` - The API identifier. (`default = ""`)
- `apigatewayv2_route_route_key` - (Required) The route key for the route. For HTTP APIs, the route key can be either $default, or a combination of an HTTP method and resource path, for example, GET /pets. (`default = null`)
- `apigatewayv2_route_api_key_required` - (Optional) Boolean whether an API key is required for the route. Defaults to false. Supported only for WebSocket APIs. (`default = null`)
- `apigatewayv2_route_authorization_scopes` - (Optional) The authorization scopes supported by this route. The scopes are used with a JWT authorizer to authorize the method invocation. (`default = null`)
- `apigatewayv2_route_authorization_type` - (Optional) The authorization type for the route. For WebSocket APIs, valid values are NONE for open access, AWS_IAM for using AWS IAM permissions, and CUSTOM for using a Lambda authorizer. For HTTP APIs, valid values are NONE for open access, JWT for using JSON Web Tokens, AWS_IAM for using AWS IAM permissions, and CUSTOM for using a Lambda authorizer. Defaults to NONE (`default = null`)
- `apigatewayv2_route_authorizer_id` - (Optional) The identifier of the aws_apigatewayv2_authorizer resource to be associated with this route. (`default = null`)
- `apigatewayv2_route_model_selection_expression` - (Optional) The model selection expression for the route. Supported only for WebSocket APIs. (`default = null`)
- `apigatewayv2_route_operation_name` - (Optional) The operation name for the route. Must be between 1 and 64 characters in length. (`default = null`)
- `apigatewayv2_route_request_models` - (Optional) The request models for the route. Supported only for WebSocket APIs. (`default = null`)
- `apigatewayv2_route_route_response_selection_expression` - (Optional) The route response selection expression for the route. Supported only for WebSocket APIs. (`default = null`)
- `apigatewayv2_route_target` - (Optional) The target for the route, of the form integrations/IntegrationID, where IntegrationID is the identifier of an aws_apigatewayv2_integration resource. (`default = null`)
- `apigatewayv2_route_request_parameter` - Optional) The request parameters for the route. Supported only for WebSocket APIs. (`default = {}`)
- `enable_apigatewayv2_route_response` - Enable apigatewayv2 route response usage (`default = False`)
- `apigatewayv2_route_response_api_id` - The API identifier. (`default = ""`)
- `apigatewayv2_route_response_route_id` - The identifier of the aws_apigatewayv2_route. (`default = ""`)
- `apigatewayv2_route_response_route_response_key` - (Required) The route response key. (`default = null`)
- `apigatewayv2_route_response_model_selection_expression` - (Optional) The model selection expression for the route response. (`default = null`)
- `apigatewayv2_route_response_response_models` - (Optional) The response models for the route response. (`default = null`)

## Module Output Variables
----------------------
- `apigatewayv2_api_mapping_id` - The API mapping identifier.
- `apigatewayv2_api_id` - The API identifier.
- `apigatewayv2_api_api_endpoint` - The URI of the API, of the form https://{api-id}.execute-api.{region}.amazonaws.com for HTTP APIs and wss://{api-id}.execute-api.{region}.amazonaws.com for WebSocket APIs.
- `apigatewayv2_api_arn` - The ARN of the API.
- `apigatewayv2_api_execution_arn` - The ARN prefix to be used in an aws_lambda_permission's source_arn attribute or in an aws_iam_policy to authorize access to the @connections API. See the Amazon API Gateway Developer Guide for details.
- `apigatewayv2_api_tags_all` - A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
- `apigatewayv2_domain_name_id` - Domain name identifier.
- `apigatewayv2_domain_name_api_mapping_selection_expression` - API mapping selection expression for the domain name.
- `apigatewayv2_domain_name_arn` - ARN of the domain name.
- `apigatewayv2_domain_name_tags_all` - Map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
- `apigatewayv2_domain_name_domain_name_configuration` - Map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
- `apigatewayv2_domain_name_domain_name` - The domain name
- `apigatewayv2_stage_id` - The stage identifier.
- `apigatewayv2_stage_arn` - The ARN of the stage.
- `apigatewayv2_stage_execution_arn` - The ARN prefix to be used in an aws_lambda_permission's source_arn attribute. For WebSocket APIs this attribute can additionally be used in an aws_iam_policy to authorize access to the @connections API. See the Amazon API Gateway Developer Guide for details.
- `apigatewayv2_stage_invoke_url` - The URL to invoke the API pointing to the stage, e.g., wss://z4675bid1j.execute-api.eu-west-2.amazonaws.com/example-stage, or https://z4675bid1j.execute-api.eu-west-2.amazonaws.com/
- `apigatewayv2_stage_tags_all` - A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
- `apigatewayv2_authorizer_id` - The authorizer identifier.
- `apigatewayv2_deployment_id` - The deployment identifier.
- `apigatewayv2_integration_response_id` - The integration response identifier.
- `apigatewayv2_integration_id` - The integration identifier.
- `apigatewayv2_integration_integration_response_selection_expression` - The integration response selection expression for the integration..
- `apigatewayv2_vpc_link_id` - The VPC Link identifier.
- `apigatewayv2_vpc_link_arn` - The VPC Link ARN.
- `apigatewayv2_vpc_link_tags_all` - A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
- `apigatewayv2_model_id` - The model identifier.
- `apigatewayv2_route_id` - The route identifier.
- `apigatewayv2_route_api_id` - The route API ID.
- `apigatewayv2_route_response_id` - The route response identifier.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
