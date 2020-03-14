#---------------------------------------------------
# Create AWS NLB target group attachment
#---------------------------------------------------
resource "aws_lb_target_group_attachment" "nlb_target_group_attachment" {
    count               = var.enable_nlb_target_group_attachment && length(var.target_ids) > 0 ? length(var.target_ids) : 0

    availability_zone   = var.availability_zone
    target_id           = var.target_ids[count.index]
    port                = var.backend_port
    target_group_arn    = var.target_group_arn != "" ? var.target_group_arn : element(concat(aws_lb_target_group.nlb_target_group.*.arn, [""]), 0)

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on = [
        aws_lb_target_group.nlb_target_group
    ]
}
