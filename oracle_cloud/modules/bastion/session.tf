#-----------------------------------------------------------
# bastion session
#-----------------------------------------------------------
resource "oci_bastion_session" "session" {
  count = var.enable_session ? 1 : 0

  # Required
  bastion_id = var.session_bastion_id != "" && !var.enable_bastion ? var.session_bastion_id : element(oci_bastion_bastion.bastion.*.id, 0)

  dynamic "key_details" {
    iterator = key_details
    for_each = length(keys(var.session_key_details)) > 0 ? [var.session_key_details] : []

    content {
      # Required
      public_key_content = lookup(key_details.value, "public_key_content", null)
    }
  }

  dynamic "target_resource_details" {
    iterator = target_resource_details
    for_each = length(keys(var.session_target_resource_details)) > 0 ? [var.session_target_resource_details] : []

    content {
      # Required
      session_type = lookup(target_resource_details.value, "session_type", null)

      # Optional
      target_resource_fqdn                       = lookup(target_resource_details.value, "target_resource_fqdn", null)
      target_resource_id                         = lookup(target_resource_details.value, "target_resource_id", null)
      target_resource_operating_system_user_name = lookup(target_resource_details.value, "target_resource_operating_system_user_name", null)
      target_resource_port                       = lookup(target_resource_details.value, "target_resource_port", null)
      target_resource_private_ip_address         = lookup(target_resource_details.value, "target_resource_private_ip_address", null)
    }
  }

  # Optional
  display_name           = var.session_display_name != "" ? var.session_display_name : "${lower(var.name)}-bastion-session-${lower(var.environment)}"
  key_type               = var.session_key_type
  session_ttl_in_seconds = var.session_session_ttl_in_seconds

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.session_timeouts)) > 0 ? [var.session_timeouts] : []

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