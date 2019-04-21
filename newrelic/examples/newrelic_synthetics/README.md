# Work with newrelic synthetics via terraform

A terraform module for making newrelic synthetics.
 
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

module "newrelic_synthetics" {
    source                                              = "../../modules/newrelic_synthetics"

    synthetics_alert_condition                          = "true"
    synthetics_alert_condition_policy_id                = "${element(module.newrelic_alert.alert_policy_id, 0)}"
    synthetics_alert_condition_name                     = "test"
    synthetics_monitor_name                             = "linux-notes" 
}                                                       
```

Module Input Variables
----------------------
- `name` - The name for newrelic_alert resources (`default     = "test"`).
- `environment` - environment (`default     = "prod"`).
- `synthetics_alert_condition` - Enable synthetics_alert_condition (`default     = "false"`).
- `synthetics_alert_condition_name` - (Required) The title of the condition (`default     = ""`).
- `synthetics_alert_condition_policy_id` - (Required) The ID of the policy where this condition should be used. (`default     = ""`).
- `synthetics_monitor_name` -  (Required) The title of this condition. (`default     = ""`).
- `synthetics_alert_condition_runbook_url` - (Optional) Runbook URL to display in notifications. (`default     = ""`).
- `synthetics_alert_condition_enabled` - (Optional) Set whether to enable the alert condition. Defaults to true. (`default     = "true"`).



Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See LICENSE for full details.

