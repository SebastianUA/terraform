#-----------------------------------------------------------
# newrelic_alert_channel
#-----------------------------------------------------------
// output "alert_channel_campfire_id" {
//     description = "ID for newrelic_alert_channel_campfire"
//     value       = element(concat(newrelic_alert_channel.alert_channel_campfire.*.id, [""]), 0)
// }

output "alert_channel_email_id" {
  description = "ID for newrelic_alert_channel_email"
  value       = element(concat(newrelic_alert_channel.alert_channel_email.*.id, [""]), 0)
}

output "alert_channel_opsgenie_id" {
  description = "ID for newrelic_alert_channel_opsgenie"
  value       = element(concat(newrelic_alert_channel.alert_channel_opsgenie.*.id, [""]), 0)
}

output "alert_channel_pagerduty_id" {
  description = "ID for newrelic_alert_channel_pagerduty"
  value       = element(concat(newrelic_alert_channel.alert_channel_pagerduty.*.id, [""]), 0)
}

output "alert_channel_slack_id" {
  description = "ID for newrelic_alert_channel_slack"
  value       = element(concat(newrelic_alert_channel.alert_channel_slack.*.id, [""]), 0)
}

output "alert_channel_user_id" {
  description = "ID for newrelic_alert_channel_user"
  value       = element(concat(newrelic_alert_channel.alert_channel_user.*.id, [""]), 0)
}

output "alert_channel_victorops_id" {
  description = "ID for newrelic_alert_channel_victorops"
  value       = element(concat(newrelic_alert_channel.alert_channel_victorops.*.id, [""]), 0)
}

output "alert_channel_webhook_id" {
  description = "ID for newrelic_alert_channel_webhook"
  value       = element(concat(newrelic_alert_channel.alert_channel_webhook.*.id, [""]), 0)
}

#-----------------------------------------------------------
# newrelic_alert_policy
#-----------------------------------------------------------
output "alert_policy_id" {
  description = "ID of the policy."
  value       = element(concat(newrelic_alert_policy.alert_policy.*.id, [""]), 0)
}

output "simple_default_alert_policy_id" {
  description = "ID of the policy for simple_default"
  value       = element(concat(newrelic_alert_policy.simple_default.*.id, [""]), 0)
}

#-----------------------------------------------------------
# newrelic_alert_condition
#-----------------------------------------------------------
output "alert_condition_id" {
  description = "The ID of the alert condition."
  value       = element(concat(newrelic_alert_condition.alert_condition.*.id, [""]), 0)
}

#-----------------------------------------------------------
# newrelic_alert_policy_channel
#-----------------------------------------------------------
output "alert_policy_channel_id" {
  description = "The ID of the alert policy channel"
  value       = element(concat(newrelic_alert_policy_channel.alert_policy_channel.*.id, [""]), 0)
}
