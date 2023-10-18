#---------------------------------------------------
# Cloudwatch event bus policy
#---------------------------------------------------
resource "aws_cloudwatch_event_bus_policy" "cloudwatch_event_bus_policy" {
  count = var.enable_cloudwatch_event_bus_policy ? 1 : 0

  policy         = var.cloudwatch_event_bus_policy_policy
  event_bus_name = var.cloudwatch_event_bus_policy_event_bus_name != null ? var.cloudwatch_event_bus_policy_event_bus_name : (var.enable_cloudwatch_event_bus ? aws_cloudwatch_event_bus.cloudwatch_event_bus.name : null)

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_cloudwatch_event_bus.cloudwatch_event_bus
  ]
}