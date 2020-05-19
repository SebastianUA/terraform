#---------------------------------------------------
# Create AWS autoscaling_notification
#---------------------------------------------------
resource "aws_autoscaling_notification" "autoscaling_notification" {
  count = var.enable_autoscaling_notification && length(var.autoscaling_notification_topic_arn) > 0 ? 1 : 0

  group_names   = data.aws_autoscaling_groups.autoscaling_notification.names
  notifications = var.autoscaling_notification_notifications
  topic_arn     = var.autoscaling_notification_topic_arn

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    data.aws_autoscaling_groups.autoscaling_notification
  ]
}

data "aws_autoscaling_groups" "autoscaling_notification" {
  dynamic "filter" {
    for_each = var.autoscaling_groups_filter
    content {
      name   = lookup(autoscaling_groups_filter.value, "name", null)
      values = lookup(autoscaling_groups_filter.value, "values", null)
    }
  }
}
