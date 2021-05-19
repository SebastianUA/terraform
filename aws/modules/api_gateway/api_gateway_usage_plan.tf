#---------------------------------------------------
# AWS API Gateway usage plan
#---------------------------------------------------
resource "aws_api_gateway_usage_plan" "api_gateway_usage_plan" {
  count = var.enable_api_gateway_usage_plan ? 1 : 0

  name = var.api_gateway_usage_plan_name != "" ? var.api_gateway_usage_plan_name : "${lower(var.name)}-api-gw-usage-plan-${lower(var.environment)}"

  description  = var.api_gateway_usage_plan_description
  product_code = var.api_gateway_usage_plan_product_code

  dynamic "api_stages" {
    iterator = api_stages
    for_each = var.api_gateway_usage_plan_api_stages

    content {
      api_id = lookup(access_log_settings.value, "api_id", null)
      stage  = lookup(access_log_settings.value, "stage", null)
    }
  }

  dynamic "quota_settings" {
    iterator = quota_settings
    for_each = var.api_gateway_usage_plan_quota_settings

    content {
      limit  = lookup(quota_settings.value, "limit", null)
      offset = lookup(quota_settings.value, "offset", null)
      period = lookup(quota_settings.value, "period", null)
    }
  }

  dynamic "throttle_settings" {
    iterator = throttle_settings
    for_each = var.api_gateway_usage_plan_throttle_settings

    content {
      burst_limit = lookup(throttle_settings.value, "burst_limit", null)
      rate_limit  = lookup(throttle_settings.value, "rate_limit", null)
    }
  }

  tags = merge(
    {
      Name = var.api_gateway_usage_plan_name != "" ? var.api_gateway_usage_plan_name : "${lower(var.name)}-api-gw-usage-plan-${lower(var.environment)}"
    },
    var.tags
  )

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
