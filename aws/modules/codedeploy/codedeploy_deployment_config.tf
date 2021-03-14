#---------------------------------------------------
# AWS codedeploy deployment config
#---------------------------------------------------
resource "aws_codedeploy_deployment_config" "codedeploy_deployment_config" {
  count = var.enable_codedeploy_deployment_config ? length(var.codedeploy_deployment_config_stack) : 0

  deployment_config_name = lookup(var.codedeploy_deployment_config_stack[count.index], "deployment_config_name", "${lower(var.name)}-deployment-config-${count.index + 1}-${lower(var.environment)}")
  compute_platform       = lookup(var.codedeploy_deployment_config_stack[count.index], "compute_platform", null)

  dynamic "minimum_healthy_hosts" {
    iterator = minimum_healthy_hosts
    for_each = length(keys(lookup(var.codedeploy_deployment_config_stack[count.index], "minimum_healthy_hosts", {}))) > 0 ? [lookup(var.codedeploy_deployment_config_stack[count.index], "minimum_healthy_hosts", {})] : []

    content {
      type  = lookup(minimum_healthy_hosts.value, "type", null)
      value = lookup(minimum_healthy_hosts.value, "value", null)
    }
  }

  dynamic "traffic_routing_config" {
    iterator = traffic_routing_config
    for_each = length(keys(lookup(var.codedeploy_deployment_config_stack[count.index], "traffic_routing_config", {}))) > 0 ? [lookup(var.codedeploy_deployment_config_stack[count.index], "traffic_routing_config", {})] : []

    content {
      type = lookup(traffic_routing_config.value, "type", null)

      dynamic "time_based_canary" {
        iterator = time_based_canary
        for_each = length(keys(lookup(traffic_routing_config.value, "time_based_canary", {}))) > 0 ? [lookup(traffic_routing_config.value, "time_based_canary", {})] : []

        content {
          interval   = lookup(time_based_canary.value, "interval", null)
          percentage = lookup(time_based_canary.value, "percentage", null)
        }
      }

      dynamic "time_based_linear" {
        iterator = time_based_linear
        for_each = length(keys(lookup(traffic_routing_config.value, "time_based_linear", {}))) > 0 ? [lookup(traffic_routing_config.value, "time_based_linear", {})] : []

        content {
          interval   = lookup(time_based_linear.value, "interval", null)
          percentage = lookup(time_based_linear.value, "percentage", null)
        }
      }
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
