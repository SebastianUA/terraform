#---------------------------------------------------
# AWS Route53 health check
#---------------------------------------------------
resource "aws_route53_health_check" "route53_health_check" {
  count = var.enable_route53_health_check ? 1 : 0

  type              = var.route53_health_check_type
  failure_threshold = var.route53_health_check_failure_threshold
  request_interval  = var.route53_health_check_request_interval

  # Calculated_route53
  child_health_threshold = var.route53_health_check_child_health_threshold
  child_healthchecks     = var.route53_health_check_child_healthchecks

  # CloudWatch
  cloudwatch_alarm_name           = var.route53_health_check_cloudwatch_alarm_name
  cloudwatch_alarm_region         = var.route53_health_check_cloudwatch_alarm_region
  insufficient_data_health_status = var.route53_health_check_insufficient_data_health_status

  # Other settings
  disabled           = var.route53_health_check_disabled
  fqdn               = var.route53_health_check_fqdn
  reference_name     = var.route53_health_check_reference_name
  port               = var.route53_health_check_port
  ip_address         = var.route53_health_check_ip_address
  resource_path      = var.route53_health_check_resource_path
  measure_latency    = var.route53_health_check_measure_latency
  search_string      = var.route53_health_check_search_string
  invert_healthcheck = var.route53_health_check_invert_healthcheck
  enable_sni         = var.route53_health_check_enable_sni
  regions            = var.route53_health_check_regions

  tags = merge(
    {
      Name = var.route53_health_check_name != "" ? lower(var.route53_health_check_name) : "${lower(var.name)}-route53-hc-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
