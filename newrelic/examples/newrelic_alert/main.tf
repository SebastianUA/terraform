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

