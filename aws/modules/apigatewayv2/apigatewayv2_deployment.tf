#---------------------------------------------------
# AWS API Gateway v2 deployment
#---------------------------------------------------
resource "aws_apigatewayv2_deployment" "apigatewayv2_deployment" {
  count = var.enable_apigatewayv2_deployment ? 1 : 0

  api_id = var.apigatewayv2_deployment_api_id != "" ? var.apigatewayv2_deployment_api_id : (var.enable_apigatewayv2_api ? aws_apigatewayv2_api.apigatewayv2_api[count.index].id : null)

  description = var.apigatewayv2_deployment_description
  triggers    = var.apigatewayv2_deployment_triggers

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_apigatewayv2_api.apigatewayv2_api
  ]
}