#---------------------------------------------------
# Consul node
#---------------------------------------------------
resource "consul_node" "node" {
  count = var.enable_node ? 1 : 0

  name    = var.node_name != "" ? var.node_name : "${var.name}-${var.environment}-node"
  address = var.node_address

  datacenter = var.node_datacenter
  meta       = var.node_meta

  depends_on = []
}
