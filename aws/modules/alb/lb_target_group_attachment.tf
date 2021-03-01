#---------------------------------------------------
# AWS LB target group attachment
#---------------------------------------------------
resource "aws_lb_target_group_attachment" "alb_target_group_attachment" {
  count = var.enable_alb_target_group_attachment && length(var.alb_target_group_attachment_target_ids) > 0 ? length(var.alb_target_group_attachment_target_ids) : 0

  target_group_arn = var.alb_target_group_attachment_target_group_arn != "" && !var.enable_alb_target_group ? var.alb_target_group_attachment_target_group_arn : aws_lb_target_group.alb_target_group[0].arn
  target_id        = var.alb_target_group_attachment_target_ids[count.index]

  availability_zone = var.alb_target_group_attachment_availability_zone
  port              = var.alb_target_group_attachment_port

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_lb_target_group.alb_target_group
  ]
}
