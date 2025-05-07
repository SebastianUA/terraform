#-----------------------------------------------------------
# core volume group
#-----------------------------------------------------------
resource "oci_core_volume_group" "core_volume_group" {
  count = var.enable_core_volume_group ? 1 : 0

  # Required
  availability_domain = var.core_volume_group_availability_domain
  compartment_id      = var.compartment_id

  dynamic "source_details" {
    iterator = source_details
    for_each = var.core_volume_group_source_details

    content {
      # Required
      type       = lookup(source_details.value, "type", null)
      volume_ids = lookup(source_details.value, "volume_ids", null)
    }
  }

  # Optional
  backup_policy_id           = var.core_volume_group_backup_policy_id
  cluster_placement_group_id = var.core_volume_group_cluster_placement_group_id
  display_name               = var.core_volume_group_display_name != "" ? var.core_volume_group_display_name : "${lower(var.name)}-volume-group-${lower(var.environment)}"
  volume_ids                 = var.core_volume_group_volume_ids
  xrc_kms_key_id             = var.core_volume_group_xrc_kms_key_id

  dynamic "volume_group_replicas" {
    iterator = volume_group_replicas
    for_each = var.core_volume_group_volume_group_replicas

    content {
      # Required
      availability_domain = lookup(volume_group_replicas.value, "create", null)

      # Optional
      display_name   = lookup(volume_group_replicas.value, "display_name", null)
      xrr_kms_key_id = lookup(volume_group_replicas.value, "xrr_kms_key_id", null)
    }
  }

  defined_tags = var.core_volume_group_defined_tags
  freeform_tags = merge(
    {
      "Name" = var.core_volume_group_display_name != "" ? var.core_volume_group_display_name : "${lower(var.name)}-volume-group-${lower(var.environment)}"
    },
    var.tags
  )

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.core_volume_group_timeouts)) > 0 ? [var.core_volume_group_timeouts] : []

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