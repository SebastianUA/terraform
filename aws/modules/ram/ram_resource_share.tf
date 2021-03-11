#---------------------------------------------------
# AWS ram resource share
#---------------------------------------------------
resource "aws_ram_resource_share" "ram_resource_share" {
  count = var.enable_ram_resource_share ? 1 : 0

  name                      = var.ram_resource_share_name != "" ? lower(var.ram_resource_share_name) : "${lower(var.name)}-ram-resource-share-${lower(var.environment)}"
  allow_external_principals = var.ram_resource_share_allow_external_principals

  tags = merge(
    {
      Name = var.ram_resource_share_name != "" ? lower(var.ram_resource_share_name) : "${lower(var.name)}-ram-resource-share-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}