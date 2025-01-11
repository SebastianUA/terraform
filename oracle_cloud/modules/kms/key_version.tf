#-----------------------------------------------------------
# kms key version
#-----------------------------------------------------------
resource "oci_kms_key_version" "kms_key_version" {
  count = var.enable_kms_key_version ? 1 : 0

  # Required
  key_id              = var.kms_key_version_key_id != "" && !var.enable_kms_key ? var.kms_key_version_key_id : element(oci_kms_key.kms_key.*.id, 0)
  management_endpoint = var.kms_key_version_management_endpoint

  # Optional
  external_key_version_id = var.kms_key_version_external_key_version_id != null ? var.kms_key_version_external_key_version_id : element(oci_kms_key_version.kms_key_version.*.id, 0)

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.kms_key_version_timeouts)) > 0 ? [var.kms_key_version_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}