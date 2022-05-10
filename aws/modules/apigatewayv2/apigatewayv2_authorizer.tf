#---------------------------------------------------
# AWS API Gateway v2 authorizer
#---------------------------------------------------
resource "aws_apigatewayv2_authorizer" "apigatewayv2_authorizer" {
  count = var.enable_apigatewayv2_authorizer ? 1 : 0

  name            = var.apigatewayv2_authorizer_name != "" ? var.apigatewayv2_authorizer_name : "${lower(var.name)}-apigatewayv2-authorizer-${lower(var.environment)}"
  api_id          = var.apigatewayv2_authorizer_api_id != "" ? var.apigatewayv2_authorizer_api_id : (var.enable_apigatewayv2_api ? aws_apigatewayv2_api.apigatewayv2_api[count.index].id : null)
  authorizer_type = var.apigatewayv2_authorizer_authorizer_type

  authorizer_credentials_arn        = var.apigatewayv2_authorizer_authorizer_credentials_arn
  authorizer_payload_format_version = var.apigatewayv2_authorizer_authorizer_payload_format_version
  authorizer_result_ttl_in_seconds  = var.apigatewayv2_authorizer_authorizer_result_ttl_in_seconds
  authorizer_uri                    = var.apigatewayv2_authorizer_authorizer_uri
  enable_simple_responses           = var.apigatewayv2_authorizer_enable_simple_responses
  identity_sources                  = var.apigatewayv2_authorizer_identity_sources

  dynamic "jwt_configuration" {
    iterator = jwt_configuration
    for_each = length(keys(lookup(var.apigatewayv2_authorizer_jwt_configuration, "jwt_configuration", {}))) > 0 ? [lookup(var.apigatewayv2_authorizer_jwt_configuration, "jwt_configuration", {})] : []

    content {
      audience = lookup(jwt_configuration.value, "audience", null)
      issuer   = lookup(jwt_configuration.value, "issuer", null)
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