#---------------------------------------------------
# Create random string
#---------------------------------------------------
resource "random_string" "string" {
  count = var.enable_string ? 1 : 0

  length = var.string_length

  upper            = var.string_upper
  min_upper        = var.string_min_upper
  lower            = var.string_lower
  min_lower        = var.string_min_lower
  numeric          = var.string_numeric
  min_numeric      = var.string_min_numeric
  special          = var.string_special
  min_special      = var.string_min_special
  override_special = var.string_override_special
  keepers          = var.string_keepers

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
