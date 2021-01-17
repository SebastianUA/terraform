#---------------------------------------------------
# Vault namespace
#---------------------------------------------------
resource "vault_namespace" "namespace" {
  count = var.enable_namespace ? 1 : 0

  path = var.namespace_path

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
