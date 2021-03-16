#---------------------------------------------------
# AWS API Gateway model
#---------------------------------------------------
resource "aws_api_gateway_model" "api_gateway_model" {
  count = var.enable_api_gateway_model ? 1 : 0

  name         = var.api_gateway_model_name != "" ? var.api_gateway_model_name : "${lower(var.name)}-api-gw-request-validator-${lower(var.environment)}"
  rest_api_id  = var.api_gateway_model_rest_api_id != "" && !var.enable_api_gateway_rest_api ? var.api_gateway_model_rest_api_id : element(concat(aws_api_gateway_rest_api.api_gateway_rest_api.*.id, [""]), 0)
  content_type = var.api_gateway_model_content_type
  schema       = var.api_gateway_model_schema

  description = var.api_gateway_model_description

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_api_gateway_rest_api.api_gateway_rest_api
  ]
}
