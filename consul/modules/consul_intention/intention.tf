#---------------------------------------------------
# Consul intention
#---------------------------------------------------
resource "consul_intention" "intention" {
  count = var.enable_intention ? 1 : 0

  source_name      = var.intention_source_name
  destination_name = var.intention_destination_name
  action           = var.intention_action

  description           = var.intention_description
  datacenter            = var.intention_datacenter
  source_namespace      = var.intention_source_namespace
  destination_namespace = var.intention_destination_namespace
  meta                  = var.intention_meta

  depends_on = []
}
