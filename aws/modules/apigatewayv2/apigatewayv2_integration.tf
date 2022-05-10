#---------------------------------------------------
# AWS API Gateway v2 integration
#---------------------------------------------------
resource "aws_apigatewayv2_integration" "apigatewayv2_integration" {
  count = var.enable_apigatewayv2_integration ? 1 : 0

  api_id           = var.apigatewayv2_integration_api_id != "" ? var.apigatewayv2_integration_api_id : (var.enable_apigatewayv2_api ? aws_apigatewayv2_api.apigatewayv2_api[count.index].id : null)
  integration_type = var.apigatewayv2_integration_integration_type

  connection_id                 = var.apigatewayv2_integration_connection_id
  connection_type               = var.apigatewayv2_integration_connection_type
  content_handling_strategy     = var.apigatewayv2_integration_content_handling_strategy
  credentials_arn               = var.apigatewayv2_integration_credentials_arn
  description                   = var.apigatewayv2_integration_description
  integration_method            = var.apigatewayv2_integration_integration_method
  integration_subtype           = var.apigatewayv2_integration_integration_subtype
  integration_uri               = var.apigatewayv2_integration_integration_uri
  passthrough_behavior          = var.apigatewayv2_integration_passthrough_behavior
  payload_format_version        = var.apigatewayv2_integration_payload_format_version
  request_parameters            = var.apigatewayv2_integration_request_parameters
  request_templates             = var.apigatewayv2_integration_request_templates
  template_selection_expression = var.apigatewayv2_integration_template_selection_expression
  timeout_milliseconds          = var.apigatewayv2_integration_timeout_milliseconds

  dynamic "response_parameters" {
    iterator = response_parameters
    for_each = length(keys(var.apigatewayv2_integration_response_parameters)) > 0 ? [var.apigatewayv2_integration_response_parameters] : []

    content {
      status_code = lookup(response_parameters.value, "status_code", null)
      mappings    = lookup(response_parameters.value, "mappings", null)
    }
  }

  dynamic "tls_config" {
    iterator = tls_config
    for_each = length(keys(var.apigatewayv2_integration_tls_config)) > 0 ? [var.apigatewayv2_integration_tls_config] : []

    content {
      server_name_to_verify = lookup(tls_config.value, "server_name_to_verify", null)
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