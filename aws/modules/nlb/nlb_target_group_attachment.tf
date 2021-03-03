#---------------------------------------------------
# AWS NLB target group attachment
#---------------------------------------------------
resource "aws_lb_target_group_attachment" "nlb_target_group_attachment" {
  count = var.enable_nlb_target_group_attachment && length(var.nlb_target_group_attachment_target_ids) > 0 ? length(var.nlb_target_group_attachment_target_ids) : 0

  availability_zone = var.nlb_target_group_attachment_availability_zone
  target_id         = var.nlb_target_group_attachment_target_ids[count.index]
  port              = var.nlb_target_group_attachment_port
  target_group_arn  = var.nlb_target_group_attachment_target_group_arn != "" ? var.nlb_target_group_attachment_target_group_arn : (var.enable_nlb_target_group ? element(aws_lb_target_group.nlb_target_group.*.arn, 0) : null)

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_lb_target_group.nlb_target_group
  ]
}
