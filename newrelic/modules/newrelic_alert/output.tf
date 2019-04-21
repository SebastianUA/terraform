#-----------------------------------------------------------
# newrelic_alert_channel
#-----------------------------------------------------------
output "alert_channel_campfire_id" {
    description = "ID for newrelic_alert_channel_campfire"
    value       = "${newrelic_alert_channel.alert_channel_campfire.*.id}"
}

output "alert_channel_email_id" {
    description = "ID for newrelic_alert_channel_email"
    value       = "${newrelic_alert_channel.alert_channel_email.*.id}"
}

output "alert_channel_opsgenie_id" {
    description = "ID for newrelic_alert_channel_opsgenie"
    value       = "${newrelic_alert_channel.alert_channel_opsgenie.*.id}"
}

output "alert_channel_pagerduty_id" {
    description = "ID for newrelic_alert_channel_pagerduty"
    value       = "${newrelic_alert_channel.alert_channel_pagerduty.*.id}"
}

output "alert_channel_slack_id" {
    description = "ID for newrelic_alert_channel_slack"
    value       = "${newrelic_alert_channel.alert_channel_slack.*.id}"
}

output "alert_channel_user_id" {
    description = "ID for newrelic_alert_channel_user"
    value       = "${newrelic_alert_channel.alert_channel_user.*.id}"
}

output "alert_channel_victorops_id" {
    description = "ID for newrelic_alert_channel_victorops"
    value       = "${newrelic_alert_channel.alert_channel_victorops.*.id}"
}

output "alert_channel_webhook_id" {
    description = "ID for newrelic_alert_channel_webhook"
    value       = "${newrelic_alert_channel.alert_channel_webhook.*.id}"
}

#-----------------------------------------------------------
# newrelic_alert_policy
#-----------------------------------------------------------
output "alert_policy_id" {
    description = "ID of the policy."
    value       = "${newrelic_alert_policy.alert_policy.*.id}"
}

output "simple_default_alert_policy_id" {
    description = "ID of the policy for simple_default"
    value       = "${newrelic_alert_policy.simple_default.*.id}"
}

#-----------------------------------------------------------
# newrelic_alert_condition
#-----------------------------------------------------------
output "alert_condition_id" {
    description = "The ID of the alert condition."
    value       = "${newrelic_alert_condition.alert_condition.*.id}"
}

#-----------------------------------------------------------
# newrelic_alert_policy_channel
#-----------------------------------------------------------
output "alert_policy_channel_id" {
    description = "The ID of the alert policy channel"
    value       = "${newrelic_alert_policy_channel.alert_policy_channel.*.id}"
}
