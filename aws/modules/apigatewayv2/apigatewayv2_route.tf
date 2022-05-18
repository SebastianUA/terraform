#---------------------------------------------------
# AWS API Gateway v2 route
#---------------------------------------------------
resource "aws_apigatewayv2_route" "apigatewayv2_route" {
  count = var.enable_apigatewayv2_route ? 1 : 0

  api_id    = var.apigatewayv2_route_api_id != "" ? var.apigatewayv2_route_api_id : (var.enable_apigatewayv2_api ? aws_apigatewayv2_api.apigatewayv2_api[count.index].id : null)
  route_key = var.apigatewayv2_route_route_key

  api_key_required                    = var.apigatewayv2_route_api_key_required
  authorization_scopes                = var.apigatewayv2_route_authorization_scopes
  authorization_type                  = var.apigatewayv2_route_authorization_type
  authorizer_id                       = var.apigatewayv2_route_authorizer_id
  model_selection_expression          = var.apigatewayv2_route_model_selection_expression
  operation_name                      = var.apigatewayv2_route_operation_name
  request_models                      = var.apigatewayv2_route_request_models
  route_response_selection_expression = var.apigatewayv2_route_route_response_selection_expression
  target                              = var.apigatewayv2_route_target

  dynamic "request_parameter" {
    iterator = request_parameter
    for_each = length(keys(lookup(var.apigatewayv2_route_request_parameter, "request_parameter", {}))) > 0 ? [lookup(var.apigatewayv2_route_request_parameter, "request_parameter", {})] : []

    content {
      request_parameter_key = lookup(request_parameter.value, "request_parameter_key", null)
      required              = lookup(request_parameter.value, "required", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_apigatewayv2_api.apigatewayv2_api
  ]
}