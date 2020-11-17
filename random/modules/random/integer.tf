#---------------------------------------------------
# Create random integer
#---------------------------------------------------
resource "random_integer" "integer" {
  count = var.enable_integer ? 1 : 0

  min     = var.integer_min
  max     = var.integer_max
  keepers = var.integer_keepers
  seed    = var.integer_seed

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
