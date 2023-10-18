#---------------------------------------------------
# Cloudwatch event bus
#---------------------------------------------------
resource "aws_cloudwatch_event_bus" "cloudwatch_event_bus" {
  count = var.enable_cloudwatch_event_bus ? 1 : 0

  name = var.cloudwatch_event_bus_name != "" ? var.cloudwatch_event_bus_name : "${lower(var.name)}-cw-event-bus-${lower(var.environment)}"

  event_source_name = var.cloudwatch_event_bus_event_source_name

  tags = merge(
    {
      Name = var.cloudwatch_event_bus_name != "" ? var.cloudwatch_event_bus_name : "${lower(var.name)}-cw-event-bus-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}