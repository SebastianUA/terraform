#---------------------------------------------------
# ASW ASG Scale-up/Scale-down
#---------------------------------------------------
resource "aws_autoscaling_schedule" "autoscaling_schedule_scale_out" {
  count = var.enable_autoscaling_schedule ? 1 : 0

  scheduled_action_name  = var.autoscaling_schedule_scale_out_name != "" ? var.autoscaling_schedule_scale_out_name : "${lower(var.name)}-asg_schedule-${lower(var.environment)}-scale_out"
  min_size               = var.autoscaling_schedule_scale_out_min_size
  max_size               = var.autoscaling_schedule_scale_out_max_size
  desired_capacity       = var.autoscaling_schedule_scale_out_desired_capacity
  recurrence             = var.autoscaling_schedule_scale_out_recurrence
  autoscaling_group_name = var.autoscaling_group_name != "" ? var.autoscaling_group_name : element(concat(aws_autoscaling_group.asg.*.name, [""]), 0)

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_autoscaling_group.asg
  ]
}

resource "aws_autoscaling_schedule" "autoscaling_schedule_scale_in" {
  count = var.enable_autoscaling_schedule ? 1 : 0

  scheduled_action_name  = var.autoscaling_schedule_scale_in_name != "" ? var.autoscaling_schedule_scale_in_name : "${lower(var.name)}-asg_schedule-${lower(var.environment)}-scale_in"
  min_size               = var.autoscaling_schedule_scale_in_min_size
  max_size               = var.autoscaling_schedule_scale_in_max_size
  desired_capacity       = var.autoscaling_schedule_scale_in_desired_capacity
  recurrence             = var.autoscaling_schedule_scale_in_recurrence
  autoscaling_group_name = var.autoscaling_group_name != "" ? var.autoscaling_group_name : element(concat(aws_autoscaling_group.asg.*.name, [""]), 0)

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_autoscaling_group.asg
  ]
}
