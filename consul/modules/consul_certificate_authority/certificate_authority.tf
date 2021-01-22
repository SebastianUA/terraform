#---------------------------------------------------
# Consul certificate authority
#---------------------------------------------------
resource "consul_certificate_authority" "certificate_authority" {
  count = var.enable_certificate_authority ? 1 : 0

  connect_provider = var.certificate_authority_connect_provider
  config           = var.certificate_authority_config

  depends_on = []
}