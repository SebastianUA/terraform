#-----------------------------------------------------------
# newrelic_dashboard
#-----------------------------------------------------------
output "newrelic_dashboard_id" {
    description = "ID for newrelic_dashboard"
    value       = element(concat(newrelic_dashboard.dashboard.*.id, [""]), 0)
}

output "newrelic_dashboard_custom_id" {
    description = "ID for dashboard_custom"
    value       = element(concat(newrelic_dashboard.dashboard_custom.*.id, [""]), 0)
}
