#---------------------------------------------------
# AWS worklink website certificate authority association
#---------------------------------------------------
resource "aws_worklink_website_certificate_authority_association" "worklink_website_certificate_authority_association" {
  count = var.enable_worklink_website_certificate_authority_association ? 1 : 0

  fleet_arn   = var.worklink_website_certificate_authority_association_fleet_arn != "" && ! var.enable_worklink_fleet ? var.worklink_website_certificate_authority_association_fleet_arn : element(concat(aws_worklink_fleet.worklink_fleet.*.arn, [""]), 0)
  certificate = var.worklink_website_certificate_authority_association_certificate

  display_name = var.worklink_website_certificate_authority_association_display_name

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_worklink_fleet.worklink_fleet
  ]
}
