resource "newrelic_alert_policy" "alert_policy" {
    count   = "${var.alert_policy ? 1 : 0}"

    name    = "${var.alert_policy_name !="" ? "${lower(var.alert_policy_name)}" : "${lower(var.name)}-nr-policy-${lower(var.alert_policy_incident_preference)}-${lower(var.environment)}" }"
    incident_preference = "${var.alert_policy_incident_preference}"

    lifecycle = {
        create_before_destroy   = true,
        ignore_changes          = []
    }

    depends_on  = []
}

resource "newrelic_alert_policy" "simple_default" {
    count   = "${var.alert_policy && var.alert_policy_simple_default ? 1 : 0}"
                        
    name    = "${var.alert_policy_simple_default_name !="" ? "${lower(var.alert_policy_simple_default_name)}" : "simple-default-nr-policy-${lower(var.alert_policy_incident_preference)}-${lower(var.environment)}" }"
    lifecycle = {
        create_before_destroy   = true,
        ignore_changes          = []
    }

    depends_on  = []
}
