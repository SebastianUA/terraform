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
    source                                                          = "../../modules/newrelic_alert"
         
    # vars for newrelic_alert_policy                    
    alert_policy                                                    = "true"
    alert_policy_name                                               = "new-relic-policy-PER_CONDITION_AND_TARGET"
    alert_policy_incident_preference                                = "PER_CONDITION_AND_TARGET"
    alert_policy_simple_default                                     = "false"
    
    alert_channel                                                   = "true"
    alert_channel_email                                             = "true"
    alert_channel_email_name                                        = "nr-team-email"
    alert_channel_email_configuration_recipients                    = "vitalii.natarov@yahoo.com"
    alert_channel_email_configuration_include_json_attachment       = "true"
    #
    alert_channel_slack                                             = "true"
    alert_channel_slack_name                                        = "nrops-slack"
    alert_channel_slack_configuration_channel                       = "new-relic"
    alert_channel_slack_configuration_url                           = "https://hooks.slack.com/services/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666"
    #                                                       
    alert_policy_channel                                            = "true"
    alert_policy_policy_id                                          = "${element(module.newrelic_alert.alert_policy_id, 0)}"
    alert_policy_channel_id                                         = "${element(module.newrelic_alert.alert_channel_slack_id, 0)}"
    #alert_policy_channel_id                                         = ["${element(module.newrelic_alert.alert_channel_email_id, 0)}", "${element(module.newrelic_alert.alert_channel_slack_id, 0)}"]
} 

module "alert_channel_email" {
    source                                                          = "../../modules/newrelic_alert"

    alert_policy_channel                                            = "true"
    alert_policy_policy_id                                          = "${element(module.newrelic_alert.alert_policy_id, 0)}"
    alert_policy_channel_id                                         = "${element(module.newrelic_alert.alert_channel_email_id, 0)}"
}
 
# Throughput (web) is the number of web transactions your application is serving each minute
module "alert_condition_response_time_web" {
    source                                                          = "../../modules/newrelic_alert"
    
    alert_condition                                                 = "true"
    alert_condition_name                                            = "alert_condition_response_time_web"
    alert_condition_policy_id                                       = "${element(module.newrelic_alert.alert_policy_id, 0)}"
    alert_condition_type                                            = "apm_app_metric"
    alert_condition_entities                                        = ["test_entry"]
    alert_condition_metric                                          = "response_time_web"

    alert_condition_gc_metric                                       = ""
    alert_condition_violation_close_timer                           = "1"
    alert_condition_runbook_url                                     = "http://test_uri"
    alert_condition_condition_scope                                 = "instance" #"application"
    alert_condition_user_defined_metric                             = ""
    alert_condition_user_defined_value_function                     = "average"

    alert_condition_term_duration                                   = 5
    alert_condition_term_operator                                   = "above"
    alert_condition_term_priority                                   = "critical"
    alert_condition_term_threshold                                  = 20
    alert_condition_term_time_function                              = "all"

    alert_policy_channel                                            = "true"
    alert_policy_policy_id                                          = "${element(module.newrelic_alert.alert_policy_id, 0)}"
    alert_policy_channel_id                                         = "${element(module.newrelic_alert.alert_channel_slack_id, 0)}"
    #alert_policy_channel_id                                         = ["${element(module.newrelic_alert.alert_channel_email_id, 0)}", "${element(module.newrelic_alert.alert_channel_slack_id, 0)}"]
}
 
# Throughput (background) is the number of non-web transactions your application is serving each minute.
module "alert_condition_response_time_background" {
    source                                                          = "../../modules/newrelic_alert"

    alert_condition                                                 = "true"
    alert_condition_name                                            = "alert_condition_response_time_background"
    alert_condition_policy_id                                       = "${element(module.newrelic_alert.alert_policy_id, 0)}"
    alert_condition_type                                            = "apm_app_metric"
    alert_condition_entities                                        = ["test_entry"]
    alert_condition_metric                                          = "response_time_background"

    alert_condition_gc_metric                                       = ""
    alert_condition_violation_close_timer                           = "1"
    alert_condition_runbook_url                                     = "http://test_uri.com"
    alert_condition_condition_scope                                 = "instance" #"application"
    alert_condition_user_defined_metric                             = ""
    alert_condition_user_defined_value_function                     = "average"

    alert_condition_term_duration                                   = 5
    alert_condition_term_operator                                   = "above"
    alert_condition_term_priority                                   = "critical"
    alert_condition_term_threshold                                  = 20
    alert_condition_term_time_function                              = "all"

    alert_policy_channel                                            = "true"
    alert_policy_policy_id                                          = "${element(module.newrelic_alert.alert_policy_id, 0)}"
    alert_policy_channel_id                                         = "${element(module.newrelic_alert.alert_channel_slack_id, 0)}"
    #alert_policy_channel_id                                         = ["${element(module.newrelic_alert.alert_channel_email_id, 0)}", "${element(module.newrelic_alert.alert_channel_slack_id, 0)}"]
}

#
#module "alert_condition_database_transaction_time" {
#    source                                                          = "../../modules/newrelic_alert"
#
#    alert_condition                                                 = "true"
#    alert_condition_name                                            = "alert_condition_database_transaction_time"
#    alert_condition_policy_id                                       = "${element(module.newrelic_alert.alert_policy_id, 0)}"
#    alert_condition_type                                            = "mobile_metric"
#    alert_condition_entities                                        = ["test_entry"]
#    alert_condition_metric                                          = "database"
#
#    alert_condition_gc_metric                                       = "GC/G1 Young Generation"
#    alert_condition_violation_close_timer                           = "1"
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
#    alert_policy_channel                                            = "true"
#    alert_policy_policy_id                                          = "${element(module.newrelic_alert.alert_policy_id, 0)}"
#    alert_policy_channel_id                                         = "${element(module.newrelic_alert.alert_channel_slack_id, 0)}"
#}
#
# 
module "alert_condition_CPU_Utilization" {
    source                                                          = "../../modules/newrelic_alert"

    alert_condition                                                 = "true"
    alert_condition_name                                            = "alert_condition_CPU_Utilization"
    alert_condition_policy_id                                       = "${element(module.newrelic_alert.alert_policy_id, 0)}"
    alert_condition_type                                            = "apm_jvm_metric"
    alert_condition_entities                                        = ["test_entry"]
    alert_condition_metric                                          = "cpu_utilization_time"

    alert_condition_gc_metric                                       = ""
    alert_condition_violation_close_timer                           = "1"
    alert_condition_runbook_url                                     = "http://test_uri.com"
    alert_condition_condition_scope                                 = "instance" #"application"
    alert_condition_user_defined_metric                             = ""
    alert_condition_user_defined_value_function                     = "average"

    alert_condition_term_duration                                   = 5
    alert_condition_term_operator                                   = "above"
    alert_condition_term_priority                                   = "critical"
    alert_condition_term_threshold                                  = 60
    alert_condition_term_time_function                              = "all"

    alert_policy_channel                                            = "true"
    alert_policy_policy_id                                          = "${element(module.newrelic_alert.alert_policy_id, 0)}"
    alert_policy_channel_id                                         = "${element(module.newrelic_alert.alert_channel_slack_id, 0)}"
    #alert_policy_channel_id                                         = ["${element(module.newrelic_alert.alert_channel_email_id, 0)}", "${element(module.newrelic_alert.alert_channel_slack_id, 0)}"]
}

#
module "alert_condition_deadlocked_threads" {
    source                                                          = "../../modules/newrelic_alert"

    alert_condition                                                 = "true"
    alert_condition_name                                            = "alert_condition_deadlocked_threads"
    alert_condition_policy_id                                       = "${element(module.newrelic_alert.alert_policy_id, 0)}"
    alert_condition_type                                            = "apm_jvm_metric"
    alert_condition_entities                                        = ["test_entry"]
    alert_condition_metric                                          = "deadlocked_threads"

    alert_condition_gc_metric                                       = ""
    alert_condition_violation_close_timer                           = "1"
    alert_condition_runbook_url                                     = "http://test_uri.com"
    alert_condition_condition_scope                                 = "instance" 
    alert_condition_user_defined_metric                             = ""
    alert_condition_user_defined_value_function                     = "average"

    alert_condition_term_duration                                   = 5
    alert_condition_term_operator                                   = "above"
    alert_condition_term_priority                                   = "critical"
    alert_condition_term_threshold                                  = 60
    alert_condition_term_time_function                              = "all"

    alert_policy_channel                                            = "true"
    alert_policy_policy_id                                          = "${element(module.newrelic_alert.alert_policy_id, 0)}"
    alert_policy_channel_id                                         = "${element(module.newrelic_alert.alert_channel_slack_id, 0)}"
    #alert_policy_channel_id                                         = ["${element(module.newrelic_alert.alert_channel_email_id, 0)}", "${element(module.newrelic_alert.alert_channel_slack_id, 0)}"]
}
