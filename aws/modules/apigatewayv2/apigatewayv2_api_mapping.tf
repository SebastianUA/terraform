#---------------------------------------------------
# AWS API Gateway v2 api mapping
#---------------------------------------------------
resource "aws_apigatewayv2_api_mapping" "apigatewayv2_api_mapping" {
  count = var.enable_apigatewayv2_api_mapping ? 1 : 0

  api_id      = var.apigatewayv2_api_mapping_api_id != "" ? var.apigatewayv2_api_mapping_api_id : (var.enable_apigatewayv2_api ? aws_apigatewayv2_api.apigatewayv2_api[count.index].id : null)
  domain_name = var.apigatewayv2_api_mapping_domain_name != "" ? var.apigatewayv2_api_mapping_domain_name : (var.enable_apigatewayv2_domain_name ? aws_apigatewayv2_domain_name.apigatewayv2_domain_name[count.index].id : null)
  stage       = var.apigatewayv2_api_mapping_stage != "" ? var.apigatewayv2_api_mapping_stage : (var.enable_apigatewayv2_stage ? aws_apigatewayv2_stage.apigatewayv2_stage[count.index].id : null)

  api_mapping_key = var.apigatewayv2_api_mapping_api_mapping_key

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_apigatewayv2_api.apigatewayv2_api,
    aws_apigatewayv2_domain_name.apigatewayv2_domain_name,
    aws_apigatewayv2_stage.apigatewayv2_stage
  ]
}