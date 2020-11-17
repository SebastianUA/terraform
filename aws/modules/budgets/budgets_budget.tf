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

  dynamic "cost_types" {
    iterator = costtypes
    for_each = var.budgets_budget_cost_types
    content {
      include_credit             = lookup(costtypes.value, "include_credit", true)
      include_discount           = lookup(costtypes.value, "include_discount", true)
      include_other_subscription = lookup(costtypes.value, "include_other_subscription", true)
      include_recurring          = lookup(costtypes.value, "include_recurring", true)
      include_refund             = lookup(costtypes.value, "include_refund", true)
      include_subscription       = lookup(costtypes.value, "include_subscription", true)
      include_support            = lookup(costtypes.value, "include_support", true)
      include_tax                = lookup(costtypes.value, "include_tax", true)
      include_upfront            = lookup(costtypes.value, "include_upfront", true)
      use_amortized              = lookup(costtypes.value, "use_amortized", false)
      use_blended                = lookup(costtypes.value, "use_blended", false)
    }
  }

  # dynamic "cost_filters" {
  #     iterator = costfilters
  #     for_each = var.budgets_budget_cost_filters
  #     content {
  #         AZ              = lookup(costfilters.value, "AZ", null)
  #         LinkedAccount   = lookup(costfilters.value, "LinkedAccount", null)
  #         Operation       = lookup(costfilters.value, "Operation", null)
  #         PurchaseType    = lookup(costfilters.value, "PurchaseType", null)
  #         Service         = lookup(costfilters.value, "Service", null)
  #         TagKeyValue     = lookup(costfilters.value, "TagKeyValue", null)
  #     }
  # }

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
