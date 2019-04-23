resource "newrelic_alert_policy_channel" "alert_policy_channel" {
    count       = "${var.alert_policy_channel ? 1 : 0}"
            
    policy_id   = "${var.alert_policy_policy_id}"
    channel_id  = "${var.alert_policy_channel_id}"

    lifecycle = {
        create_before_destroy   = true,
        ignore_changes          = []
    }
  
    depends_on  = []

}

