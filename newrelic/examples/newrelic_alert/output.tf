#-----------------------------------------------------------
#newrelic_alert_channel 
#-----------------------------------------------------------
output "nr_alert_channel_slack" {
    description = "ID for newrelic_alert_channel_slack"
    value       = "${module.newrelic_alert.alert_channel_slack_id}"
}

output "nr_alert_channel_email" {
    description = "ID for newrelic_alert_channel_email"
    value       = "${module.newrelic_alert.alert_channel_email_id}"
}

#-----------------------------------------------------------
# newrelic_alert_policy
#-----------------------------------------------------------
output "nr_alert_policy_id" {
    description = "ID of the policy."
    value       = "${module.newrelic_alert.alert_policy_id}"
}

output "nr_simple_default_alert_policy_id" {
    description = "ID of the policy for simple_default"
    value       = "${module.newrelic_alert.simple_default_alert_policy_id}"
}
