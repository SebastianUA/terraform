#-----------------------------------------------------------
# newrelic_infra_alert_condition
#-----------------------------------------------------------
output "infra_alert_condition_id" {
  description = "ID for newrelic_nrql_alert_condition"
  value       = element(concat(newrelic_infra_alert_condition.infra_alert_condition.*.id, [""]), 0)
}

output "infra_alert_condition__with_warning_id" {
  description = "ID for newrelic_nrql_alert_condition"
  value       = element(concat(newrelic_infra_alert_condition.infra_alert_condition_with_warning.*.id, [""]), 0)
}
