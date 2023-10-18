#---------------------------------------------------
# AWS Sagemaker endpoint
#---------------------------------------------------
resource "aws_sagemaker_endpoint" "sagemaker_endpoint" {
  count = var.enable_sagemaker_endpoint ? 1 : 0

  name                 = var.sagemaker_endpoint_name != "" ? lower(var.sagemaker_endpoint_name) : "${lower(var.name)}-endpoint-${lower(var.environment)}"
  endpoint_config_name = var.sagemaker_endpoint_endpoint_config_name != "" && !var.enable_sagemaker_endpoint_configuration ? var.sagemaker_endpoint_endpoint_config_name : element(concat(aws_sagemaker_endpoint_configuration.sagemaker_endpoint_configuration.*.name, [""]), 0)


  dynamic "deployment_config" {
    iterator = deployment_config
    for_each = var.sagemaker_endpoint_deployment_config

    content {
      dynamic "blue_green_update_policy" {
        iterator = blue_green_update_policy
        for_each = length(keys(lookup(deployment_config.value, "blue_green_update_policy", {}))) > 0 ? [lookup(deployment_config.value, "blue_green_update_policy", {})] : []

        content {
          dynamic "traffic_routing_configuration" {
            iterator = traffic_routing_configuration
            for_each = length(keys(lookup(blue_green_update_policy.value, "traffic_routing_configuration", {}))) > 0 ? [lookup(blue_green_update_policy.value, "traffic_routing_configuration", {})] : []

            content {
              type                     = lookup(traffic_routing_configuration.value, "type", null)
              wait_interval_in_seconds = lookup(traffic_routing_configuration.value, "wait_interval_in_seconds", null)

              dynamic "canary_size" {
                iterator = canary_size
                for_each = length(keys(lookup(traffic_routing_configuration.value, "canary_size", {}))) > 0 ? [lookup(traffic_routing_configuration.value, "canary_size", {})] : []

                content {
                  type  = lookup(canary_size.value, "type", null)
                  value = lookup(canary_size.value, "value", null)
                }
              }
              dynamic "linear_step_size" {
                iterator = linear_step_size
                for_each = length(keys(lookup(traffic_routing_configuration.value, "linear_step_size", {}))) > 0 ? [lookup(traffic_routing_configuration.value, "linear_step_size", {})] : []

                content {
                  type  = lookup(linear_step_size.value, "type", null)
                  value = lookup(linear_step_size.value, "value", null)
                }
              }
            }
          }

          maximum_execution_timeout_in_seconds = lookup(blue_green_update_policy.value, "maximum_execution_timeout_in_seconds", null)
          termination_wait_in_seconds          = lookup(blue_green_update_policy.value, "termination_wait_in_seconds", null)
        }
      }

      dynamic "auto_rollback_configuration" {
        iterator = auto_rollback_configuration
        for_each = length(keys(lookup(deployment_config.value, "auto_rollback_configuration", {}))) > 0 ? [lookup(deployment_config.value, "auto_rollback_configuration", {})] : []

        content {
          dynamic "alarms" {
            iterator = alarms
            for_each = length(keys(lookup(auto_rollback_configuration.value, "alarms", {}))) > 0 ? [lookup(auto_rollback_configuration.value, "alarms", {})] : []

            content {
              alarm_name = lookup(alarms.value, "alarm_name", null)
            }
          }
        }
      }

    }
  }

  tags = merge(
    {
      Name = var.sagemaker_endpoint_name != "" ? lower(var.sagemaker_endpoint_name) : "${lower(var.name)}-endpoint-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_sagemaker_endpoint_configuration.sagemaker_endpoint_configuration
  ]
}
