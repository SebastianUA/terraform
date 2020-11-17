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

module "newrelic_nrql" {
  source = "../../modules/newrelic_nrql"

  nrql_alert_condition           = true
  nrql_alert_condition_policy_id = element(module.newrelic_alert.alert_policy_id, 0)

  nrql_alert_condition_nrql_query = "SELECT count(*) FROM SyntheticCheck WHERE monitorId = '1'"

}
