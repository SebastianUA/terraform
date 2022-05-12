#---------------------------------------------------
# AWS API Gateway v2 api mapping
#---------------------------------------------------
output "apigatewayv2_api_mapping_id" {
  description = "The API mapping identifier."
  value       = element(concat(aws_apigatewayv2_api_mapping.apigatewayv2_api_mapping.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS API Gateway v2 api
#---------------------------------------------------
output "apigatewayv2_api_id" {
  description = "The API identifier."
  value       = element(concat(aws_apigatewayv2_api.apigatewayv2_api.*.id, [""]), 0)
}

output "apigatewayv2_api_api_endpoint" {
  description = "The URI of the API, of the form https://{api-id}.execute-api.{region}.amazonaws.com for HTTP APIs and wss://{api-id}.execute-api.{region}.amazonaws.com for WebSocket APIs."
  value       = element(concat(aws_apigatewayv2_api.apigatewayv2_api.*.api_endpoint, [""]), 0)
}

output "apigatewayv2_api_arn" {
  description = "The ARN of the API."
  value       = element(concat(aws_apigatewayv2_api.apigatewayv2_api.*.arn, [""]), 0)
}

output "apigatewayv2_api_execution_arn" {
  description = "The ARN prefix to be used in an aws_lambda_permission's source_arn attribute or in an aws_iam_policy to authorize access to the @connections API. See the Amazon API Gateway Developer Guide for details."
  value       = element(concat(aws_apigatewayv2_api.apigatewayv2_api.*.execution_arn, [""]), 0)
}

output "apigatewayv2_api_tags_all" {
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
  value       = concat(aws_apigatewayv2_api.apigatewayv2_api.*.tags_all, [""])
}

#---------------------------------------------------
# AWS API Gateway v2 domain name
#---------------------------------------------------
output "apigatewayv2_domain_name_id" {
  description = "Domain name identifier."
  value       = element(concat(aws_apigatewayv2_domain_name.apigatewayv2_domain_name.*.id, [""]), 0)
}

output "apigatewayv2_domain_name_api_mapping_selection_expression" {
  description = "API mapping selection expression for the domain name."
  value       = element(concat(aws_apigatewayv2_domain_name.apigatewayv2_domain_name.*.api_mapping_selection_expression, [""]), 0)
}

output "apigatewayv2_domain_name_arn" {
  description = "ARN of the domain name."
  value       = element(concat(aws_apigatewayv2_domain_name.apigatewayv2_domain_name.*.arn, [""]), 0)
}

output "apigatewayv2_domain_name_tags_all" {
  description = "Map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
  value       = concat(aws_apigatewayv2_domain_name.apigatewayv2_domain_name.*.tags_all, [""])
}

output "apigatewayv2_domain_name_domain_name_configuration" {
  description = "Map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
  value       = aws_apigatewayv2_domain_name.apigatewayv2_domain_name.*.domain_name_configuration
}

output "apigatewayv2_domain_name_domain_name" {
  description = "The domain name"
  value       = element(concat(aws_apigatewayv2_domain_name.apigatewayv2_domain_name.*.domain_name, [""]), 0)
}

#---------------------------------------------------
# AWS API Gateway v2 stage
#---------------------------------------------------
output "apigatewayv2_stage_id" {
  description = "The stage identifier."
  value       = element(concat(aws_apigatewayv2_stage.apigatewayv2_stage.*.id, [""]), 0)
}

output "apigatewayv2_stage_arn" {
  description = "The ARN of the stage."
  value       = element(concat(aws_apigatewayv2_stage.apigatewayv2_stage.*.arn, [""]), 0)
}

output "apigatewayv2_stage_execution_arn" {
  description = "The ARN prefix to be used in an aws_lambda_permission's source_arn attribute. For WebSocket APIs this attribute can additionally be used in an aws_iam_policy to authorize access to the @connections API. See the Amazon API Gateway Developer Guide for details."
  value       = element(concat(aws_apigatewayv2_stage.apigatewayv2_stage.*.execution_arn, [""]), 0)
}

output "apigatewayv2_stage_invoke_url" {
  description = "The URL to invoke the API pointing to the stage, e.g., wss://z4675bid1j.execute-api.eu-west-2.amazonaws.com/example-stage, or https://z4675bid1j.execute-api.eu-west-2.amazonaws.com/"
  value       = element(concat(aws_apigatewayv2_stage.apigatewayv2_stage.*.invoke_url, [""]), 0)
}

output "apigatewayv2_stage_tags_all" {
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
  value       = concat(aws_apigatewayv2_stage.apigatewayv2_stage.*.tags_all, [""])
}

#---------------------------------------------------
# AWS API Gateway v2 authorizer
#---------------------------------------------------
output "apigatewayv2_authorizer_id" {
  description = "The authorizer identifier."
  value       = element(concat(aws_apigatewayv2_authorizer.apigatewayv2_authorizer.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS API Gateway v2 deployment
#---------------------------------------------------
output "apigatewayv2_deployment_id" {
  description = "The deployment identifier."
  value       = element(concat(aws_apigatewayv2_authorizer.apigatewayv2_authorizer.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS API Gateway v2 integration response
#---------------------------------------------------
output "apigatewayv2_integration_response_id" {
  description = "The integration response identifier."
  value       = element(concat(aws_apigatewayv2_integration_response.apigatewayv2_integration_response.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS API Gateway v2 integration
#---------------------------------------------------
output "apigatewayv2_integration_id" {
  description = "The integration identifier."
  value       = element(concat(aws_apigatewayv2_integration.apigatewayv2_integration.*.id, [""]), 0)
}

output "apigatewayv2_integration_integration_response_selection_expression" {
  description = "The integration response selection expression for the integration.."
  value       = element(concat(aws_apigatewayv2_integration.apigatewayv2_integration.*.integration_response_selection_expression, [""]), 0)
}

#---------------------------------------------------
# AWS API Gateway vpc link
#---------------------------------------------------
output "apigatewayv2_vpc_link_id" {
  description = "The VPC Link identifier."
  value       = element(concat(aws_apigatewayv2_vpc_link.apigatewayv2_vpc_link.*.id, [""]), 0)
}

output "apigatewayv2_vpc_link_arn" {
  description = "The VPC Link ARN."
  value       = element(concat(aws_apigatewayv2_vpc_link.apigatewayv2_vpc_link.*.arn, [""]), 0)
}

output "apigatewayv2_vpc_link_tags_all" {
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
  value       = concat(aws_apigatewayv2_vpc_link.apigatewayv2_vpc_link.*.tags_all, [""])
}

#---------------------------------------------------
# AWS API Gateway v2 model
#---------------------------------------------------
output "apigatewayv2_model_id" {
  description = "The model identifier."
  value       = element(concat(aws_apigatewayv2_model.apigatewayv2_model.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS API Gateway v2 route
#---------------------------------------------------
output "apigatewayv2_route_id" {
  description = "The route identifier."
  value       = element(concat(aws_apigatewayv2_route.apigatewayv2_route.*.id, [""]), 0)
}

output "apigatewayv2_route_api_id" {
  description = "The route API ID."
  value       = element(concat(aws_apigatewayv2_route.apigatewayv2_route.*.api_id, [""]), 0)
}

#---------------------------------------------------
# AWS API Gateway v2 route response
#---------------------------------------------------
output "apigatewayv2_route_response_id" {
  description = "The route response identifier."
  value       = element(concat(aws_apigatewayv2_route_response.apigatewayv2_route_response.*.id, [""]), 0)
}