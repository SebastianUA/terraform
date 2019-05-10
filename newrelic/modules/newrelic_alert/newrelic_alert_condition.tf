resource "newrelic_alert_condition" "alert_condition" {
    count                       = "${var.alert_condition? 1 : 0}"
                            
    name                        = "${var.alert_condition_name !="" ? "${lower(var.alert_condition_name)}" : "${lower(var.name)}-nr-alert-condition-${var.alert_condition_type}-${lower(var.environment)}" }"
    policy_id                   = "${var.alert_condition_policy_id}"
    type                        = "${var.alert_condition_type}"
    entities                    = ["${data.newrelic_application.application.id}"]
    metric                      = "${var.alert_condition_metric}"

    gc_metric                   = "${var.alert_condition_gc_metric}"
    violation_close_timer       = "${var.alert_condition_violation_close_timer}"
    runbook_url                 = "${var.alert_condition_runbook_url}"
    condition_scope             = "${var.alert_condition_condition_scope}"
    user_defined_metric         = "${var.alert_condition_user_defined_metric}"
    user_defined_value_function = "${var.alert_condition_user_defined_value_function}"

    term {
        duration      = "${var.alert_condition_term_duration}"
        operator      = "${var.alert_condition_term_operator}"
        priority      = "${var.alert_condition_term_priority}"
        threshold     = "${var.alert_condition_term_threshold}"
        time_function = "${var.alert_condition_term_time_function}"
    }

    lifecycle = {
        create_before_destroy   = true,
        # I think, newrelic provider has a bug. To fix it, I have added the next ignoring changes.
        # Note: If you're changing those values, please use `terraform destroy` and `terraform plan && terraform apply` to update all your values.
        ignore_changes          = ["gc_metric", "user_defined_value_function", "violation_close_timer", "condition_scope", "entities"]
    }

    depends_on  = ["data.newrelic_application.application"]
    
}

data "newrelic_application" "application" {
    count   = "${length(var.alert_condition_entities) >0 ? 1 : 0}"

    name    = "${var.alert_condition_entities[count.index]}"
}
