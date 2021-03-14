#---------------------------------------------------
# AWS appautoscaling scheduled action
#---------------------------------------------------
resource "aws_appautoscaling_scheduled_action" "appautoscaling_scheduled_action" {
  count = var.enable_appautoscaling_scheduled_action ? 1 : 0

  name               = var.appautoscaling_scheduled_action_name != "" ? lower(var.appautoscaling_scheduled_action_name) : "${lower(var.name)}-appautoscaling-scheduled-action-${lower(var.environment)}"
  resource_id        = var.appautoscaling_scheduled_action_resource_id != "" && ! var.enable_appautoscaling_target ? var.appautoscaling_scheduled_action_resource_id : element(concat(aws_appautoscaling_target.appautoscaling_target.*.resource_id, [""]), 0)
  scalable_dimension = var.appautoscaling_scheduled_action_scalable_dimension != "" && ! var.enable_appautoscaling_target ? var.appautoscaling_scheduled_action_scalable_dimension : element(concat(aws_appautoscaling_target.appautoscaling_target.*.scalable_dimension, [""]), 0)
  service_namespace  = var.appautoscaling_scheduled_action_service_namespace != "" && ! var.enable_appautoscaling_target ? var.appautoscaling_scheduled_action_service_namespace : element(concat(aws_appautoscaling_target.appautoscaling_target.*.service_namespace, [""]), 0)

  schedule   = var.appautoscaling_scheduled_action_schedule
  start_time = var.appautoscaling_scheduled_action_start_time
  end_time   = var.appautoscaling_scheduled_action_end_time

  dynamic "scalable_target_action" {
    iterator = scalabletarget
    for_each = var.appautoscaling_scheduled_action_scalable_target_action
    content {
      min_capacity = lookup(scalabletarget.value, "min_capacity", null)
      max_capacity = lookup(scalabletarget.value, "max_capacity", null)
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
