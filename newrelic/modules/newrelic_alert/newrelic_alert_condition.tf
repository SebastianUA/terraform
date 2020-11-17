resource "newrelic_alert_condition" "alert_condition" {
  count = var.alert_condition && length(var.alert_condition_entities) > 0 ? 1 : 0

  name      = var.alert_condition_name != "" ? lower(var.alert_condition_name) : "${lower(var.name)}-nr-alert-condition-${var.alert_condition_type}-${lower(var.environment)}"
  policy_id = var.alert_condition_policy_id
  type      = var.alert_condition_type
  entities  = data.newrelic_entity.application[count.index]

  metric = var.alert_condition_metric

  gc_metric                   = var.alert_condition_gc_metric
  violation_close_timer       = var.alert_condition_violation_close_timer
  runbook_url                 = var.alert_condition_runbook_url
  condition_scope             = var.alert_condition_condition_scope
  user_defined_metric         = var.alert_condition_user_defined_metric
  user_defined_value_function = var.alert_condition_user_defined_value_function

  term {
    duration      = var.alert_condition_term_duration
    operator      = var.alert_condition_term_operator
    priority      = var.alert_condition_term_priority
    threshold     = var.alert_condition_term_threshold
    time_function = var.alert_condition_term_time_function
  }

  depends_on = [
    data.newrelic_entity.application
  ]
}

data "newrelic_entity" "application" {
  count = length(var.alert_condition_entities) > 0 ? length(var.alert_condition_entities) : 0

  name = element(var.alert_condition_entities, count.index)
}
