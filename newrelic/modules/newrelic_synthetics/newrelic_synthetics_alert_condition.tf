#---------------------------------------------------
# Add newrelic synthetics alert condition
#---------------------------------------------------
resource "newrelic_synthetics_alert_condition" "synthetics_alert_condition" {
    count           = "${var.synthetics_alert_condition ? 1 : 0}"      
                
    policy_id       = "${var.synthetics_alert_condition_policy_id}"
    name            = "${var.synthetics_alert_condition_name !="" ? "${lower(var.synthetics_alert_condition_name)}" : "${lower(var.name)}-nr-synthetics-alert-condition-${lower(var.environment)}" }"
    monitor_id      = "${data.newrelic_synthetics_monitor.synthetics_monitor.id}"

    runbook_url     = "${var.synthetics_alert_condition_runbook_url}"
    enabled         = "${var.synthetics_alert_condition_enabled}"

    lifecycle = {
        create_before_destroy   = true,
        ignore_changes          = []
    }

    depends_on  = ["data.newrelic_synthetics_monitor.synthetics_monitor"]    

}

data "newrelic_synthetics_monitor" "synthetics_monitor" {
    name            = "${var.synthetics_monitor_name !="" && var.synthetics_alert_condition ? "${lower(var.synthetics_monitor_name)}" : "${lower(var.name)}-nr-synthetics-monitor-${lower(var.environment)}" }"
}
