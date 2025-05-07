#-----------------------------------------------------------
# kms vault replication
#-----------------------------------------------------------
resource "oci_kms_vault_replication" "kms_vault_replication" {
  count = var.enable_kms_vault_replication ? 1 : 0

  # Required
  vault_id       = var.kms_vault_replication_vault_id != "" && !var.enable_kms_vault ? var.kms_vault_replication_vault_id : element(oci_kms_vault.kms_vault.*.id, 0)
  replica_region = var.kms_vault_replication_replica_region

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}