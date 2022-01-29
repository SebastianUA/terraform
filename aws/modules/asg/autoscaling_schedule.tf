#---------------------------------------------------
# AWS ASG schedule
#---------------------------------------------------
resource "aws_autoscaling_schedule" "autoscaling_schedule" {
  count = var.enable_autoscaling_schedule && length(var.autoscaling_schedule_stack) > 0 ? length(var.autoscaling_schedule_stack) : 0

  scheduled_action_name  = lookup(var.autoscaling_schedule_stack[count.index], "scheduled_action_name", null)
  min_size               = lookup(var.autoscaling_schedule_stack[count.index], "min_size", null)
  max_size               = lookup(var.autoscaling_schedule_stack[count.index], "max_size", null)
  desired_capacity       = lookup(var.autoscaling_schedule_stack[count.index], "desired_capacity", null)
  recurrence             = lookup(var.autoscaling_schedule_stack[count.index], "recurrence", null)
  autoscaling_group_name = lookup(var.autoscaling_schedule_stack[count.index], "autoscaling_group_name", (var.autoscaling_group_name != "" ? var.autoscaling_group_name : element(concat(aws_autoscaling_group.asg.*.name, [""]), 0)))

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_autoscaling_group.asg
  ]
}
