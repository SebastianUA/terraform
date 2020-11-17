#---------------------------------------------------
# Add newrelic nrql alert condition
#---------------------------------------------------
resource "newrelic_nrql_alert_condition" "nrql_alert_condition" {
  count = var.nrql_alert_condition ? 1 : 0

  name      = var.nrql_alert_condition_name != "" ? var.nrql_alert_condition_name : "${lower(var.name)}-nr-nrql-alert-condition-${lower(var.environment)}"
  policy_id = var.nrql_alert_condition_policy_id

  runbook_url          = var.nrql_alert_condition_runbook_url
  enabled              = var.nrql_alert_condition_enabled
  value_function       = var.nrql_alert_condition_value_function
  violation_time_limit = "ONE_HOUR"
  # [ONE_HOUR TWO_HOURS FOUR_HOURS EIGHT_HOURS TWELVE_HOURS TWENTY_FOUR_HOURS THIRTY_DAYS]
  violation_time_limit_seconds = null

  warning {
    threshold_duration    = var.nrql_alert_condition_term_duration
    operator              = var.nrql_alert_condition_term_operator
    threshold             = var.nrql_alert_condition_term_threshold
    threshold_occurrences = var.nrql_alert_condition_term_time_function
  }

  critical {
    threshold_duration    = 60
    operator              = "below"
    threshold             = 1
    threshold_occurrences = "all"
  }

  nrql {
    query       = var.nrql_alert_condition_nrql_query
    since_value = var.nrql_alert_condition_nrql_since_value
  }

  depends_on = []
}
