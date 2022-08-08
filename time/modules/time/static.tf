#---------------------------------------------------
# Time static
#---------------------------------------------------
resource "time_static" "static" {
  count = var.enable_static ? 1 : 0

  rfc3339  = var.static_rfc3339
  triggers = var.static_triggers

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}