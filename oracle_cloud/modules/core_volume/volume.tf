#-----------------------------------------------------------
# core volume
#-----------------------------------------------------------
resource "oci_core_volume" "core_volume" {
  count = var.enable_core_volume ? 1 : 0

  # Required
  compartment_id = var.core_volume_compartment_id

  # Optional
  availability_domain            = var.core_volume_availability_domain
  backup_policy_id               = var.core_volume_backup_policy_id
  cluster_placement_group_id     = var.core_volume_cluster_placement_group_id
  display_name                   = var.core_volume_display_name != "" ? var.core_volume_display_name : "${lower(var.name)}-volume-${lower(var.environment)}"
  is_auto_tune_enabled           = var.core_volume_is_auto_tune_enabled
  kms_key_id                     = var.core_volume_kms_key_id
  size_in_gbs                    = var.core_volume_size_in_gbs
  size_in_mbs                    = var.core_volume_size_in_mbs
  vpus_per_gb                    = var.core_volume_vpus_per_gb
  xrc_kms_key_id                 = var.core_volume_xrc_kms_key_id
  block_volume_replicas_deletion = var.core_volume_block_volume_replicas_deletion

  dynamic "autotune_policies" {
    iterator = autotune_policies
    for_each = length(keys(var.core_volume_autotune_policies)) > 0 ? [var.core_volume_autotune_policies] : []

    content {
      # Required
      autotune_type = lookup(autotune_policies.value, "autotune_type", null)

      #Optional
      max_vpus_per_gb = lookup(autotune_policies.value, "autotune_type", null)
    }
  }

  dynamic "block_volume_replicas" {
    iterator = block_volume_replicas
    for_each = length(keys(var.core_volume_block_volume_replicas)) > 0 ? [var.core_volume_block_volume_replicas] : []

    content {
      # Required
      availability_domain = lookup(block_volume_replicas.value, "availability_domain", null)

      # Optional
      display_name   = lookup(block_volume_replicas.value, "display_name", null)
      xrr_kms_key_id = lookup(block_volume_replicas.value, "xrr_kms_key_id", null)
    }
  }

  dynamic "source_details" {
    iterator = source_details
    for_each = length(keys(var.core_volume_source_details)) > 0 ? [var.core_volume_source_details] : []

    content {
      # Required
      type = var.volume_source_details_type

      # Optional
      change_block_size_in_bytes = lookup(source_details.value, "change_block_size_in_bytes", null)
      first_backup_id            = lookup(source_details.value, "first_backup_id", null)
      id                         = lookup(source_details.value, "id", null)
      second_backup_id           = lookup(source_details.value, "second_backup_id", null)
    }
  }

  defined_tags = var.core_volume_defined_tags
  freeform_tags = merge(
    {
      "Name" = var.core_volume_display_name != "" ? var.core_volume_display_name : "${lower(var.name)}-volume-${lower(var.environment)}"
    },
    var.tags
  )

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.core_volume_timeouts)) > 0 ? [var.core_volume_timeouts] : []

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