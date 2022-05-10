#---------------------------------------------------
# AWS API Gateway v2 integration response
#---------------------------------------------------
resource "aws_apigatewayv2_integration_response" "apigatewayv2_integration_response" {
  count = var.enable_apigatewayv2_integration_response ? 1 : 0

  api_id                   = var.apigatewayv2_integration_response_api_id != "" ? var.apigatewayv2_integration_response_api_id : (var.enable_apigatewayv2_api ? aws_apigatewayv2_api.apigatewayv2_api[count.index].id : null)
  integration_id           = var.apigatewayv2_integration_response_integration_id != "" ? var.apigatewayv2_integration_response_integration_id : (var.enable_apigatewayv2_integration ? aws_apigatewayv2_integration.apigatewayv2_integration[count.index].id : null)
  integration_response_key = var.apigatewayv2_integration_response_integration_response_key

  content_handling_strategy     = var.apigatewayv2_integration_response_content_handling_strategy
  response_templates            = var.apigatewayv2_integration_response_response_templates
  template_selection_expression = var.apigatewayv2_integration_response_template_selection_expression

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_apigatewayv2_api.apigatewayv2_api,
    aws_apigatewayv2_integration.apigatewayv2_integration
  ]
}