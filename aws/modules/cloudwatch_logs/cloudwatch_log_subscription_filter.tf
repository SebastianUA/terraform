#---------------------------------------------------
# AWS CloudWatch LOG subscription filter
#---------------------------------------------------
resource "aws_cloudwatch_log_subscription_filter" "cw_log_subscription_filter" {
  count = var.enable_cw_log_subscription_filter ? 1 : 0

  name            = var.cw_log_subscription_filter_name != "" ? var.cw_log_subscription_filter_name : "${lower(var.name)}-subscription-filter-${lower(var.environment)}"
  destination_arn = var.cw_log_subscription_filter_destination_arn
  filter_pattern  = var.cw_log_subscription_filter_filter_pattern
  log_group_name  = var.cw_log_subscription_filter_log_group_name

  role_arn     = var.cw_log_subscription_filter_role_arn
  distribution = var.cw_log_subscription_filter_distribution

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
