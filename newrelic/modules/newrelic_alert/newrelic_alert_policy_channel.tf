resource "newrelic_alert_policy_channel" "alert_policy_channel" {
  count = var.alert_policy_channel ? 1 : 0

  policy_id   = var.alert_policy_policy_id
  channel_ids = var.alert_policy_channel_ids

  depends_on = []
}
