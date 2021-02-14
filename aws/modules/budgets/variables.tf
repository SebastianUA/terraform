#---------------------------------------------------
# AWS budgets budget
#---------------------------------------------------
variable "enable_budgets_budget" {
  description = "Enable budgets budget usage"
  default     = false
}

variable "budgets_budget_budget_type" {
  description = "(Required) Whether this budget tracks monetary cost or usage."
  default     = "COST"
}

variable "budgets_budget_limit_amount" {
  description = "(Required) The amount of cost or usage being measured for a budget."
  default     = 10
}

variable "budgets_budget_limit_unit" {
  description = "(Required) The unit of measurement used for the budget forecast, actual spend, or budget threshold, such as dollars or GB. See Spend documentation."
  default     = "USD"
}

variable "budgets_budget_time_period_start" {
  description = "(Required) The start of the time period covered by the budget. The start date must come before the end date. Format: 2017-01-01_12:00."
  default     = "2020-01-01_12:00"
}

variable "budgets_budget_time_unit" {
  description = "(Required) The length of time until a budget resets the actual and forecasted spend. Valid values: MONTHLY, QUARTERLY, ANNUALLY"
  default     = "MONTHLY"
}

variable "budgets_budget_name" {
  description = "(Optional) The name of a budget. Unique within accounts."
  default     = null
}

variable "budgets_budget_name_prefix" {
  description = "(Optional) The prefix of the name of a budget. Unique within accounts."
  default     = null
}

variable "budgets_budget_account_id" {
  description = "(Optional) The ID of the target account for budget. Will use current user's account_id by default if omitted."
  default     = null
}

variable "budgets_budget_time_period_end" {
  description = "(Optional) The end of the time period covered by the budget. There are no restrictions on the end date. Format: 2017-01-01_12:00"
  default     = null
}

variable "budgets_budget_cost_types" {
  description = "(Optional) Object containing CostTypes The types of cost included in a budget, such as tax and subscriptions.."
  default     = []
}

variable "budgets_budget_cost_filters" {
  description = "(Optional) Map of CostFilters key/value pairs to apply to the budget."
  default     = null
}

variable "budgets_budget_notification" {
  description = "(Optional) Object containing Budget Notifications. Can be used multiple times to define more than one budget notification"
  default     = []
}
