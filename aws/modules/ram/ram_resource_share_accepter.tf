#---------------------------------------------------
# AWS ram resource share accepter
#---------------------------------------------------
resource "aws_ram_resource_share_accepter" "ram_resource_share_accepter" {
  count = var.enable_ram_resource_share_accepter ? 1 : 0

  share_arn = var.ram_resource_share_accepter_share_arn != "" ? var.ram_resource_share_accepter_share_arn : (var.enable_ram_principal_association ? aws_ram_principal_association.ram_principal_association.0.resource_share_arn : null)

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_ram_principal_association.ram_principal_association
  ]
}

