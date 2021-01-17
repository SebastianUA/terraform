#---------------------------------------------------
# Vault generic endpoint
#---------------------------------------------------
resource "vault_generic_endpoint" "generic_endpoint" {
  count = var.enable_generic_endpoint ? 1 : 0

  path      = var.generic_endpoint_path
  data_json = var.generic_endpoint_data_json

  ignore_absent_fields = var.generic_endpoint_ignore_absent_fields
  disable_read         = var.generic_endpoint_disable_read
  disable_delete       = var.generic_endpoint_disable_delete
  write_fields         = var.generic_endpoint_write_fields

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
