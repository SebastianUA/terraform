# Work with newrelic infra via terraform

A terraform module for making newrelic infra.
 
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

module "newrelic_infra" {
    source                                              = "../../modules/newrelic_infra"

    infra_alert_condition                               = "true"
    infra_alert_condition_policy_id                     = "${element(module.newrelic_alert.alert_policy_id, 0)}"
    infra_alert_condition_type                          = "infra_metric"
    infra_alert_condition_event                         = "StorageSample"
    infra_alert_condition_select                        = "diskUsedPercent"
    infra_alert_condition_comparison                    = "equal"
    infra_alert_condition_where                         = "(`hostname` LIKE '%frontend%')"
    infra_alert_condition_integration_provider          = ""
    
    #
    infra_alert_condition_with_warning                  = "true"    
}                                                                             

```

Module Input Variables
----------------------
- `name` - The name for newrelic_alert resources (`default     = "test"`).
- `environment` - environment (`default     = "prod"`).
- `infra_alert_condition` - Enable newrelic_infra_alert_condition (`default     = "false"`).
- `infra_alert_condition_policy_id` - (Required) The ID of the alert policy where this condition should be used. (`default     = ""`).
- `infra_alert_condition_name` - (Required) The Infrastructure alert condition's name. (`default     = ""`).
- `infra_alert_condition_type` - (Required) The type of Infrastructure alert condition: 'infra_process_running', 'infra_metric', or 'infra_host_not_reporting'. (`default     = "infra_metric"`).
- `infra_alert_condition_event` - (Required) The metric event; for example, system metrics, process metrics, storage metrics, or network metrics. (`default     = ""`).
- `infra_alert_condition_select` - (Required) The attribute name to identify the type of metric condition; for example, 'network', 'process', 'system', or 'storage' (`default     = "system"`).
- `infra_alert_condition_comparison` - (Required) The operator used to evaluate the threshold value; 'above', 'below', 'equal'. (`default     = "equal"`).
- `infra_alert_condition_enabled` - (Optional) Set whether to enable the alert condition. Defaults to true. (`default     = "true"`).
- `infra_alert_condition_where` - (Optional) Infrastructure host filter for the alert condition. (`default     = ""`).
- `infra_alert_condition_process_where` - (Optional) Any filters applied to processes; for example: commandName = 'java'. (`default     = ""`).
- `infra_alert_condition_integration_provider` - (Optional) For alerts on integrations, use this instead of event. (`default     = ""`).
- `infra_alert_condition_critical_duration` - (Required) Identifies the number of minutes the threshold must be passed or met for the alert to trigger. Threshold durations must be between 1 and 60 minutes (inclusive). (`default     = 1`).
- `infra_alert_condition_critical_value` - (Optional) Threshold value, computed against the comparison operator. Supported by 'infra_metric' and 'infra_process_running' alert condition types. (`default     = 1`).
- `infra_alert_condition_critical_time_function` - (Optional) Indicates if the condition needs to be sustained or to just break the threshold once; all or any. Supported by the 'infra_metric' alert condition type. (`default     = "all"`).
- `infra_alert_condition_with_warning` - Enable newrelic_infra_alert_condition with warning usage (`default     = "false"`).
- `infra_alert_condition_warning_duration` - (Required) Identifies the number of minutes the threshold must be passed or met for the alert to trigger. Threshold durations must be between 1 and 60 minutes (inclusive). (`default     = 1`).
- `infra_alert_condition_warning_value` - (Optional) Threshold value, computed against the comparison operator. Supported by 'infra_metric' and 'infra_process_running' alert condition types. (`default     = 1`).
- `infra_alert_condition_warning_time_function` - (Optional) Indicates if the condition needs to be sustained or to just break the threshold once; all or any. Supported by the 'infra_metric' alert condition type. (`default     = "all"`).



Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See LICENSE for full details.

