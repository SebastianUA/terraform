#---------------------------------------------------
# AWS API Gateway v2 stage
#---------------------------------------------------
resource "aws_apigatewayv2_stage" "apigatewayv2_stage" {
  count = var.enable_apigatewayv2_stage ? 1 : 0

  name   = var.apigatewayv2_stage_name != "" ? var.apigatewayv2_stage_name : "${lower(var.name)}-apigatewayv2-stage-${lower(var.environment)}"
  api_id = var.apigatewayv2_stage_api_id != "" ? var.apigatewayv2_stage_api_id : (var.enable_apigatewayv2_api ? aws_apigatewayv2_api.apigatewayv2_api[count.index].id : null)

  auto_deploy           = var.apigatewayv2_stage_auto_deploy
  client_certificate_id = var.apigatewayv2_stage_client_certificate_id
  deployment_id         = var.apigatewayv2_stage_deployment_id
  description           = var.apigatewayv2_stage_description
  stage_variables       = var.apigatewayv2_stage_stage_variables

  dynamic "access_log_settings" {
    iterator = access_log_settings
    for_each = length(keys(lookup(var.apigatewayv2_stage_access_log_settings, "access_log_settings", {}))) > 0 ? [lookup(var.apigatewayv2_stage_access_log_settings, "access_log_settings", {})] : []

    content {
      destination_arn = lookup(access_log_settings.value, "destination_arn", null)
      format          = lookup(access_log_settings.value, "format", null)
    }
  }

  dynamic "default_route_settings" {
    iterator = default_route_settings
    for_each = length(keys(lookup(var.apigatewayv2_stage_default_route_settings, "default_route_settings", {}))) > 0 ? [lookup(var.apigatewayv2_stage_default_route_settings, "default_route_settings", {})] : []

    content {
      data_trace_enabled       = lookup(default_route_settings.value, "data_trace_enabled", null)
      detailed_metrics_enabled = lookup(default_route_settings.value, "detailed_metrics_enabled", null)
      logging_level            = lookup(default_route_settings.value, "logging_level", null)
      throttling_burst_limit   = lookup(default_route_settings.value, "throttling_burst_limit", null)
      throttling_rate_limit    = lookup(default_route_settings.value, "throttling_rate_limit", null)
    }
  }

  dynamic "route_settings" {
    iterator = route_settings
    for_each = length(keys(lookup(var.apigatewayv2_stage_route_settings, "route_settings", {}))) > 0 ? [lookup(var.apigatewayv2_stage_route_settings, "route_settings", {})] : []

    content {
      route_key = lookup(route_settings.value, "route_key", null)

      data_trace_enabled       = lookup(route_settings.value, "data_trace_enabled", null)
      detailed_metrics_enabled = lookup(route_settings.value, "detailed_metrics_enabled", null)
      logging_level            = lookup(route_settings.value, "logging_level", null)
      throttling_burst_limit   = lookup(route_settings.value, "throttling_burst_limit", null)
      throttling_rate_limit    = lookup(route_settings.value, "throttling_rate_limit", null)
    }
  }

  tags = merge(
    {
      Name = var.apigatewayv2_stage_name != "" ? var.apigatewayv2_stage_name : "${lower(var.name)}-apigatewayv2-stage-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_apigatewayv2_api.apigatewayv2_api
  ]
}