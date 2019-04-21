#-----------------------------------------------------------
# newrelic_dashboard
#-----------------------------------------------------------
output "newrelic_dashboard_id" {
    description = "ID for newrelic_dashboard"
    value       = "${newrelic_dashboard.dashboard.*.id}"
}

output "newrelic_dashboard_custom_id" {
    description = "ID for dashboard_custom"
    value       = "${newrelic_dashboard.dashboard_custom.*.id}"
}

