#---------------------------------------------------
# Create AWS route53 zone association
#---------------------------------------------------
resource "aws_route53_zone_association" "route53_zone_association" {
  count = var.enable_route53_zone_association ? 1 : 0

  zone_id    = var.route53_zone_association_zone_id != "" ? var.route53_zone_association_zone_id : element(concat(aws_route53_zone.route53_zone.*.id, [""]), 0)
  vpc_id     = var.route53_zone_association_vpc_id
  vpc_region = var.route53_zone_association_vpc_region

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
