#---------------------------------------------------
# AWS ASG tag
#---------------------------------------------------
resource "aws_autoscaling_group_tag" "asg_tag" {
  count = var.enable_asg_tag ? length(var.asg_tag_autoscaling_group_name) : 0

  autoscaling_group_name = var.asg_tag_autoscaling_group_name

  dynamic "tag" {
    iterator = tag
    for_each = var.asg_tag_tags

    content {
      key                 = lookup(tag.value, "key", null)
      value               = lookup(tag.value, "value", null)
      propagate_at_launch = lookup(tag.value, "propagate_at_launch", null)
    }
  }

  lifecycle {
    create_before_destroy = false
    ignore_changes        = []
  }

  depends_on = []
}