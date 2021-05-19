#---------------------------------------------------
# AWS appautoscaling policy
#---------------------------------------------------
resource "aws_appautoscaling_policy" "appautoscaling_policy" {
  count = var.enable_appautoscaling_policy ? 1 : 0

  name               = var.appautoscaling_policy_name != "" ? lower(var.appautoscaling_policy_name) : "${lower(var.name)}-appautoscaling-policy-${lower(var.environment)}"
  policy_type        = var.appautoscaling_policy_policy_type
  resource_id        = var.appautoscaling_policy_resource_id != "" && !var.enable_appautoscaling_target ? var.appautoscaling_policy_resource_id : element(concat(aws_appautoscaling_target.appautoscaling_target.*.resource_id, [""]), 0)
  scalable_dimension = var.appautoscaling_policy_scalable_dimension != "" && !var.enable_appautoscaling_target ? var.appautoscaling_policy_scalable_dimension : element(concat(aws_appautoscaling_target.appautoscaling_target.*.scalable_dimension, [""]), 0)
  service_namespace  = var.appautoscaling_policy_service_namespace != "" && !var.enable_appautoscaling_target ? var.appautoscaling_policy_service_namespace : element(concat(aws_appautoscaling_target.appautoscaling_target.*.service_namespace, [""]), 0)

  dynamic "step_scaling_policy_configuration" {
    iterator = stepscalingpolicy
    for_each = var.appautoscaling_policy_policy_type == "StepScaling" ? var.appautoscaling_policy_step_scaling_policy_configuration : []

    content {
      adjustment_type = lookup(stepscalingpolicy.value, "adjustment_type", null)
      cooldown        = lookup(stepscalingpolicy.value, "cooldown", null)

      metric_aggregation_type  = lookup(stepscalingpolicy.value, "metric_aggregation_type", null)
      min_adjustment_magnitude = lookup(stepscalingpolicy.value, "min_adjustment_magnitude", null)

      dynamic "step_adjustment" {
        iterator = step_adjustment
        for_each = length(keys(lookup(stepscalingpolicy.value, "step_adjustment", {}))) > 0 ? [lookup(stepscalingpolicy.value, "step_adjustment", {})] : []

        content {
          scaling_adjustment = lookup(step_adjustment.value, "scaling_adjustment", null)

          metric_interval_lower_bound = lookup(step_adjustment.value, "metric_interval_lower_bound", null)
          metric_interval_upper_bound = lookup(step_adjustment.value, "metric_interval_upper_bound", null)
        }
      }
    }
  }

  dynamic "target_tracking_scaling_policy_configuration" {
    iterator = targettrackingscalingpolicy
    for_each = var.appautoscaling_policy_policy_type == "TargetTrackingScaling" ? var.appautoscaling_policy_target_tracking_scaling_policy_configuration : []

    content {
      target_value = lookup(targettrackingscalingpolicy.value, "target_value", null)

      disable_scale_in   = lookup(targettrackingscalingpolicy.value, "disable_scale_in", false)
      scale_in_cooldown  = lookup(targettrackingscalingpolicy.value, "scale_in_cooldown", null)
      scale_out_cooldown = lookup(targettrackingscalingpolicy.value, "scale_out_cooldown", null)

      dynamic "customized_metric_specification" {
        iterator = customized_metric_specification
        for_each = length(keys(lookup(targettrackingscalingpolicy.value, "customized_metric_specification", {}))) > 0 ? [lookup(targettrackingscalingpolicy.value, "customized_metric_specification", {})] : []

        content {
          metric_name = lookup(customized_metric_specification.value, "metric_name", null)
          namespace   = lookup(customized_metric_specification.value, "namespace", null)
          statistic   = lookup(customized_metric_specification.value, "statistic", null)

          unit = lookup(customized_metric_specification.value, "unit", null)

          dynamic "dimensions" {
            iterator = dimensions
            for_each = lookup(customized_metric_specification.value, "dimensions", [])

            content {
              name  = lookup(dimensions.value, "name", null)
              value = lookup(dimensions.value, "value", null)
            }
          }
        }
      }

      dynamic "predefined_metric_specification" {
        iterator = predefined_metric_specification
        for_each = length(keys(lookup(targettrackingscalingpolicy.value, "predefined_metric_specification", {}))) > 0 ? [lookup(targettrackingscalingpolicy.value, "predefined_metric_specification", {})] : []

        content {
          predefined_metric_type = lookup(predefined_metric_specification.value, "predefined_metric_type", null)

          resource_label = lookup(predefined_metric_specification.value, "resource_label", null)
        }
      }

    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_appautoscaling_target.appautoscaling_target
  ]
}
