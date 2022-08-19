#---------------------------------------------------
# AWS route53 resolver query log config
#---------------------------------------------------
resource "aws_route53_resolver_query_log_config" "route53_resolver_query_log_config" {
  count = var.enable_route53_resolver_query_log_config ? 1 : 0

  name            = var.route53_resolver_query_log_config_name != "" ? lower(var.route53_resolver_query_log_config_name) : "${lower(var.name)}-route53-resolver-query-log-config-${lower(var.environment)}"
  destination_arn = var.route53_resolver_query_log_config_destination_arn

  tags = merge(
    {
      Name = var.route53_resolver_query_log_config_name != "" ? lower(var.route53_resolver_query_log_config_name) : "${lower(var.name)}-route53-resolver-query-log-config-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}