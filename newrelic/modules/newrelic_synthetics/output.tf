#-----------------------------------------------------------
# newrelic_nrql_alert_condition
#-----------------------------------------------------------
output "newrelic_synthetics_alert_condition_id" {
    description = "ID for newrelic_synthetics_alert_condition"
    value       = "${newrelic_synthetics_alert_condition.synthetics_alert_condition.*.id}"
}
