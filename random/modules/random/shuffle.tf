#---------------------------------------------------
# Create random shuffle
#---------------------------------------------------
resource "random_shuffle" "shuffle" {
  count = var.enable_shuffle ? 1 : 0

  input = var.shuffle_input

  result_count = var.shuffle_result_count
  keepers      = var.shuffle_keepers
  seed         = var.shuffle_seed

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
