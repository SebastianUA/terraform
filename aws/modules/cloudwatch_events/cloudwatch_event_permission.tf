#---------------------------------------------------
# Cloudwatch event permission
#---------------------------------------------------
resource "aws_cloudwatch_event_permission" "cloudwatch_event_permission" {
  count = var.enable_cloudwatch_event_permission ? 1 : 0

  principal    = var.cloudwatch_event_permission_principal
  statement_id = var.cloudwatch_event_permission_statement_id

  action         = var.cloudwatch_event_permission_action
  event_bus_name = var.cloudwatch_event_permission_event_bus_name

  dynamic "condition" {
    iterator = condition
    for_each = var.cloudwatch_event_permission_condition

    content {
      key   = lookup(condition.value, "key", null)
      type  = lookup(condition.value, "type", null)
      value = lookup(condition.value, "value", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}

