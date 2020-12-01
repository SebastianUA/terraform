#---------------------------------------------------
# AWS sfn state machine
#---------------------------------------------------
resource "aws_sfn_state_machine" "sfn_state_machine" {
  count = var.enable_sfn_state_machine ? 1 : 0

  name       = var.sfn_state_machine_name != "" ? var.sfn_state_machine_name : "${lower(var.name)}-sfn-activity-${lower(var.environment)}"
  definition = var.sfn_state_machine_definition
  role_arn   = var.sfn_state_machine_role_arn

  tags = merge(
    {
      Name = var.sfn_state_machine_name != "" ? var.sfn_state_machine_name : "${lower(var.name)}-sfn-activity-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}