#---------------------------------------------------
# AWS Route53 delegation set
#---------------------------------------------------
resource "aws_route53_delegation_set" "route53_delegation_set" {
  count = var.enable_route53_delegation_set ? 1 : 0

  reference_name = var.route53_delegation_set_reference_name

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []

}
