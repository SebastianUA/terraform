#---------------------------------------------------
# Time rotating
#---------------------------------------------------
resource "time_rotating" "rotating" {
  count = var.enable_rotating ? 1 : 0

  rotation_years   = var.rotating_rotation_years
  rotation_months  = var.rotating_rotation_months
  rotation_days    = var.rotating_rotation_days
  rotation_hours   = var.rotating_rotation_hours
  rotation_minutes = var.rotating_rotation_minutes

  rfc3339          = var.rotating_rfc3339
  rotation_rfc3339 = var.rotating_rotation_rfc3339

  triggers = var.rotating_triggers

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}