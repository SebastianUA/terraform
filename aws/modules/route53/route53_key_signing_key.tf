#---------------------------------------------------
# AWS Route53 key signing key
#---------------------------------------------------
resource "aws_route53_key_signing_key" "route53_key_signing_key" {
  count = var.enable_route53_key_signing_key ? 1 : 0

  name                       = var.route53_key_signing_key_name != "" ? lower(var.route53_zone_name) : "${lower(var.name)}-route53-key-signing-key-${lower(var.environment)}"
  hosted_zone_id             = var.route53_key_signing_key_hosted_zone_id != "" ? var.route53_key_signing_key_hosted_zone_id : (var.enable_route53_zone ? element(aws_route53_zone.route53_zone.*.id, 0) : null)
  key_management_service_arn = var.route53_key_signing_key_key_management_service_arn

  status = var.route53_key_signing_key_status != null ? upper(var.route53_key_signing_key_status) : null

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}