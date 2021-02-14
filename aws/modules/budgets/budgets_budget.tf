#---------------------------------------------------
# AWS budgets budget
#---------------------------------------------------
resource "aws_budgets_budget" "budgets_budget" {
  count = var.enable_budgets_budget ? 1 : 0

  budget_type       = upper(var.budgets_budget_budget_type)
  limit_amount      = var.budgets_budget_limit_amount
  limit_unit        = upper(var.budgets_budget_limit_unit)
  time_period_start = var.budgets_budget_time_period_start
  time_unit         = upper(var.budgets_budget_time_unit)

  name            = var.budgets_budget_name != null && var.budgets_budget_name_prefix == null ? lower(var.budgets_budget_name) : null
  name_prefix     = var.budgets_budget_name_prefix != null && var.budgets_budget_name == null ? lower(var.budgets_budget_name_prefix) : null
  account_id      = var.budgets_budget_account_id
  time_period_end = var.budgets_budget_time_period_end
  cost_filters    = var.budgets_budget_cost_filters

  dynamic "cost_types" {
    iterator = cost_types
    for_each = var.budgets_budget_cost_types
    content {
      include_credit             = lookup(cost_types.value, "include_credit", true)
      include_discount           = lookup(cost_types.value, "include_discount", true)
      include_other_subscription = lookup(cost_types.value, "include_other_subscription", true)
      include_recurring          = lookup(cost_types.value, "include_recurring", true)
      include_refund             = lookup(cost_types.value, "include_refund", true)
      include_subscription       = lookup(cost_types.value, "include_subscription", true)
      include_support            = lookup(cost_types.value, "include_support", true)
      include_tax                = lookup(cost_types.value, "include_tax", true)
      include_upfront            = lookup(cost_types.value, "include_upfront", true)
      use_amortized              = lookup(cost_types.value, "use_amortized", false)
      use_blended                = lookup(cost_types.value, "use_blended", false)
    }
  }

  dynamic "notification" {
    iterator = notification
    for_each = var.budgets_budget_notification
    content {
      comparison_operator = lookup(notification.value, "comparison_operator", "GREATER_THAN")
      threshold           = lookup(notification.value, "threshold", 100)
      threshold_type      = lookup(notification.value, "threshold_type", "PERCENTAGE")
      notification_type   = lookup(notification.value, "notification_type", "FORECASTED")

      subscriber_email_addresses = lookup(notification.value, "subscriber_email_addresses", null)
      subscriber_sns_topic_arns  = lookup(notification.value, "subscriber_sns_topic_arns", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
