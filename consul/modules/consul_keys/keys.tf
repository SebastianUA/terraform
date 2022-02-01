#---------------------------------------------------
# Consul keys
#---------------------------------------------------
resource "consul_keys" "keys" {
  count = var.enable_keys ? 1 : 0

  datacenter = var.keys_datacenter
  token      = var.keys_token
  namespace  = var.keys_namespace

  dynamic "key" {
    iterator = key
    for_each = var.consul_keys

    content {
      path  = lookup(key.value, "path", null)
      value = lookup(key.value, "value", null)

      name    = lookup(key.value, "name", null)
      default = lookup(key.value, "default", null)
      flags   = lookup(key.value, "flags", null)
      delete  = lookup(key.value, "delete", null)
    }
  }

  depends_on = []
}

