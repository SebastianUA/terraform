#---------------------------------------------------
# Time offset
#---------------------------------------------------
resource "time_offset" "offset" {
  count = var.enable_offset ? 1 : 0

  offset_years   = var.offset_offset_years
  offset_months  = var.offset_offset_months
  offset_days    = var.offset_offset_days
  offset_hours   = var.offset_offset_hours
  offset_minutes = var.offset_offset_minutes
  offset_seconds = var.offset_offset_seconds

  base_rfc3339 = var.offset_base_rfc3339

  triggers = var.offset_triggers

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}