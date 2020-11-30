#---------------------------------------------------
# AWS sfn activity
#---------------------------------------------------
resource "aws_sfn_activity" "sfn_activity" {
  count = var.enable_sfn_activity ? 1 : 0

  name = var.sfn_activity_name != "" ? var.sfn_activity_name : "${lower(var.name)}-sfn-activity-${lower(var.environment)}"

  tags = merge(
    {
      Name = var.sfn_activity_name != "" ? var.sfn_activity_name : "${lower(var.name)}-sfn-activity-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}