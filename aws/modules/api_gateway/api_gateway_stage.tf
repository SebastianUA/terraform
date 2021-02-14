#---------------------------------------------------
# AWS API Gateway stage
#---------------------------------------------------
resource "aws_api_gateway_stage" "api_gateway_stage" {
  count = var.enable_api_gateway_stage ? 1 : 0

  rest_api_id   = var.api_gateway_stage_rest_api_id != "" && ! var.enable_api_gateway_rest_api ? var.api_gateway_stage_rest_api_id : element(concat(aws_api_gateway_rest_api.api_gateway_rest_api.*.id, [""]), 0)
  deployment_id = var.api_gateway_stage_deployment_id != "" && ! var.enable_api_gateway_deployment ? var.api_gateway_stage_deployment_id : element(concat(aws_api_gateway_deployment.api_gateway_deployment.*.id, [""]), 0)
  stage_name    = var.api_gateway_stage_stage_name != "" ? var.api_gateway_stage_stage_name : "${lower(var.name)}-api-gw-state-${lower(var.environment)}"

  description           = var.api_gateway_stage_description
  cache_cluster_enabled = var.api_gateway_stage_cache_cluster_enabled
  cache_cluster_size    = var.api_gateway_stage_cache_cluster_size
  client_certificate_id = var.api_gateway_stage_client_certificate_id != "" && ! var.enable_api_gateway_client_certificate ? var.api_gateway_stage_client_certificate_id : element(concat(aws_api_gateway_client_certificate.api_gateway_client_certificate.*.id, [""]), 0)
  documentation_version = var.api_gateway_stage_documentation_version != "" && ! var.enable_api_gateway_documentation_version ? var.api_gateway_stage_documentation_version : element(concat(aws_api_gateway_documentation_version.api_gateway_documentation_version.*.id, [""]), 0)
  variables             = var.api_gateway_stage_variables
  xray_tracing_enabled  = var.api_gateway_stage_xray_tracing_enabled

  dynamic "access_log_settings" {
    iterator = access_log_settings
    for_each = var.api_gateway_stage_access_log_settings
    content {
      destination_arn = lookup(access_log_settings.value, "destination_arn", null)
      format          = lookup(access_log_settings.value, "format", null)
    }
  }

  tags = merge(
    {
      Name = var.api_gateway_stage_stage_name != "" ? var.api_gateway_stage_stage_name : "${lower(var.name)}-api-gw-state-${lower(var.environment)}"
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
    aws_api_gateway_client_certificate.api_gateway_client_certificate,
    aws_api_gateway_documentation_version.api_gateway_documentation_version
  ]
}
