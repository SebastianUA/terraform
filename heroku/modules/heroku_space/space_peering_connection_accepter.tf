#---------------------------------------------------
# Heroku space peering connection accepter
#---------------------------------------------------
resource "heroku_space_peering_connection_accepter" "space_peering_connection_accepter" {
  count = var.enable_space_peering_connection_accepter ? 1 : 0

  space                     = var.space_peering_connection_accepter_space != "" ? var.space_peering_connection_accepter_space : (var.enable_space ? element(heroku_space.space.*.id, 0) : null)
  vpc_peering_connection_id = var.space_peering_connection_accepter_vpc_peering_connection_id

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    heroku_space.space
  ]
}
