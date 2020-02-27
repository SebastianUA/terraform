#---------------------------------------------------
# Create AWS LB listener certificate
#---------------------------------------------------
resource "aws_lb_listener_certificate" "lb_listener_certificate" {
    count               = var.enable_lb_listener_certificate && !var.enable_lb_listener_certificate_prefix ? 1 : 0

    listener_arn        = var.listener_arn
    certificate_arn     = var.certificate_arn

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on = [
        aws_lb.alb,
        aws_lb_target_group_attachment.alb_target_group_attachment,
        aws_lb_target_group.alb_target_group,
        aws_lb_listener.frontend_https
    ]
}

resource "aws_lb_listener_certificate" "lb_listener_certificate_prefix" {
    count               = !var.enable_lb_listener_certificate && var.enable_lb_listener_certificate_prefix ? 1 : 0

    listener_arn        = var.listener_arn
    certificate_arn     = var.certificate_arn

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on = [
        aws_lb.alb_prefix,
        aws_lb_target_group_attachment.alb_target_group_attachment_prefix,
        aws_lb_target_group.alb_target_group_prefix,
        aws_lb_listener.frontend_https_prefix
    ]
}
