#---------------------------------------------------
# AWS API Gateway v2 model
#---------------------------------------------------
resource "aws_apigatewayv2_model" "apigatewayv2_model" {
  count = var.enable_apigatewayv2_model ? 1 : 0

  name         = var.apigatewayv2_model_name != "" ? var.apigatewayv2_model_name : "${lower(var.name)}-apiwg2-model-${lower(var.environment)}"
  api_id       = var.apigatewayv2_model_api_id != "" ? var.apigatewayv2_model_api_id : (var.enable_apigatewayv2_api ? aws_apigatewayv2_api.apigatewayv2_api[count.index].id : null)
  content_type = var.apigatewayv2_model_content_type
  schema       = var.apigatewayv2_model_schema

  description = var.apigatewayv2_model_description

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_apigatewayv2_api.apigatewayv2_api
  ]
}