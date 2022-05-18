#---------------------------------------------------
# AWS API Gateway v2 route response
#---------------------------------------------------
resource "aws_apigatewayv2_route_response" "apigatewayv2_route_response" {
  count = var.enable_apigatewayv2_route_response ? 1 : 0

  api_id             = var.apigatewayv2_route_response_api_id != "" ? var.apigatewayv2_route_response_api_id : (var.enable_apigatewayv2_api ? aws_apigatewayv2_api.apigatewayv2_api[count.index].id : null)
  route_id           = var.apigatewayv2_route_response_route_id != "" ? var.apigatewayv2_route_response_route_id : (var.enable_apigatewayv2_route ? aws_apigatewayv2_route.apigatewayv2_route[count.index].id : null)
  route_response_key = var.apigatewayv2_route_response_route_response_key

  model_selection_expression = var.apigatewayv2_route_response_model_selection_expression
  response_models            = var.apigatewayv2_route_response_response_models

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_apigatewayv2_api.apigatewayv2_api,
    aws_apigatewayv2_route.apigatewayv2_route
  ]
}