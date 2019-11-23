#---------------------------------------------------
# Add autoscaling policy rules
#---------------------------------------------------
resource "aws_autoscaling_policy" "scale_up" {
    count                   = "${var.enable_autoscaling_policy ? 1 : 0}"
    
    name                    = "${var.name}-asg_policy-${var.environment}-scale_up"
    scaling_adjustment      = "${var.asg_size_scale}"
    adjustment_type         = "${var.adjustment_type}"
    cooldown                = "${var.default_cooldown}"
    autoscaling_group_name  = "${var.autoscaling_group_name}"

    lifecycle {
        create_before_destroy   = true,
        ignore_changes          = [],
    }   

    depends_on  = []
}

resource "aws_autoscaling_policy" "scale_down" {
    count                   = "${var.enable_autoscaling_policy ? 1 : 0}"
    
    name                    = "${var.name}-asg_policy-${var.environment}-scale_down"
    scaling_adjustment      = "-${var.asg_size_scale}"
    adjustment_type         = "${var.adjustment_type}"
    cooldown                = "${var.default_cooldown}"
    autoscaling_group_name  = "${var.autoscaling_group_name}"

    lifecycle {
        create_before_destroy   = true,
        ignore_changes          = [],
    }   

    depends_on  = []
}