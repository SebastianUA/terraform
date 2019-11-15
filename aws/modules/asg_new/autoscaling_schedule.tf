#---------------------------------------------------
# ASW ASG Scale-up/Scale-down
#---------------------------------------------------
resource "aws_autoscaling_schedule" "scale_out_during_business_hours" {
    count                   = "${var.enable_autoscaling_schedule ? 1 : 0}"
    
    scheduled_action_name   = "scale-out-during-business-hours"
    min_size                = "${var.asg_min_size}"
    max_size                = "${var.asg_size_scale}"
    desired_capacity        = "${var.asg_size_scale}"
    recurrence              = "${var.asg_recurrence_scale_up}"
    autoscaling_group_name  = "${var.autoscaling_group_name}"

    lifecycle {
        create_before_destroy   = true,
        ignore_changes          = [],
    }

    depends_on              = []
}

resource "aws_autoscaling_schedule" "scale_in_at_night" {
    count                   = "${var.enable_autoscaling_schedule ? 1 : 0}"
    
    scheduled_action_name   = "scale-in-at-night"
    min_size                = "${var.asg_min_size}"
    max_size                = "${var.asg_size_scale}"
    desired_capacity        = "${var.asg_min_size}"
    recurrence              = "${var.asg_recurrence_scale_down}"
    autoscaling_group_name  = "${var.autoscaling_group_name}"

    lifecycle {
        create_before_destroy   = true,
        ignore_changes          = [],
    }

    depends_on              = []
}
