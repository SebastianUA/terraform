# Work with newrelic alerts via terraform

A terraform module for making newrelic alerts.
 
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
    api_key = "75e6741e6326cce16ecfb94c3c0b8fdf"
}
module "newrelic_alert" {
    source                                              = "../../modules/newrelic_alert"
                                                        
    # vars for newrelic_alert_policy
    newrelic_alert_policy                               = "true"
    #newrelic_alert_policy_name_custom                   = "new-relic-policy-PER_CONDITION"
    alert_policy_incident_preference                    = "PER_CONDITION"
    newrelic_alert_policy_simple_default                = "true"

    newrelic_alert_channel                              = "true"
    #                                           
    newrelic_alert_channel_campfire                     = "false"
    #
    newrelic_alert_channel_email                        = "false"
    #
    newrelic_alert_channel_opsgenie                     = "false"
    #
    newrelic_alert_channel_pagerduty                    = "false"
    #
    newrelic_alert_channel_slack                        = "true"
    newrelic_alert_channel_slack_configuration_channel  = "new-relic"
    newrelic_alert_channel_slack_configuration_url      = "https://hooks.slack.com/services/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"
    #
    newrelic_alert_channel_user                         = "false"
    #
    newrelic_alert_channel_victorops                    = "false"
    #
    newrelic_alert_channel_webhook                      = "false"
    #
    newrelic_alert_condition                            = "true"                                                         
    alert_condition_policy_id                           = "${element(module.newrelic_alert.simple_default_alert_policy_id, 0)}"
    alert_condition_type                                = "apm_app_metric"
    alert_condition_entities                            = ["PHP Application"]

    newrelic_alert_policy_channel                       = "false"
}

```

Module Input Variables
----------------------
-`name` - The name for newrelic_alert resources (`default     = "test"`).
-`environment` - environment (`default     = "prod"`).
-`newrelic_alert_channel` - Enable newrelic alert channel at general (`default     = "false"`).
-`newrelic_alert_channel_campfire` - Enable newrelic alert channel campfire usage (`default     = "false"`).
-`newrelic_alert_channel_campfire_name_custom` - Set custom name for newrelic_alert_channel (`default     = ""`).
-`newrelic_alert_channel_campfire_configuration_room` - Set room (default     = "").
-`newrelic_alert_channel_campfire_configuration_subdomain` - Set subdomain (`default     = ""`).
-`newrelic_alert_channel_campfire_configuration_token` - Set token (`default     = ""`).
-`newrelic_alert_channel_email` - Enable newrelic alert channel email usage (`default     = "false"`).
-`newrelic_alert_channel_email_name_custom` - Set custom name for newrelic_alert_channel (`default     = ""`).
-`newrelic_alert_channel_email_configuration_recipients` - Set reemail. In this case, its - email address (`default     = ""`).
-`newrelic_alert_channel_email_configuration_include_json_attachment` - Set include_json_attachment (`default     = 1`).
-`newrelic_alert_channel_opsgenie` - Enable newrelic alert channel opsgenie (`default     = "false"`).
-`newrelic_alert_channel_opsgenie_name_custom` - Set custom name for newrelic_alert_channel (`default     = ""`).
-`newrelic_alert_channel_opsgenie_configuration_api_key` - Set api_key (`default     = ""`).
-`newrelic_alert_channel_opsgenie_configuration_recipients` - Set reemail. In this case, its - email address (`default     = ""`).
-`newrelic_alert_channel_opsgenie_configuration_tags` - Set tags (`default     = []`).
-`newrelic_alert_channel_opsgenie_configuration_teams` - Set teams (`default     = []`).
-`newrelic_alert_channel_pagerduty` - Enable newrelic alert channel pagerduty usage (`default     = "false"`).
-`newrelic_alert_channel_pagerduty_name_custom` - Set custom name for newrelic_alert_channel  (`default     = ""`).
-`newrelic_alert_channel_pagerduty_configuration_service_key` - Set service_key  (`default     = ""`).
-`newrelic_alert_channel_slack` - Enable newrelic alert channel slack usage  (`default     = "false"`).
-`newrelic_alert_channel_slack_name_custom` - Set custom name for newrelic_alert_channel  (`default     = ""`).
-`newrelic_alert_channel_slack_configuration_channel` - Set channel  (`default     = ""`).
-`newrelic_alert_channel_slack_configuration_url` - Set url  (`default     = 1`).
-`newrelic_alert_channel_user` - Enable newrelic alert channel user usage  (`default     = "false"`).
-`newrelic_alert_channel_user_name_custom` - Set custom name for newrelic_alert_channel  (`default     = ""`).
-`newrelic_alert_channel_user_configuration_user_id` - Set user_id  (`default     = ""`).
-`newrelic_alert_channel_victorops` - Enable newrelic alert channel victorops usage  (`default     = "false"`).
-`newrelic_alert_channel_victorops_name_custom` - Set custom name for newrelic_alert_channel  (`default     = ""`).
-`newrelic_alert_channel_victorops_configuration_key` - Set key  (`default     = ""`).
-`newrelic_alert_channel_victorops_configuration_route_key` - Set route_key  (`default     = ""`).
-`newrelic_alert_channel_webhook` - Enable newrelic alert channel webhook usage  (`default     = "false"`).
-`newrelic_alert_channel_webhook_name_custom` - Set custom name for newrelic_alert_channel  (`default     = ""`).
-`newrelic_alert_channel_webhook_configuration_auth_password` - Set auth_password  (`default     = ""`).
-`newrelic_alert_channel_webhook_configuration_auth_type` - Set auth_type  (`default     = ""`).
-`newrelic_alert_channel_webhook_configuration_auth_username` - Set auth_username  (`default     = ""`).
-`newrelic_alert_channel_webhook_configuration_base_url` - Set base_url  (`default     = ""`).
-`newrelic_alert_channel_webhook_configuration_headers` - Set headers (`default     = []`).
-`newrelic_alert_channel_webhook_configuration_payload_type` - Set type  (`default     = ""`).
-`newrelic_alert_channel_webhook_configuration_payload` - (`default     = []`).
-`newrelic_alert_policy` - Enable newrelic_alert_policy usage  (`default     = "false"`).
-`newrelic_alert_policy_name_custom` - Set custom name for newrelic_alert_policy  (`default     = ""`).
-`alert_policy_incident_preference` - (Optional) The rollup strategy for the policy. Options include: PER_POLICY, PER_CONDITION, or PER_CONDITION_AND_TARGET. The default is PER_POLICY.  (`default     = "PER_POLICY"`).
-`newrelic_alert_policy_simple_default` - Enable newrelic_alert_policy_simple_default  (`default     = "false"`).
-`newrelic_alert_policy_simple_default_name` - Name  (`default     = ""`).
-`newrelic_alert_condition` - Enable newrelic_alert_condition  (`default     = "false"`).
-`alert_condition_policy_id` - (Required) The ID of the policy where this condition should be used.  (`default     = ""`).
-`alert_condition_name` - (Required) The title of the condition  (`default     = ""`).
-`alert_condition_type` - (Required) The type of condition. One of: apm_app_metric, apm_jvm_metric, apm_kt_metric, servers_metric, browser_metric, mobile_metric  (`default     = "apm_app_metric"`).
-`alert_condition_entities` - (Required) The instance IDS associated with this condition (`default     = []`).
-`alert_condition_metric` - (Required) The metric field accepts parameters based on the `type` set.  (`default     = "apdex"`).
-`alert_condition_gc_metric` - (Optional) A valid Garbage Collection metric e.g. GC/G1 Young Generation. This is required if you are using apm_jvm_metric with gc_cpu_time condition type.  (`default     = "GC/G1 Young Generation"`).
-`alert_condition_violation_close_timer` - (Optional) Automatically close instance-based violations, including JVM health metric violations, after the number of hours specified. Must be: 1, 2, 4, 8, 12 or 24.  (`default     = 1`).
-`alert_condition_runbook_url` - (Optional) Runbook URL to display in notifications.  (`default     = ""`).
-`alert_condition_condition_scope` - (Optional) instance or application. This is required if you are using the JVM plugin in New Relic.  (`default     = "application"`).
-`alert_condition_user_defined_metric` - (Optional) A custom metric to be evaluated.  (`default     = ""`).
-`alert_condition_user_defined_value_function` - (Optional) One of: average, min, max, total, or sample_size.  (`default     = "average"`).
-`alert_condition_term_duration` - (Required) In minutes, must be: 5, 10, 15, 30, 60, or 120.  (`default     = 5`).
-`alert_condition_term_operator` - (Optional) above, below, or equal. Defaults to equal.  (`default     = "equal"`).
-`alert_condition_term_priority` - (Optional) critical or warning. Defaults to critical.  (`default     = "critical"`).
-`alert_condition_term_threshold` - (Required) Must be 0 or greater.  (`default     = 0`).
-`alert_condition_term_time_function` - (Required) all or any.  (`default     = "all"`).
-`newrelic_alert_policy_channel` - Enable newrelic_alert_policy_channel  (`default     = "false"`).
-`alert_policy_policy_id` - (Required) The ID of the policy.  (`default     = ""`).
-`alert_policy_channel_id` - (Required) The ID of the channel.  (`default     = ""`).


Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See LICENSE for full details.

