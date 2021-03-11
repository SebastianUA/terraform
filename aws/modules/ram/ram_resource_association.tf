#---------------------------------------------------
# AWS ram resource association
#---------------------------------------------------
resource "aws_ram_resource_association" "ram_resource_association" {
  count = var.enable_ram_resource_association ? 1 : 0

  resource_arn       = var.ram_resource_association_resource_arn
  resource_share_arn = var.ram_resource_association_resource_share_arn != "" ? var.ram_resource_association_resource_share_arn : (var.enable_ram_resource_share ? aws_ram_resource_share.ram_resource_share.0.arn : null)

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_ram_resource_share.ram_resource_share
  ]
}
