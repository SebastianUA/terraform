#---------------------------------------------------
# Create AWS autoscaling_attachment
#---------------------------------------------------
resource "aws_autoscaling_attachment" "elb_autoscaling_attachment" {
    count                   = "${upper(var.load_balancer_type) == "ELB" && length(var.load_balancers) > 0 ? 1 : 0}"
    autoscaling_group_name  = "${var.autoscaling_group_name}"

    elb                     = "${var.load_balancers}"

    lifecycle {
        create_before_destroy   = true,
        ignore_changes          = [],
    }

    depends_on  = []
}

resource "aws_autoscaling_attachment" "alb_autoscaling_attachment" {
    count                   = "${upper(var.load_balancer_type) == "ALB" && length(var.load_balancers) > 0 ? 1 : 0}"
    autoscaling_group_name  = "${var.autoscaling_group_name}"
    alb_target_group_arn    = "${var.load_balancers}"

    lifecycle {
        create_before_destroy   = true,
        ignore_changes          = [],
    }
    
    depends_on  = []
}