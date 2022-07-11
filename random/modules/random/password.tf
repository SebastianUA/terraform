#---------------------------------------------------
# Create random password
#---------------------------------------------------
resource "random_password" "password" {
  count = var.enable_password ? 1 : 0

  length = var.password_length

  special          = var.password_special
  override_special = var.password_override_special
  lower            = var.password_lower
  min_lower        = var.password_min_lower
  min_numeric      = var.password_min_numeric
  min_special      = var.password_min_special
  min_upper        = var.password_min_upper
  numeric          = var.password_numeric
  upper            = var.password_upper
  keepers          = var.password_keepers

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}