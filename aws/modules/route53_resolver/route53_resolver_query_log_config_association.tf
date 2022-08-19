#---------------------------------------------------
# AWS route53 resolver query log config association
#---------------------------------------------------
resource "aws_route53_resolver_query_log_config_association" "route53_resolver_query_log_config_association" {
  count = var.enable_route53_resolver_query_log_config_association ? 1 : 0

  resolver_query_log_config_id = var.route53_resolver_query_log_config_association_resolver_query_log_config_id != "" ? var.route53_resolver_query_log_config_association_resolver_query_log_config_id : (var.enable_route53_resolver_query_log_config ? aws_route53_resolver_query_log_config.route53_resolver_query_log_config.0.id : null)
  resource_id                  = var.route53_resolver_query_log_config_association_resource_id

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_route53_resolver_query_log_config.route53_resolver_query_log_config
  ]
}