#-----------------------------------------------------------
# identity domain replication to region
#-----------------------------------------------------------
resource "oci_identity_domain_replication_to_region" "identity_domain_replication_to_region" {
  count = var.enable_identity_domain_replication_to_region ? 1 : 0

  # Required
  domain_id = var.identity_domain_replication_to_region_domain_id != "" && !var.enable_identity_domain ? var.identity_domain_replication_to_region_domain_id : (var.enable_identity_domain ? element(oci_identity_domain.identity_domain.*.id, 0) : null)

  # Optional
  replica_region = var.identity_domain_replication_to_region_replica_region

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.identity_domain_replication_to_region_timeouts)) > 0 ? [var.identity_domain_replication_to_region_timeouts] : []

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