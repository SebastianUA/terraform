#---------------------------------------------------
# Add newrelic infra alert condition
#---------------------------------------------------
resource "newrelic_infra_alert_condition" "infra_alert_condition" {
    count                   = "${var.infra_alert_condition && !var.infra_alert_condition_with_warning ? 1 : 0}"
            
    policy_id               = "${var.infra_alert_condition_policy_id}"
    name                    = "${var.infra_alert_condition_name !="" ? "${lower(var.infra_alert_condition_name)}" : "${var.name}-infra-alert-condition-${lower(var.environment)}" }"
    type                    = "${var.infra_alert_condition_type}"
    event                   = "${var.infra_alert_condition_event}"
    select                  = "${var.infra_alert_condition_select}"
    comparison              = "${var.infra_alert_condition_comparison}"

    enabled                 = "${var.infra_alert_condition_enabled}"
    where                   = "${var.infra_alert_condition_where}"
    process_where           = "${var.infra_alert_condition_process_where}"
    integration_provider    = "${var.infra_alert_condition_integration_provider}"
    
    critical {
        duration      = "${var.infra_alert_condition_critical_duration}"
        value         = "${var.infra_alert_condition_critical_value}"
        time_function = "${var.infra_alert_condition_critical_time_function}"
    }
    
    lifecycle = {
        create_before_destroy   = true,
        ignore_changes          = []
    }

    depends_on  = []
}

#---------------------------------------------------
# Add newrelic infra alert condition with warning
#---------------------------------------------------
resource "newrelic_infra_alert_condition" "infra_alert_condition_with_warning" {
    count                   = "${var.infra_alert_condition && var.infra_alert_condition_with_warning ? 1 : 0}"

    policy_id               = "${var.infra_alert_condition_policy_id}"
    name                    = "${var.infra_alert_condition_name !="" ? "${lower(var.infra_alert_condition_name)}" : "${var.name}-infra-alert-condition-${lower(var.environment)}" }"
    type                    = "${var.infra_alert_condition_type}"
    event                   = "${var.infra_alert_condition_event}"
    select                  = "${var.infra_alert_condition_select}"
    comparison              = "${var.infra_alert_condition_comparison}"

    enabled                 = "${var.infra_alert_condition_enabled}"
    where                   = "${var.infra_alert_condition_where}"
    process_where           = "${var.infra_alert_condition_process_where}"
    integration_provider    = "${var.infra_alert_condition_integration_provider}"

    critical {
        duration      = "${var.infra_alert_condition_critical_duration}"
        value         = "${var.infra_alert_condition_critical_value}"
        time_function = "${var.infra_alert_condition_critical_time_function}"
    }

    warning {
        duration      = "${var.infra_alert_condition_warning_duration}"
        value         = "${var.infra_alert_condition_warning_value}"
        time_function = "${var.infra_alert_condition_warning_time_function}"
    }

    lifecycle = {
        create_before_destroy   = true,
        ignore_changes          = []
    }

    depends_on  = []
}

