#---------------------------------------------------
# AWS appautoscaling policy
#---------------------------------------------------
resource "aws_appautoscaling_policy" "appautoscaling_policy" {
  count = var.enable_appautoscaling_policy ? 1 : 0

  name               = var.appautoscaling_policy_name != "" ? lower(var.appautoscaling_policy_name) : "${lower(var.name)}-appautoscaling-policy-${lower(var.environment)}"
  policy_type        = var.appautoscaling_policy_policy_type
  resource_id        = var.appautoscaling_policy_resource_id != "" && ! var.enable_appautoscaling_target ? var.appautoscaling_policy_resource_id : element(concat(aws_appautoscaling_target.appautoscaling_target.*.resource_id, [""]), 0)
  scalable_dimension = var.appautoscaling_policy_scalable_dimension != "" && ! var.enable_appautoscaling_target ? var.appautoscaling_policy_scalable_dimension : element(concat(aws_appautoscaling_target.appautoscaling_target.*.scalable_dimension, [""]), 0)
  service_namespace  = var.appautoscaling_policy_service_namespace != "" && ! var.enable_appautoscaling_target ? var.appautoscaling_policy_service_namespace : element(concat(aws_appautoscaling_target.appautoscaling_target.*.service_namespace, [""]), 0)

  dynamic "step_scaling_policy_configuration" {
    iterator = stepscalingpolicy
    for_each = var.appautoscaling_policy_policy_type == "StepScaling" ? var.appautoscaling_policy_step_scaling_policy_configuration : []
    content {
      adjustment_type = lookup(stepscalingpolicy.value, "adjustment_type", null)
      cooldown        = lookup(stepscalingpolicy.value, "cooldown", null)

      metric_aggregation_type  = lookup(stepscalingpolicy.value, "metric_aggregation_type", null)
      min_adjustment_magnitude = lookup(stepscalingpolicy.value, "min_adjustment_magnitude", null)
    }
  }

  dynamic "step_scaling_policy_configuration" {
    iterator = stepscalingpolicy
    for_each = var.appautoscaling_policy_policy_type == "StepScaling" ? var.appautoscaling_policy_step_scaling_policy_configuration_step_adjustment : []
    content {
      adjustment_type = lookup(stepscalingpolicy.value, "adjustment_type", null)
      cooldown        = lookup(stepscalingpolicy.value, "cooldown", null)

      metric_aggregation_type  = lookup(stepscalingpolicy.value, "metric_aggregation_type", null)
      min_adjustment_magnitude = lookup(stepscalingpolicy.value, "min_adjustment_magnitude", null)

      step_adjustment {
        scaling_adjustment = lookup(stepscalingpolicy.value, "scaling_adjustment", null)

        metric_interval_lower_bound = lookup(stepscalingpolicy.value, "metric_interval_lower_bound", null)
        metric_interval_upper_bound = lookup(stepscalingpolicy.value, "metric_interval_upper_bound", null)
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
    }
  }

  dynamic "target_tracking_scaling_policy_configuration" {
    iterator = targettrackingscalingpolicy
    for_each = var.appautoscaling_policy_policy_type == "TargetTrackingScaling" ? var.appautoscaling_policy_target_tracking_scaling_policy_configuration_customized_metric_specification : []
    content {
      target_value = lookup(targettrackingscalingpolicy.value, "target_value", null)

      disable_scale_in   = lookup(targettrackingscalingpolicy.value, "disable_scale_in", false)
      scale_in_cooldown  = lookup(targettrackingscalingpolicy.value, "scale_in_cooldown", null)
      scale_out_cooldown = lookup(targettrackingscalingpolicy.value, "scale_out_cooldown", null)

      customized_metric_specification {
        metric_name = lookup(targettrackingscalingpolicy.value, "metric_name", null)
        namespace   = lookup(targettrackingscalingpolicy.value, "namespace", null)
        statistic   = lookup(targettrackingscalingpolicy.value, "statistic", null)

        #dimensions      = lookup(targettrackingscalingpolicy.value, "dimensions", null)
        unit = lookup(targettrackingscalingpolicy.value, "unit", null)
      }
    }
  }

  dynamic "target_tracking_scaling_policy_configuration" {
    iterator = targettrackingscalingpolicy
    for_each = var.appautoscaling_policy_policy_type == "TargetTrackingScaling" ? var.appautoscaling_policy_target_tracking_scaling_policy_configuration_predefined_metric_specification : []
    content {
      target_value = lookup(targettrackingscalingpolicy.value, "target_value", null)

      disable_scale_in   = lookup(targettrackingscalingpolicy.value, "disable_scale_in", false)
      scale_in_cooldown  = lookup(targettrackingscalingpolicy.value, "scale_in_cooldown", null)
      scale_out_cooldown = lookup(targettrackingscalingpolicy.value, "scale_out_cooldown", null)

      predefined_metric_specification {
        predefined_metric_type = lookup(targettrackingscalingpolicy.value, "predefined_metric_type", null)

        resource_label = lookup(targettrackingscalingpolicy.value, "resource_label", null)
      }
    }
  }

  dynamic "target_tracking_scaling_policy_configuration" {
    iterator = targettrackingscalingpolicy
    for_each = var.appautoscaling_policy_policy_type == "TargetTrackingScaling" ? var.appautoscaling_policy_target_tracking_scaling_policy_configuration_all : []
    content {
      target_value = lookup(targettrackingscalingpolicy.value, "target_value", null)

      disable_scale_in   = lookup(targettrackingscalingpolicy.value, "disable_scale_in", false)
      scale_in_cooldown  = lookup(targettrackingscalingpolicy.value, "scale_in_cooldown", null)
      scale_out_cooldown = lookup(targettrackingscalingpolicy.value, "scale_out_cooldown", null)

      customized_metric_specification {
        metric_name = lookup(targettrackingscalingpolicy.value, "metric_name", null)
        namespace   = lookup(targettrackingscalingpolicy.value, "namespace", null)
        statistic   = lookup(targettrackingscalingpolicy.value, "statistic", null)

        #dimensions      = lookup(targettrackingscalingpolicy.value, "dimensions", null)
        unit = lookup(targettrackingscalingpolicy.value, "unit", null)
      }

      predefined_metric_specification {
        predefined_metric_type = lookup(targettrackingscalingpolicy.value, "predefined_metric_type", null)

        resource_label = lookup(targettrackingscalingpolicy.value, "resource_label", null)
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
