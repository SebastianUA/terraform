#---------------------------------------------------
# Create AWS route53 health check(s)
#---------------------------------------------------
resource "aws_route53_health_check" "route53_health_check" {
    count                           = var.enable_route53_health_check ? 1 : 0

    type                            = var.route53_health_check_type

    # Default setting for Route53 HC
    fqdn                            = var.route53_health_check_fqdn != null ? var.route53_health_check_fqdn : null
    port                            = var.route53_health_check_port != null ? var.route53_health_check_port : null
    resource_path                   = var.route53_health_check_resource_path != null ? var.route53_health_check_resource_path : null
    failure_threshold               = var.route53_health_check_failure_threshold != null ? var.route53_health_check_failure_threshold : null
    request_interval                = var.route53_health_check_request_interval != null ? var.route53_health_check_request_interval : null
    measure_latency                 = var.route53_health_check_measure_latency != null ? var.route53_health_check_measure_latency : null

    # Calculated_route53
    child_health_threshold          = var.route53_health_check_child_health_threshold != null ? var.route53_health_check_child_health_threshold: null
    child_healthchecks              = var.route53_health_check_child_healthchecks != null ? var.route53_health_check_child_healthchecks : null

    # CloudWatch
    cloudwatch_alarm_name           = var.route53_health_check_cloudwatch_alarm_name
    cloudwatch_alarm_region         = var.route53_health_check_cloudwatch_alarm_region
    insufficient_data_health_status = var.route53_health_check_insufficient_data_health_status

    # Adds settings
    reference_name                  = var.route53_health_check_reference_name != null ? lower(var.route53_health_check_reference_name) : null
    ip_address                      = var.ip_address != null ? var.ip_address : null
    search_string                   = var.search_string != null ? var.search_string : null
    invert_healthcheck              = var.invert_healthcheck != null ? var.invert_healthcheck : null
    enable_sni                      = var.enable_sni != null ? var.enable_sni : null
    regions                         = var.route53_health_check_regions != null ? var.route53_health_check_regions : null

    tags                            = merge(
        {
            "Name"          = var.route53_health_check_name != "" ? lower(var.route53_health_check_name) : "${lower(var.name)}-route53_hc-${lower(var.environment)}"
        },
        var.tags
    )

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on  = []
}
