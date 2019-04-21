#---------------------------------------------------
# Add newrelic nrql alert condition
#---------------------------------------------------
resource "newrelic_nrql_alert_condition" "nrql_alert_condition" {
    count               = "${var.nrql_alert_condition ? 1 : 0}"
            
    name                = "${var.nrql_alert_condition_name !="" ? var.nrql_alert_condition_name : "${lower(var.name)}-nr-nrql-alert-condition-${lower(var.environment)}" }"
    policy_id           = "${var.nrql_alert_condition_policy_id}"

    runbook_url         = "${var.nrql_alert_condition_runbook_url}"
    enabled             = "${var.nrql_alert_condition_enabled}"
    value_function      = "${var.nrql_alert_condition_value_function}"

    term {
        duration      = "${var.nrql_alert_condition_term_duration}"
        operator      = "${var.nrql_alert_condition_term_operator}"
        priority      = "${var.nrql_alert_condition_term_priority}"
        threshold     = "${var.nrql_alert_condition_term_threshold}"
        time_function = "${var.nrql_alert_condition_term_time_function}"
    }

   # term {
   #     duration      = 5
   #     operator      = "below"
   #     priority      = "warning"
   #     threshold     = "1"
   #     time_function = "all"
   # }
    
    nrql {
        query       = "${var.nrql_alert_condition_nrql_query}"
        since_value = "${var.nrql_alert_condition_nrql_since_value}"
    }

    lifecycle = {
        create_before_destroy   = true,
        ignore_changes          = []
    }

    depends_on  = []
    
}
