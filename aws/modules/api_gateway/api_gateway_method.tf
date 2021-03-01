#---------------------------------------------------
# AWS API Gateway method
#---------------------------------------------------
resource "aws_api_gateway_method" "api_gateway_method" {
  count = var.enable_api_gateway_method ? 1 : 0

  rest_api_id   = var.api_gateway_method_rest_api_id != "" && !var.enable_api_gateway_rest_api ? var.api_gateway_method_rest_api_id : element(concat(aws_api_gateway_rest_api.api_gateway_rest_api.*.id, [""]), 0)
  resource_id   = var.api_gateway_method_resource_id != "" && !var.enable_api_gateway_resource ? var.api_gateway_method_resource_id : element(concat(aws_api_gateway_resource.api_gateway_resource.*.id, [""]), 0)
  http_method   = upper(var.api_gateway_method_http_method)
  authorization = upper(var.api_gateway_method_authorization)

  authorizer_id        = var.api_gateway_method_authorizer_id != "" && !var.enable_api_gateway_authorizer ? var.api_gateway_method_authorizer_id : element(concat(aws_api_gateway_authorizer.api_gateway_authorizer.*.id, [""]), 0)
  authorization_scopes = var.api_gateway_method_authorization_scopes
  api_key_required     = var.api_gateway_method_api_key_required
  request_models       = var.api_gateway_method_request_models
  request_validator_id = var.api_gateway_method_request_validator_id != "" && !var.enable_api_gateway_request_validator ? var.api_gateway_method_request_validator_id : element(concat(aws_api_gateway_request_validator.api_gateway_request_validator.*.id, [""]), 0)
  request_parameters   = var.api_gateway_method_request_parameters

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_api_gateway_rest_api.api_gateway_rest_api,
    aws_api_gateway_resource.api_gateway_resource,
    aws_api_gateway_authorizer.api_gateway_authorizer,
    aws_api_gateway_request_validator.api_gateway_request_validator
  ]
}
