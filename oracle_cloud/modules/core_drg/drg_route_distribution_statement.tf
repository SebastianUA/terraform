#-----------------------------------------------------------
# core drg route distribution statement
#-----------------------------------------------------------
resource "oci_core_drg_route_distribution_statement" "core_drg_route_distribution_statement" {
  count = var.enable_core_drg_route_distribution_statement ? 1 : 0

  # Required
  drg_route_distribution_id = var.core_drg_route_distribution_statement_drg_route_distribution_id != "" && !var.enable_drg_route_distribution ? var.core_drg_route_distribution_statement_drg_route_distribution_id : (var.enable_drg_route_distribution ? element(oci_core_drg_route_distribution.core_drg_route_distribution.*.id, 0) : null)
  action                    = var.core_drg_route_distribution_statement_action

  dynamic "match_criteria" {
    iterator = match_criteria
    for_each = length(keys(var.core_drg_route_distribution_statement_match_criteria)) > 0 ? [var.core_drg_route_distribution_statement_match_criteria] : []

    content {
      # Required
      match_type = lookup(match_criteria.value, "match_type", null)

      # Optional
      attachment_type   = lookup(match_criteria.value, "attachment_type", null)
      drg_attachment_id = lookup(match_criteria.value, "drg_attachment_id", (var.enable_core_drg_attachment ? element(oci_core_drg_attachment.core_drg_attachment.*.id, 0) : null))
    }
  }

  # Optional
  priority = var.core_drg_route_distribution_statement_priority

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.core_drg_route_distribution_statement_timeouts)) > 0 ? [var.core_drg_route_distribution_statement_timeouts] : []

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