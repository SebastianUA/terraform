# Work with BUDGETS via terraform

A terraform module for making BUDGETS.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 1.0"
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

```

## Module Input Variables
----------------------
- `enable_budgets_budget` - Enable budgets budget usage (`default = False`)
- `budgets_budget_budget_type` - (Required) Whether this budget tracks monetary cost or usage. (`default = COST`)
- `budgets_budget_limit_amount` - (Required) The amount of cost or usage being measured for a budget. (`default = 10`)
- `budgets_budget_limit_unit` - (Required) The unit of measurement used for the budget forecast, actual spend, or budget threshold, such as dollars or GB. See Spend documentation. (`default = USD`)
- `budgets_budget_time_period_start` - (Required) The start of the time period covered by the budget. The start date must come before the end date. Format: 2017-01-01_12:00. (`default = 2020-01-01_12:00`)
- `budgets_budget_time_unit` - (Required) The length of time until a budget resets the actual and forecasted spend. Valid values: MONTHLY, QUARTERLY, ANNUALLY (`default = MONTHLY`)
- `budgets_budget_name` - (Optional) The name of a budget. Unique within accounts. (`default = null`)
- `budgets_budget_name_prefix` - (Optional) The prefix of the name of a budget. Unique within accounts. (`default = null`)
- `budgets_budget_account_id` - (Optional) The ID of the target account for budget. Will use current user's account_id by default if omitted. (`default = null`)
- `budgets_budget_time_period_end` - (Optional) The end of the time period covered by the budget. There are no restrictions on the end date. Format: 2017-01-01_12:00 (`default = null`)
- `budgets_budget_cost_types` - (Optional) Object containing CostTypes The types of cost included in a budget, such as tax and subscriptions.. (`default = []`)
- `budgets_budget_cost_filters` - (Optional) Map of CostFilters key/value pairs to apply to the budget. (`default = null`)
- `budgets_budget_notification` - (Optional) Object containing Budget Notifications. Can be used multiple times to define more than one budget notification (`default = []`)

## Module Output Variables
----------------------
- `budgets_budget_id` - id of resource.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
