#---------------------------------------------------
# AWS xray group
#---------------------------------------------------
resource "aws_xray_group" "xray_group" {
  count = var.enable_xray_group ? 1 : 0

  group_name        = var.xray_group_name != "" ? var.xray_group_name : "${lower(var.name)}-xray-group-${lower(var.environment)}"
  filter_expression = var.xray_group_filter_expression

  tags = merge(
    {
      Name = var.xray_group_name != "" ? var.xray_group_name : "${lower(var.name)}-xray-group-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}

