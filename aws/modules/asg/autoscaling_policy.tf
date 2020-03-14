#---------------------------------------------------
# Add autoscaling policy rules
#---------------------------------------------------
resource "aws_autoscaling_policy" "scale_up" {
    count                   = var.enable_autoscaling_policy ? 1 : 0

    name                    = var.autoscaling_scale_up_policy != "" ? var.autoscaling_scale_up_policy : "${lower(var.name)}-asg_policy-${lower(var.environment)}-scale_up"
    scaling_adjustment      = var.asg_size_scale
    adjustment_type         = var.adjustment_type
    cooldown                = var.default_cooldown
    autoscaling_group_name  = var.autoscaling_group_name != "" ? var.autoscaling_group_name : element(concat(aws_autoscaling_group.asg.*.name, aws_autoscaling_group.asg_prefix.*.name, aws_autoscaling_group.asg_azs.*.name, aws_autoscaling_group.asg_azs_prefix.*.name, [""]), 0)

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on  = [
        aws_autoscaling_group.asg,
        aws_autoscaling_group.asg_prefix,
        aws_autoscaling_group.asg_azs,
        aws_autoscaling_group.asg_azs_prefix
    ]
}

resource "aws_autoscaling_policy" "scale_down" {
    count                   = var.enable_autoscaling_policy ? 1 : 0

    name                    = var.autoscaling_scale_down_policy != "" ? var.autoscaling_scale_down_policy : "${lower(var.name)}-asg_policy-${lower(var.environment)}-scale_down"
    scaling_adjustment      = var.asg_size_scale
    adjustment_type         = var.adjustment_type
    cooldown                = var.default_cooldown
    autoscaling_group_name  = var.autoscaling_group_name != "" ? var.autoscaling_group_name : element(concat(aws_autoscaling_group.asg.*.name, aws_autoscaling_group.asg_prefix.*.name, aws_autoscaling_group.asg_azs.*.name, aws_autoscaling_group.asg_azs_prefix.*.name, [""]), 0)

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on  = [
        aws_autoscaling_group.asg,
        aws_autoscaling_group.asg_prefix,
        aws_autoscaling_group.asg_azs,
        aws_autoscaling_group.asg_azs_prefix
    ]
}
