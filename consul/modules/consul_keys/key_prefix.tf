#---------------------------------------------------
# Consul key prefix
#---------------------------------------------------
resource "consul_key_prefix" "key_prefix" {
  count = var.enable_key_prefix ? 1 : 0

  path_prefix = var.key_prefix_path_prefix

  datacenter = var.key_prefix_datacenter
  token      = var.key_prefix_token
  namespace  = var.key_prefix_namespace
  subkeys    = var.key_prefix_subkeys

  dynamic "subkey" {
    iterator = subkey
    for_each = var.key_prefix_subkey

    content {
      path  = lookup(subkey.value, "path", null)
      value = lookup(subkey.value, "value", null)

      flags = lookup(subkey.value, "flags", null)
    }
  }

  depends_on = []
}
