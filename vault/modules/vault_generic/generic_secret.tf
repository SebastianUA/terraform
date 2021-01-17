#---------------------------------------------------
# Vault generic secret
#---------------------------------------------------
resource "vault_generic_secret" "generic_secret" {
  count = var.enable_generic_secret ? 1 : 0

  path      = var.generic_secret_path
  data_json = var.generic_secret_data_json

  // allow_read   = var.generic_secret_allow_read
  disable_read = var.generic_secret_disable_read

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}