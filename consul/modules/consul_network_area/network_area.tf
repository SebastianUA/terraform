#---------------------------------------------------
# Consul network area
#---------------------------------------------------
resource "consul_network_area" "network_area" {
  count = var.enable_network_area ? 1 : 0

  peer_datacenter = var.network_area_peer_datacenter

  retry_join = var.network_area_retry_join
  use_tls    = var.network_area_use_tls
  datacenter = var.network_area_datacenter
  token      = var.network_area_token

  depends_on = []
}

