#---------------------------------------------------
# AWS xray sampling rule
#---------------------------------------------------
resource "aws_xray_sampling_rule" "xray_sampling_rule" {
  count = var.enable_xray_sampling_rule ? 1 : 0

  rule_name      = var.xray_sampling_rule_name != "" ? lower(var.xray_sampling_rule_name) : "${lower(var.name)}-xray-sampling-rule-${lower(var.environment)}"
  priority       = var.xray_sampling_rule_priority
  version        = var.xray_sampling_rule_version
  reservoir_size = var.xray_sampling_rule_reservoir_size
  fixed_rate     = var.xray_sampling_rule_fixed_rate
  url_path       = var.xray_sampling_rule_url_path
  host           = var.xray_sampling_rule_host
  http_method    = var.xray_sampling_rule_http_method
  service_type   = var.xray_sampling_rule_service_type
  service_name   = var.xray_sampling_rule_service_name
  resource_arn   = var.xray_sampling_rule_resource_arn

  attributes = var.xray_sampling_rule_attributes

  tags = merge(
    {
      Name = var.xray_sampling_rule_name != "" ? lower(var.xray_sampling_rule_name) : "${lower(var.name)}-xray-sampling-rule-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
