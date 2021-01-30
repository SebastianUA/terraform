#---------------------------------------------------
# Heroku space
#---------------------------------------------------
resource "heroku_space" "space" {
  count = var.enable_space ? 1 : 0

  name         = var.space_name != "" ? var.space_name : "${var.name}-${var.environment}-space"
  organization = var.space_organization != "" ? var.space_organization : "${var.name}-${var.environment}-space-org"

  region    = var.space_region
  cidr      = var.space_cidr
  data_cidr = var.space_data_cidr
  shield    = var.space_shield

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
