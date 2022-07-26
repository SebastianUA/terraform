# Work with NEWRELIC_SYNTHETICS via terraform

A terraform module for making NEWRELIC_SYNTHETICS.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.13"
}

provider "newrelic" {
  api_key    = "api_key"
  account_id = "account_id"
}

module "newrelic_alert" {
  source = "../../modules/newrelic_alert"

  # vars for newrelic_alert_policy
  alert_policy = true
  #alert_policy_name                                  = "new-relic-policy-PER_CONDITION"
  alert_policy_incident_preference = "PER_CONDITION"
  alert_policy_simple_default      = true

  alert_channel = true
  #
  alert_channel_slack = true
  #
  alert_condition           = true
  alert_condition_policy_id = element(module.newrelic_alert.alert_policy_id, 0)
  #alert_condition_policy_id                           = element(module.newrelic_alert.simple_default_alert_policy_id, 0)
  alert_condition_type     = "apm_app_metric"
  alert_condition_entities = ["PHP Application"]

  alert_policy_channel = false
}

module "newrelic_synthetics" {
  source = "../../modules/newrelic_synthetics"

  synthetics_alert_condition           = true
  synthetics_alert_condition_policy_id = element(module.newrelic_alert.alert_policy_id, 0)
  synthetics_alert_condition_name      = "test"
  synthetics_monitor_name              = "linux-notes"
}

```

## Module Input Variables
----------------------
- `name` - The name for newrelic_alert resources (`default = test`)
- `environment` - environment (`default = prod`)
- `synthetics_alert_condition` - Enable synthetics_alert_condition (`default = False`)
- `synthetics_alert_condition_name` - (Required) The title of the condition (`default = ""`)
- `synthetics_alert_condition_policy_id` - (Required) The ID of the policy where this condition should be used. (`default = ""`)
- `synthetics_monitor_name` -  (Required) The title of this condition. (`default = ""`)
- `synthetics_alert_condition_runbook_url` - (Optional) Runbook URL to display in notifications. (`default = null`)
- `synthetics_alert_condition_enabled` - (Optional) Set whether to enable the alert condition. Defaults to true. (`default = True`)

## Module Output Variables
----------------------
- `newrelic_synthetics_alert_condition_id` - ID for newrelic_synthetics_alert_condition


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
