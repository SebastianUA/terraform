#---------------------------------------------------
# Heroku space vpn connection
#---------------------------------------------------
resource "heroku_space_vpn_connection" "space_vpn_connection" {
  count = var.enable_space_vpn_connection ? 1 : 0

  name           = var.space_vpn_connection_name != "" ? var.space_vpn_connection_name : "${var.name}-${var.environment}-space-vpn-connection"
  space          = var.space_vpn_connection_space != "" ? var.space_vpn_connection_space : (var.enable_space ? element(heroku_space.space.*.id, 0) : null)
  public_ip      = var.space_vpn_connection_public_ip
  routable_cidrs = var.space_vpn_connection_routable_cidrs

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    heroku_space.space
  ]
}