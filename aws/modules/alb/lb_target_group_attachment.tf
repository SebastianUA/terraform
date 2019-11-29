#---------------------------------------------------
# Create AWS LB target group attachment
#---------------------------------------------------
resource "aws_lb_target_group_attachment" "alb_target_group_attachment" {
    count               = var.alb_target_group_attachment && !var.alb_target_group_attachment_prefix && length(var.target_ids) > 0 ? length(var.target_ids) : 0
                                    
    #availability_zone   = "all"
    target_group_arn    = "aws_lb_target_group.alb_target_group.arn"
    target_id           = var.target_ids[count.index]
    port                = var.backend_port

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on = [
        aws_lb_target_group.alb_target_group
    ]
}

resource "aws_lb_target_group_attachment" "alb_target_group_attachment_prefix" {
    count               = var.alb_target_group_attachment_prefix && !var.alb_target_group_attachment && length(var.target_ids) > 0 ? length(var.target_ids) : 0
                                    
    #availability_zone   = "all"
    target_group_arn    = "aws_lb_target_group.alb_target_group_prefix.arn"
    target_id           = var.target_ids[count.index]
    port                = var.backend_port

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on = [
        aws_lb_target_group.alb_target_group_prefix
    ]
}