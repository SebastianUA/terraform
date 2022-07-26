# Work with NEWRELIC_ALERT via terraform

A terraform module for making NEWRELIC_ALERT.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.13"
  #backend "remote" {
  #    organization = "captain"
  #
  #    workspaces {
  #        name = "captain-new-relic-nonprod"
  #    }
  #}
}

provider "newrelic" {
  api_key    = "api_key"
  account_id = "account_id"
}

module "newrelic_alert" {
  source = "../../modules/newrelic_alert"

  # vars for newrelic_alert_policy
  alert_policy                     = true
  alert_policy_name                = "new-relic-policy-PER_CONDITION_AND_TARGET"
  alert_policy_incident_preference = "PER_CONDITION_AND_TARGET"
  alert_policy_simple_default      = false

  alert_channel                                             = true
  alert_channel_email                                       = true
  alert_channel_email_name                                  = "nr-team-email"
  alert_channel_email_configuration_recipients              = "vitalii.natarov@yahoo.com"
  alert_channel_email_configuration_include_json_attachment = true
  #
  alert_channel_slack                       = true
  alert_channel_slack_name                  = "nrops-slack"
  alert_channel_slack_configuration_channel = "new-relic"
  alert_channel_slack_configuration_url     = "https://hooks.slack.com/services/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666"
  #
  alert_policy_channel     = true
  alert_policy_policy_id   = element(module.newrelic_alert.alert_policy_id, 0)
  alert_policy_channel_ids = element(module.newrelic_alert.alert_channel_slack_id, 0)
  #alert_policy_channel_id                                         = [element(module.newrelic_alert.alert_channel_email_id, 0), element(module.newrelic_alert.alert_channel_slack_id, 0)]
}

module "alert_channel_email" {
  source = "../../modules/newrelic_alert"

  alert_policy_channel     = true
  alert_policy_policy_id   = element(module.newrelic_alert.alert_policy_id, 0)
  alert_policy_channel_ids = element(module.newrelic_alert.alert_channel_email_id, 0)
}

# Throughput (web) is the number of web transactions your application is serving each minute
module "alert_condition_response_time_web" {
  source = "../../modules/newrelic_alert"

  alert_condition           = true
  alert_condition_name      = "alert_condition_response_time_web"
  alert_condition_policy_id = element(module.newrelic_alert.alert_policy_id, 0)
  alert_condition_type      = "apm_app_metric"
  alert_condition_entities  = ["linux-notes-php"]
  alert_condition_metric    = "response_time_web"

  alert_condition_gc_metric                   = ""
  alert_condition_violation_close_timer       = 1
  alert_condition_runbook_url                 = "http://test_uri"
  alert_condition_condition_scope             = "instance" #"application"
  alert_condition_user_defined_metric         = ""
  alert_condition_user_defined_value_function = "average"

  alert_condition_term_duration      = 5
  alert_condition_term_operator      = "above"
  alert_condition_term_priority      = "critical"
  alert_condition_term_threshold     = 20
  alert_condition_term_time_function = "all"

  alert_policy_channel     = true
  alert_policy_policy_id   = element(module.newrelic_alert.alert_policy_id, 0)
  alert_policy_channel_ids = element(module.newrelic_alert.alert_channel_slack_id, 0)
  #alert_policy_channel_id                                         = [element(module.newrelic_alert.alert_channel_email_id, 0), element(module.newrelic_alert.alert_channel_slack_id, 0)]
}

# Throughput (background) is the number of non-web transactions your application is serving each minute.
module "alert_condition_response_time_background" {
  source = "../../modules/newrelic_alert"

  alert_condition           = true
  alert_condition_name      = "alert_condition_response_time_background"
  alert_condition_policy_id = element(module.newrelic_alert.alert_policy_id, 0)
  alert_condition_type      = "apm_app_metric"
  alert_condition_entities  = ["linux-notes-php"]
  alert_condition_metric    = "response_time_background"

  alert_condition_gc_metric                   = ""
  alert_condition_violation_close_timer       = 1
  alert_condition_runbook_url                 = "http://test_uri.com"
  alert_condition_condition_scope             = "instance" #"application"
  alert_condition_user_defined_metric         = ""
  alert_condition_user_defined_value_function = "average"

  alert_condition_term_duration      = 5
  alert_condition_term_operator      = "above"
  alert_condition_term_priority      = "critical"
  alert_condition_term_threshold     = 20
  alert_condition_term_time_function = "all"

  alert_policy_channel     = true
  alert_policy_policy_id   = element(module.newrelic_alert.alert_policy_id, 0)
  alert_policy_channel_ids = element(module.newrelic_alert.alert_channel_slack_id, 0)
  #alert_policy_channel_id                                         = [element(module.newrelic_alert.alert_channel_email_id, 0), element(module.newrelic_alert.alert_channel_slack_id, 0)]
}

#
#module "alert_condition_database_transaction_time" {
#    source                                                          = "../../modules/newrelic_alert"
#
#    alert_condition                                                 = true
#    alert_condition_name                                            = "alert_condition_database_transaction_time"
#    alert_condition_policy_id                                       = element(module.newrelic_alert.alert_policy_id, 0)
#    alert_condition_type                                            = "mobile_metric"
#    alert_condition_entities                                        = ["linux-notes-php"]
#    alert_condition_metric                                          = "database"
#
#    alert_condition_gc_metric                                       = "GC/G1 Young Generation"
#    alert_condition_violation_close_timer                           = 1
#    alert_condition_runbook_url                                     = "http://test_uri.com"
#    alert_condition_condition_scope                                 = "application"
#    alert_condition_user_defined_metric                             = ""
#    alert_condition_user_defined_value_function                     = "average"
#
#    alert_condition_term_duration                                   = 5
#    alert_condition_term_operator                                   = "above"
#    alert_condition_term_priority                                   = "critical"
#    alert_condition_term_threshold                                  = 20
#    alert_condition_term_time_function                              = "all"
#
#    alert_policy_channel                                            = true
#    alert_policy_policy_id                                          = element(module.newrelic_alert.alert_policy_id, 0)
#    alert_policy_channel_id                                         = element(module.newrelic_alert.alert_channel_slack_id, 0)
#}
#
#
module "alert_condition_CPU_Utilization" {
  source = "../../modules/newrelic_alert"

  alert_condition           = true
  alert_condition_name      = "alert_condition_CPU_Utilization"
  alert_condition_policy_id = element(module.newrelic_alert.alert_policy_id, 0)
  alert_condition_type      = "apm_jvm_metric"
  alert_condition_entities  = ["linux-notes-php"]
  alert_condition_metric    = "cpu_utilization_time"

  alert_condition_gc_metric                   = ""
  alert_condition_violation_close_timer       = 1
  alert_condition_runbook_url                 = "http://test_uri.com"
  alert_condition_condition_scope             = "instance" #"application"
  alert_condition_user_defined_metric         = ""
  alert_condition_user_defined_value_function = "average"

  alert_condition_term_duration      = 5
  alert_condition_term_operator      = "above"
  alert_condition_term_priority      = "critical"
  alert_condition_term_threshold     = 60
  alert_condition_term_time_function = "all"

  alert_policy_channel     = true
  alert_policy_policy_id   = element(module.newrelic_alert.alert_policy_id, 0)
  alert_policy_channel_ids = element(module.newrelic_alert.alert_channel_slack_id, 0)
  #alert_policy_channel_id                                         = [element(module.newrelic_alert.alert_channel_email_id, 0), element(module.newrelic_alert.alert_channel_slack_id, 0)]
}

#
module "alert_condition_deadlocked_threads" {
  source = "../../modules/newrelic_alert"

  alert_condition           = true
  alert_condition_name      = "alert_condition_deadlocked_threads"
  alert_condition_policy_id = element(module.newrelic_alert.alert_policy_id, 0)
  alert_condition_type      = "apm_jvm_metric"
  alert_condition_entities  = ["linux-notes-php"]
  alert_condition_metric    = "deadlocked_threads"

  alert_condition_gc_metric                   = ""
  alert_condition_violation_close_timer       = 1
  alert_condition_runbook_url                 = "http://test_uri.com"
  alert_condition_condition_scope             = "instance"
  alert_condition_user_defined_metric         = ""
  alert_condition_user_defined_value_function = "average"

  alert_condition_term_duration      = 5
  alert_condition_term_operator      = "above"
  alert_condition_term_priority      = "critical"
  alert_condition_term_threshold     = 60
  alert_condition_term_time_function = "all"

  alert_policy_channel     = true
  alert_policy_policy_id   = element(module.newrelic_alert.alert_policy_id, 0)
  alert_policy_channel_ids = element(module.newrelic_alert.alert_channel_slack_id, 0)
  #alert_policy_channel_id                                         = [element(module.newrelic_alert.alert_channel_email_id, 0), element(module.newrelic_alert.alert_channel_slack_id, 0)]
}

```

## Module Input Variables
----------------------
- `name` - The name for newrelic_alert resources (`default = test`)
- `environment` - environment (`default = prod`)
- `alert_channel` - Enable newrelic alert channel at general (`default = False`)
- `alert_channel_email` - Enable newrelic alert channel email usage (`default = False`)
- `alert_channel_email_name` - Set custom name for newrelic_alert_channel (`default = ""`)
- `alert_channel_opsgenie` - Enable newrelic alert channel opsgenie (`default = False`)
- `alert_channel_opsgenie_name` - Set custom name for newrelic_alert_channel (`default = ""`)
- `alert_channel_pagerduty` - Enable newrelic alert channel pagerduty usage (`default = False`)
- `alert_channel_pagerduty_name` - Set custom name for newrelic_alert_channel (`default = ""`)
- `alert_channel_slack` - Enable newrelic alert channel slack usage (`default = False`)
- `alert_channel_slack_name` - Set custom name for newrelic_alert_channel (`default = ""`)
- `alert_channel_user` - Enable newrelic alert channel user usage (`default = False`)
- `alert_channel_user_name` - Set custom name for newrelic_alert_channel (`default = ""`)
- `alert_channel_victorops` - Enable newrelic alert channel victorops usage (`default = False`)
- `alert_channel_victorops_name` - Set custom name for newrelic_alert_channel (`default = ""`)
- `alert_channel_webhook` - Enable newrelic alert channel webhook usage (`default = False`)
- `alert_channel_webhook_name` - Set custom name for newrelic_alert_channel (`default = ""`)
- `alert_policy` - Enable newrelic_alert_policy usage (`default = False`)
- `alert_policy_name` - Set custom name for newrelic_alert_policy (`default = ""`)
- `alert_policy_incident_preference` - (Optional) The rollup strategy for the policy. Options include: PER_POLICY, PER_CONDITION, or PER_CONDITION_AND_TARGET. The default is PER_POLICY. (`default = PER_POLICY`)
- `alert_policy_simple_default` - Enable newrelic_alert_policy_simple_default (`default = False`)
- `alert_policy_simple_default_name` - Name (`default = ""`)
- `alert_condition` - Enable newrelic_alert_condition (`default = False`)
- `alert_condition_policy_id` - (Required) The ID of the policy where this condition should be used. (`default = ""`)
- `alert_condition_name` - (Required) The title of the condition (`default = ""`)
- `alert_condition_type` - (Required) The type of condition. One of: apm_app_metric, apm_jvm_metric, apm_kt_metric, servers_metric, browser_metric, mobile_metric (`default = apm_app_metric`)
- `alert_condition_entities` - (Required) The instance IDS associated with this condition. (`default = ['linux-notes-php']`)
- `alert_condition_metric` - (Required) The metric field accepts parameters based on the `type` set. Ex: `apdex`, `error_percentage`, `response_time_web`, `response_time_background`, `throughput_web`, `throughput_background`, `user_defined` (`default = apdex`)
- `alert_condition_gc_metric` - (Optional) A valid Garbage Collection metric e.g. GC/G1 Young Generation. This is required if you are using apm_jvm_metric with gc_cpu_time condition type. (`default = GC/G1 Young Generation`)
- `alert_condition_violation_close_timer` - (Optional) Automatically close instance-based violations, including JVM health metric violations, after the number of hours specified. Must be: 1, 2, 4, 8, 12 or 24. (`default = 1`)
- `alert_condition_runbook_url` - (Optional) Runbook URL to display in notifications. (`default = ""`)
- `alert_condition_condition_scope` - (Optional) instance or application. This is required if you are using the JVM plugin in New Relic. (`default = application`)
- `alert_condition_user_defined_metric` - (Optional) A custom metric to be evaluated. (`default = null`)
- `alert_condition_user_defined_value_function` - (Optional) One of: average, min, max, total, or sample_size. (`default = average`)
- `alert_condition_term_duration` - (Required) In minutes, must be: 5, 10, 15, 30, 60, or 120. (`default = 5`)
- `alert_condition_term_operator` - (Optional) above, below, or equal. Defaults to equal. (`default = equal`)
- `alert_condition_term_priority` - (Optional) critical or warning. Defaults to critical. (`default = critical`)
- `alert_condition_term_threshold` - (Required) Must be 0 or greater. (`default = 0`)
- `alert_condition_term_time_function` - (Required) all or any. (`default = all`)
- `alert_policy_channel` - Enable newrelic_alert_policy_channel (`default = False`)
- `alert_policy_policy_id` - (Required) The ID of the policy. (`default = ""`)
- `alert_policy_channel_ids` - (Required) The IDs of the channel. (`default = ""`)

## Module Output Variables
----------------------
- `alert_channel_email_id` - ID for newrelic_alert_channel_email
- `alert_channel_opsgenie_id` - ID for newrelic_alert_channel_opsgenie
- `alert_channel_pagerduty_id` - ID for newrelic_alert_channel_pagerduty
- `alert_channel_slack_id` - ID for newrelic_alert_channel_slack
- `alert_channel_user_id` - ID for newrelic_alert_channel_user
- `alert_channel_victorops_id` - ID for newrelic_alert_channel_victorops
- `alert_channel_webhook_id` - ID for newrelic_alert_channel_webhook
- `alert_policy_id` - ID of the policy.
- `simple_default_alert_policy_id` - ID of the policy for simple_default
- `alert_condition_id` - The ID of the alert condition.
- `alert_policy_channel_id` - The ID of the alert policy channel


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
