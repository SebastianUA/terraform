#---------------------------------------------------
# AWS placement group (EC2)
#---------------------------------------------------
resource "aws_placement_group" "placement_group" {
  count = var.enable_placement_group ? 1 : 0

  name     = var.placement_group_name != "" ? var.placement_group_name : "${lower(var.name)}-pg-${lower(var.environment)}"
  strategy = var.placement_group_strategy

  tags = merge(
    {
      Name = var.placement_group_name != "" ? var.placement_group_name : "${lower(var.name)}-pg-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = false
    ignore_changes        = []
  }

  depends_on = []
}