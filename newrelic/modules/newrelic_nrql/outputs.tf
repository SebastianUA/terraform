#-----------------------------------------------------------
# newrelic_nrql_alert_condition
#-----------------------------------------------------------
output "nrql_alert_condition_id" {
  description = "ID for newrelic_nrql_alert_condition"
  value       = element(concat(newrelic_nrql_alert_condition.nrql_alert_condition.*.id, [""]), 0)
}
