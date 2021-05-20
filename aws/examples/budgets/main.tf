#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.15"
}

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "budgets" {
  source = "../../modules/budgets"

  enable_budgets_budget            = true
  budgets_budget_name              = "my-budget"
  budgets_budget_budget_type       = "COST"
  budgets_budget_limit_amount      = 1
  budgets_budget_limit_unit        = "USD"
  budgets_budget_time_period_start = "2017-07-01_00:00"
  budgets_budget_time_period_end   = "2087-06-15_00:00"
  budgets_budget_time_unit         = "MONTHLY"

  budgets_budget_cost_types = [{
    include_credit             = false
    include_discount           = false
    include_other_subscription = false
    include_recurring          = false
    include_refund             = false
    include_subscription       = true
    include_support            = false
    include_tax                = false
    include_upfront            = false
    use_amortized              = false
    use_blended                = false
  }]

  budgets_budget_cost_filters = {
    AZ            = ""
    LinkedAccount = ""
    Operation     = ""
    PurchaseType  = ""
    Service       = ""
    TagKeyValue   = ""

  }

  budgets_budget_notification = [{
    comparison_operator        = "GREATER_THAN"
    threshold                  = 100
    threshold_type             = "PERCENTAGE"
    notification_type          = "FORECASTED"
    subscriber_email_addresses = ["test@linux-notes.org"]
    subscriber_sns_topic_arns  = []
  }]
}
