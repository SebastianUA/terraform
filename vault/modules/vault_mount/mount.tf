#---------------------------------------------------
# Vault mount
#---------------------------------------------------
resource "vault_mount" "mount" {
  count = var.enable_mount ? 1 : 0

  path        = var.mount_path
  type        = var.mount_type
  description = var.mount_description

  default_lease_ttl_seconds = var.mount_default_lease_ttl_seconds
  max_lease_ttl_seconds     = var.mount_max_lease_ttl_seconds
  local                     = var.mount_local
  options                   = var.mount_options
  seal_wrap                 = var.mount_seal_wrap
  external_entropy_access   = var.mount_external_entropy_access

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}