#---------------------------------------------------
# Create AWS autoscaling_attachment
#---------------------------------------------------
resource "aws_autoscaling_attachment" "elb_autoscaling_attachment" {
    count                   = upper(var.load_balancer_type) == "ELB" && length(var.load_balancers) > 0 ? 1 : 0

    autoscaling_group_name  = var.autoscaling_group_name != "" ? var.autoscaling_group_name : element(concat(aws_autoscaling_group.asg.*.name, aws_autoscaling_group.asg_prefix.*.name, aws_autoscaling_group.asg_azs.*.name, aws_autoscaling_group.asg_azs_prefix.*.name, [""]), 0)
    elb                     = var.load_balancers

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on              = [
        aws_autoscaling_group.asg,
        aws_autoscaling_group.asg_prefix,
        aws_autoscaling_group.asg_azs,
        aws_autoscaling_group.asg_azs_prefix
    ]
}

resource "aws_autoscaling_attachment" "alb_autoscaling_attachment" {
    count                   = upper(var.load_balancer_type) == "ALB" && length(var.load_balancers) > 0 ? 1 : 0

    autoscaling_group_name  = var.autoscaling_group_name != "" ? var.autoscaling_group_name : element(concat(aws_autoscaling_group.asg.*.name, aws_autoscaling_group.asg_prefix.*.name, aws_autoscaling_group.asg_azs.*.name, aws_autoscaling_group.asg_azs_prefix.*.name, [""]), 0)
    alb_target_group_arn    = var.alb_target_group_arn

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on              = [
        aws_autoscaling_group.asg,
        aws_autoscaling_group.asg_prefix,
        aws_autoscaling_group.asg_azs,
        aws_autoscaling_group.asg_azs_prefix
    ]
}
