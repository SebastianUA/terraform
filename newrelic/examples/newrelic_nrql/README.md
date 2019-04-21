# Work with newrelic nrql via terraform

A terraform module for making newrelic nrql.
 
## Usage
--------

Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.11.11"
}

provider "newrelic" {
    api_key = "75e6741e6326cce1666ecfb94c3c0b8fdf"
}

module "newrelic_alert" {
    source                                              = "../../modules/newrelic_alert"

    # vars for newrelic_alert_policy
    alert_policy                                        = "true"
    #alert_policy_name                                  = "new-relic-policy-PER_CONDITION"
    alert_policy_incident_preference                    = "PER_CONDITION"
    alert_policy_simple_default                         = "true"

    alert_channel                                       = "true"
    #
    alert_channel_slack                                 = "true"
    alert_channel_slack_configuration_channel           = "new-relic"
    alert_channel_slack_configuration_url               = "https://hooks.slack.com/services/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666"
    #
    alert_condition                                     = "true"
    alert_condition_policy_id                           = "${element(module.newrelic_alert.alert_policy_id, 0)}"
    #alert_condition_policy_id                           = "${element(module.newrelic_alert.simple_default_alert_policy_id, 0)}"
    alert_condition_type                                = "apm_app_metric"
    alert_condition_entities                            = ["PHP Application"]

    alert_policy_channel                                = "false"
}

module "newrelic_nrql" {
    source                                              = "../../modules/newrelic_nrql"

    nrql_alert_condition                                = "true"
    nrql_alert_condition_policy_id                      = "${element(module.newrelic_alert.alert_policy_id, 0)}"

    nrql_alert_condition_nrql_query                     = "SELECT count(*) FROM SyntheticCheck WHERE monitorId = '1'"
    
}                                                       
```

Module Input Variables
----------------------
- `name` - The name for newrelic_alert resources  (`default  = "test"`).
- `environment` - environment  (`default = "prod"`).
- `nrql_alert_condition` - Enable newrelic_nrql_alert_condition  (`default = "false"`).
- `nrql_alert_condition_name` - (Required) The title of the condition  (`default = ""`).
- `nrql_alert_condition_policy_id` - (Required) The ID of the policy where this condition should be used.  (`default = ""`).
- `nrql_alert_condition_runbook_url` - (Optional) Runbook URL to display in notifications.  (`default = ""`).
- `nrql_alert_condition_enabled` - (Optional) Set whether to enable the alert condition. Defaults to true.  (`default = "true"`).
- `nrql_alert_condition_value_function` - (Optional) Possible values are single_value, sum.  (`default = "single_value"`).
- `nrql_alert_condition_term_duration` - (Required) In minutes, must be: 1, 2, 3, 4, 5, 10, 15, 30, 60, or 120.  (`default = 5`).
- `nrql_alert_condition_term_operator` - (Optional) above, below, or equal. Defaults to equal.  (`default = "equal"`).
- `nrql_alert_condition_term_priority` - (Optional) critical or warning. Defaults to critical.  (`default = "critical"`).
- `nrql_alert_condition_term_threshold` - (Required) Must be 0 or greater.  (`default = 0`).
- `nrql_alert_condition_term_time_function` - (Required) all or any.  (`default = "all"`).
- `nrql_alert_condition_nrql_query` - (Required) The NRQL query to execute for the condition.  (`default = ""`).
- `nrql_alert_condition_nrql_since_value` - (Required) The value to be used in the SINCE <X> MINUTES AGO clause for the NRQL query. Must be: 1, 2, 3, 4, or 5.  (`default = 1`).


Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See LICENSE for full details.

