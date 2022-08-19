#---------------------------------------------------
# AWS CloudWatch event permission
#---------------------------------------------------
resource "aws_cloudwatch_event_permission" "cw_event_permission" {
  count = var.enable_cw_event_permission ? 1 : 0

  principal    = var.cw_event_permission_principal
  statement_id = var.cw_event_permission_statement_id
  action       = var.cw_event_permission_action

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
