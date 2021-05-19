#---------------------------------------------------
# Add autoscaling policy rules
#---------------------------------------------------
resource "aws_autoscaling_policy" "autoscaling_policy_scale_up" {
  count = var.enable_autoscaling_policy ? 1 : 0

  name                   = var.autoscaling_policy_scale_up_name != "" ? var.autoscaling_policy_scale_up_name : "${lower(var.name)}-asg_policy-${lower(var.environment)}-scale_up"
  scaling_adjustment     = var.autoscaling_policy_scale_up_scaling_adjustment
  adjustment_type        = var.autoscaling_policy_scale_up_adjustment_type
  cooldown               = var.autoscaling_policy_scale_up_cooldown
  autoscaling_group_name = var.autoscaling_group_name != "" ? var.autoscaling_group_name : element(concat(aws_autoscaling_group.asg.*.name, [""]), 0)

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_autoscaling_group.asg
  ]
}

resource "aws_autoscaling_policy" "autoscaling_policy_scale_down" {
  count = var.enable_autoscaling_policy ? 1 : 0

  name                   = var.autoscaling_policy_scale_down_name != "" ? var.autoscaling_policy_scale_down_name : "${lower(var.name)}-asg_policy-${lower(var.environment)}-scale_down"
  scaling_adjustment     = var.autoscaling_policy_scale_down_scaling_adjustment
  adjustment_type        = var.autoscaling_policy_scale_down_adjustment_type
  cooldown               = var.autoscaling_policy_scale_down_cooldown
  autoscaling_group_name = var.autoscaling_group_name != "" ? var.autoscaling_group_name : element(concat(aws_autoscaling_group.asg.*.name, [""]), 0)

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_autoscaling_group.asg
  ]
}
