#---------------------------------------------------
# Time sleep
#---------------------------------------------------
resource "time_sleep" "sleep" {
  count = var.enable_sleep ? 1 : 0

  create_duration  = var.sleep_create_duration
  destroy_duration = var.sleep_destroy_duration

  triggers = var.sleep_triggers

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}