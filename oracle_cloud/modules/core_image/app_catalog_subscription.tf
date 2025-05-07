#-----------------------------------------------------------
# core app catalog subscription
#-----------------------------------------------------------
resource "oci_core_app_catalog_subscription" "core_app_catalog_subscription" {
  count = var.enable_core_app_catalog_subscription ? 1 : 0

  # Required
  compartment_id           = var.compartment_id
  listing_id               = var.core_app_catalog_subscription_listing_id
  listing_resource_version = var.core_app_catalog_subscription_listing_resource_version
  oracle_terms_of_use_link = var.core_app_catalog_subscription_oracle_terms_of_use_link
  signature                = var.core_app_catalog_subscription_signature
  time_retrieved           = var.core_app_catalog_subscription_time_retrieved

  # Optional
  eula_link = var.core_app_catalog_subscription_eula_link

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.core_app_catalog_subscription_timeouts)) > 0 ? [var.core_app_catalog_subscription_timeouts] : []

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