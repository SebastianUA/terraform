#---------------------------------------------------
# AWS ram principal association
#---------------------------------------------------
resource "aws_ram_principal_association" "ram_principal_association" {
  count = var.enable_ram_principal_association ? 1 : 0

  principal          = var.ram_principal_association_principal
  resource_share_arn = var.ram_principal_association_resource_share_arn != null && !var.enable_ram_resource_share ? var.ram_principal_association_resource_share_arn : aws_ram_resource_share.ram_resource_share[0].arn

  # The invitation sometime takes a few seconds to propagate
  provisioner "local-exec" {
    command = "python -c 'import time; time.sleep(10)'"
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_ram_resource_share.ram_resource_share
  ]
}