#---------------------------------------------------
# AWS API Gateway v2 api
#---------------------------------------------------
resource "aws_apigatewayv2_api" "apigatewayv2_api" {
  count = var.enable_apigatewayv2_api ? 1 : 0

  name          = var.apigatewayv2_api_name != "" ? var.apigatewayv2_api_name : "${lower(var.name)}-apigatewayv2-api-${lower(var.environment)}"
  protocol_type = var.apigatewayv2_api_protocol_type != null ? upper(var.apigatewayv2_api_protocol_type) : var.apigatewayv2_api_protocol_type

  api_key_selection_expression = var.apigatewayv2_api_api_key_selection_expression
  credentials_arn              = var.apigatewayv2_api_credentials_arn
  description                  = var.apigatewayv2_api_description
  disable_execute_api_endpoint = var.apigatewayv2_api_disable_execute_api_endpoint
  route_key                    = var.apigatewayv2_api_route_key
  route_selection_expression   = var.apigatewayv2_api_route_selection_expression
  target                       = var.apigatewayv2_api_target
  body                         = var.apigatewayv2_api_body
  version                      = var.apigatewayv2_api_version
  fail_on_warnings             = var.apigatewayv2_api_fail_on_warnings

  dynamic "cors_configuration" {
    iterator = cors_configuration
    for_each = [var.apigatewayv2_api_cors_configuration]

    content {
      allow_credentials = lookup(cors_configuration.value, "allow_credentials", null)
      allow_headers     = lookup(cors_configuration.value, "allow_headers", null)
      allow_methods     = lookup(cors_configuration.value, "allow_methods", null)
      allow_origins     = lookup(cors_configuration.value, "allow_origins", null)
      expose_headers    = lookup(cors_configuration.value, "expose_headers", null)
      max_age           = lookup(cors_configuration.value, "max_age", null)
    }
  }

  tags = merge(
    {
      Name = var.apigatewayv2_api_name != "" ? var.apigatewayv2_api_name : "${lower(var.name)}-apigatewayv2-api-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}

