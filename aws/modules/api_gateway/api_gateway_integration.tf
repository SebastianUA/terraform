#---------------------------------------------------
# AWS API Gateway integration
#---------------------------------------------------
resource "aws_api_gateway_integration" "api_gateway_integration" {
  count = var.enable_api_gateway_integration ? 1 : 0

  rest_api_id = var.api_gateway_integration_rest_api_id != "" && !var.enable_api_gateway_rest_api ? var.api_gateway_integration_rest_api_id : element(concat(aws_api_gateway_rest_api.api_gateway_rest_api.*.id, [""]), 0)
  resource_id = var.api_gateway_integration_resource_id != "" && !var.enable_api_gateway_resource ? var.api_gateway_integration_resource_id : element(concat(aws_api_gateway_resource.api_gateway_resource.*.id, [""]), 0)
  http_method = var.api_gateway_integration_http_method != "" && !var.enable_api_gateway_method ? var.api_gateway_integration_http_method : element(concat(aws_api_gateway_method.api_gateway_method.*.http_method, [""]), 0)
  type        = upper(var.api_gateway_integration_type)

  integration_http_method = var.api_gateway_integration_integration_http_method
  connection_type         = var.api_gateway_integration_connection_type
  connection_id           = var.api_gateway_integration_connection_id
  uri                     = var.api_gateway_integration_uri
  credentials             = var.api_gateway_integration_credentials
  request_templates       = var.api_gateway_integration_request_templates
  request_parameters      = var.api_gateway_integration_request_parameters
  passthrough_behavior    = var.api_gateway_integration_passthrough_behavior
  cache_key_parameters    = var.api_gateway_integration_cache_key_parameters
  cache_namespace         = var.api_gateway_integration_cache_namespace
  content_handling        = var.api_gateway_integration_content_handling
  timeout_milliseconds    = var.api_gateway_integration_timeout_milliseconds

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_api_gateway_rest_api.api_gateway_rest_api,
    aws_api_gateway_resource.api_gateway_resource,
    aws_api_gateway_method.api_gateway_method
  ]
}
