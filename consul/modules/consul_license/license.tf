#---------------------------------------------------
# Consul license
#---------------------------------------------------
resource "consul_license" "license" {
  count = var.enable_license ? 1 : 0

  license = var.license

  datacenter = var.license_datacenter

  depends_on = []
}

