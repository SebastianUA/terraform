#---------------------------------------------------
# AWS CloudWatch event endpoint
#---------------------------------------------------
resource "aws_cloudwatch_event_endpoint" "cloudwatch_event_endpoint" {
  count = var.enable_cloudwatch_event_endpoint ? 1 : 0

  name = var.cloudwatch_event_endpoint_name != "" ? var.cloudwatch_event_endpoint_name : "${lower(var.name)}-cw-event-endpoint-${lower(var.environment)}"

  description = var.cloudwatch_event_endpoint_description
  role_arn    = var.cloudwatch_event_endpoint_role_arn


  dynamic "routing_config" {
    iterator = routing_config
    for_each = length(keys(var.cloudwatch_event_endpoint_routing_config)) > 0 ? [var.cloudwatch_event_endpoint_routing_config] : []

    content {
      dynamic "failover_config" {
        iterator = failover_config
        for_each = length(keys(lookup(routing_config.value, "failover_config", {}))) > 0 ? [lookup(routing_config.value, "failover_config", {})] : []

        content {
          dynamic "primary" {
            iterator = primary
            for_each = length(keys(lookup(failover_config.value, "primary", {}))) > 0 ? [lookup(failover_config.value, "primary", {})] : []

            content {
              health_check = lookup(primary.value, "health_check", null)
            }
          }

          dynamic "secondary" {
            iterator = secondary
            for_each = length(keys(lookup(failover_config.value, "secondary", {}))) > 0 ? [lookup(failover_config.value, "secondary", {})] : []

            content {
              route = lookup(secondary.value, "route", null)
            }
          }
        }
      }
    }
  }

  dynamic "event_bus" {
    iterator = event_bus
    for_each = length(keys(var.cloudwatch_event_endpoint_event_bus)) > 0 ? [var.cloudwatch_event_endpoint_event_bus] : []

    content {
      event_bus_arn = lookup(event_bus.value, "event_bus_arn", null)
    }
  }

  dynamic "replication_config" {
    iterator = replication_config
    for_each = length(keys(var.cloudwatch_event_endpoint_replication_config)) > 0 ? [var.cloudwatch_event_endpoint_replication_config] : []

    content {
      state = lookup(replication_config.value, "state", null)
    }
  }



  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}