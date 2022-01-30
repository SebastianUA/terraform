#---------------------------------------------------
# AWS shield protection
#---------------------------------------------------
data "aws_availability_zones" "availability_zones" {}
data "aws_region" "region" {}
data "aws_caller_identity" "caller_identity" {}

resource "aws_shield_protection" "shield_protection" {
  count = var.enable_shield_protection ? 1 : 0

  name         = var.shield_protection_name != "" ? lower(var.shield_protection_name) : "${lower(var.name)}-shield-protection-${lower(var.environment)}"
  resource_arn = var.shield_protection_resource_arn != "" ? var.shield_protection_resource_arn : "arn:aws:ec2:${data.aws_region.region.name}:${data.aws_caller_identity.caller_identity.account_id}:eip-allocation/${aws_eip.eip.id}"

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    data.aws_region.region,
    data.aws_caller_identity.caller_identity,
    data.aws_availability_zones.availability_zones,
    aws_eip.eip
  ]
}
