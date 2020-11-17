#---------------------------------------------------
# Create AWS route53 zone(s)
#---------------------------------------------------
resource "aws_route53_zone" "route53_zone" {
  count = var.enable_route53_zone ? 1 : 0

  name          = var.route53_zone_name != "" ? lower(var.route53_zone_name) : "${lower(var.name)}-route53_zone-${lower(var.environment)}"
  comment       = var.route53_zone_comment
  force_destroy = var.route53_zone_force_destroy

  delegation_set_id = var.route53_zone_delegation_set_id != null ? var.route53_zone_delegation_set_id : null

  dynamic "vpc" {
    for_each = var.route53_zone_vpc
    content {
      vpc_id     = lookup(route53_zone_vpc.value, "vpc_id", null)
      vpc_region = lookup(route53_zone_vpc.value, "vpc_region", null)
    }
  }

  tags = merge(
    {
      "Name" = var.route53_zone_name != "" ? lower(var.route53_zone_name) : "${lower(var.name)}-route53_zone-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
