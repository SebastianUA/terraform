#---------------------------------------------------
# AWS API Gateway method settings
#---------------------------------------------------
resource "aws_api_gateway_method_settings" "api_gateway_method_settings" {
  count = var.enable_api_gateway_method_settings ? 1 : 0

  rest_api_id = var.api_gateway_method_settings_rest_api_id != "" && !var.enable_api_gateway_rest_api ? var.api_gateway_method_settings_rest_api_id : element(concat(aws_api_gateway_rest_api.api_gateway_rest_api.*.id, [""]), 0)
  stage_name  = var.api_gateway_method_settings_stage_name != "" && !var.enable_api_gateway_stage ? var.api_gateway_method_settings_stage_name : element(concat(aws_api_gateway_deployment.api_gateway_deployment.*.stage_name, [""]), 0)
  method_path = var.api_gateway_method_settings_method_path != "" && !var.enable_api_gateway_method ? var.api_gateway_method_settings_method_path : "${element(concat(aws_api_gateway_deployment.api_gateway_deployment.*.path_part, [""]), 0)}/${element(concat(aws_api_gateway_deployment.api_gateway_deployment.*.http_method, [""]), 0)}"

  dynamic "settings" {
    iterator = settings
    for_each = var.api_gateway_method_settings_settings
    content {
      metrics_enabled                            = lookup(settings.value, "metrics_enabled", null)
      logging_level                              = lookup(settings.value, "logging_level", null)
      data_trace_enabled                         = lookup(settings.value, "data_trace_enabled", null)
      throttling_burst_limit                     = lookup(settings.value, "throttling_burst_limit", null)
      throttling_rate_limit                      = lookup(settings.value, "throttling_rate_limit", null)
      caching_enabled                            = lookup(settings.value, "caching_enabled", null)
      cache_ttl_in_seconds                       = lookup(settings.value, "cache_ttl_in_seconds", null)
      cache_data_encrypted                       = lookup(settings.value, "cache_data_encrypted", null)
      require_authorization_for_cache_control    = lookup(settings.value, "require_authorization_for_cache_control", null)
      unauthorized_cache_control_header_strategy = lookup(settings.value, "unauthorized_cache_control_header_strategy", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_api_gateway_rest_api.api_gateway_rest_api,
    aws_api_gateway_deployment.api_gateway_deployment,
    aws_api_gateway_method.api_gateway_method
  ]
}
