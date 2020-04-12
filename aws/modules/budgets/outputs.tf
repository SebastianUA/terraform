#---------------------------------------------------
# AWS budgets budget
#---------------------------------------------------
output "budgets_budget_id" {
    description = "id of resource."
    value       = element(concat(aws_budgets_budget.budgets_budget.*.id, [""]), 0)
}
