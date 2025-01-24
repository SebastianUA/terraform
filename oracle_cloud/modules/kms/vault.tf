#-----------------------------------------------------------
# kms vault
#-----------------------------------------------------------
resource "oci_kms_vault" "kms_vault" {
  count = var.enable_kms_vault ? 1 : 0

  # Required
  compartment_id = var.kms_vault_compartment_id
  display_name   = var.kms_vault_display_name != "" ? var.kms_vault_display_name : "${lower(var.name)}-kms-vault-${lower(var.environment)}"
  vault_type     = var.kms_vault_vault_type

  # Optional
  dynamic "external_key_manager_metadata" {
    iterator = external_key_manager_metadata
    for_each = length(keys(var.kms_verify_external_key_manager_metadata)) > 0 ? [var.kms_verify_external_key_manager_metadata] : []

    content {
      # Required
      external_vault_endpoint_url = lookup(external_key_manager_metadata.value, "external_vault_endpoint_url", null)

      dynamic "oauth_metadata" {
        iterator = oauth_metadata
        for_each = length(keys(lookup(external_key_manager_metadata.value, "oauth_metadata", {}))) > 0 ? [lookup(external_key_manager_metadata.value, "oauth_metadata", {})] : []

        content {
          # Required
          client_app_id         = lookup(oauth_metadata.value, "client_app_id", null)
          client_app_secret     = lookup(oauth_metadata.value, "client_app_secret", null)
          idcs_account_name_url = lookup(oauth_metadata.value, "idcs_account_name_url", null)
        }
      }

      private_endpoint_id = lookup(external_key_manager_metadata.value, "private_endpoint_id", null)
    }
  }

  defined_tags = var.kms_vault_defined_tags
  freeform_tags = merge(
    {
      "Name" = var.kms_vault_display_name != "" ? var.kms_vault_display_name : "${lower(var.name)}-kms-vault-${lower(var.environment)}"
    },
    var.tags
  )

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.kms_vault_timeouts)) > 0 ? [var.kms_vault_timeouts] : []

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