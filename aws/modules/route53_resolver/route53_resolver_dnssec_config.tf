#---------------------------------------------------
# AWS route53 resolver dnssec config
#---------------------------------------------------
resource "aws_route53_resolver_dnssec_config" "route53_resolver_dnssec_config" {
  count = var.enable_route53_resolver_dnssec_config ? 1 : 0

  resource_id = var.route53_resolver_dnssec_config_resource_id

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}