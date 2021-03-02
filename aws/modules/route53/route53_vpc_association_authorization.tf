#---------------------------------------------------
# AWS route53 vpc association authorization
#---------------------------------------------------
resource "aws_route53_vpc_association_authorization" "route53_vpc_association_authorization" {
  count = var.enable_route53_vpc_association_authorization ? 1 : 0

  zone_id = var.route53_vpc_association_authorization_zone_id
  vpc_id  = var.route53_vpc_association_authorization_vpc_id

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}