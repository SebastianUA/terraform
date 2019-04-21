#-----------------------------------------------------------
# newrelic_nrql_alert_condition
#-----------------------------------------------------------
output "nrql_alert_condition_id" {
    description = "ID for newrelic_nrql_alert_condition"
    value       = "${newrelic_nrql_alert_condition.nrql_alert_condition.*.id}"
}
