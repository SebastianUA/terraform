#---------------------------------------------------
# Create random pet
#---------------------------------------------------
resource "random_pet" "pet" {
  count = var.enable_pet ? 1 : 0

  keepers   = var.pet_keepers
  length    = var.pet_length
  prefix    = var.pet_prefix
  separator = var.pet_separator

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
