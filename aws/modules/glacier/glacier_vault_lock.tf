#---------------------------------------------------
# AWS glacier vault lock
#---------------------------------------------------
resource "aws_glacier_vault_lock" "glacier_vault_lock" {
  count = var.enable_glacier_vault_lock ? 1 : 0

  complete_lock = var.glacier_vault_lock_complete_lock
  policy        = var.glacier_vault_lock_policy
  vault_name    = var.glacier_vault_lock_vault_name != "" && !var.enable_glacier_vault ? var.glacier_vault_lock_vault_name : element(concat(aws_glacier_vault.glacier_vault.*.id, [""]), 0)

  ignore_deletion_error = var.glacier_vault_lock_ignore_deletion_error

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_glacier_vault.glacier_vault
  ]
}
