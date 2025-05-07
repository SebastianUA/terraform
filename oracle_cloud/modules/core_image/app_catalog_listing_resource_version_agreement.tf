#-----------------------------------------------------------
# core app catalog listing resource version agreement
#-----------------------------------------------------------
resource "oci_core_app_catalog_listing_resource_version_agreement" "core_app_catalog_listing_resource_version_agreement" {
  count = var.enable_core_app_catalog_listing_resource_version_agreement ? 1 : 0

  # Required
  listing_id               = var.core_app_catalog_listing_resource_version_agreement_listing_id
  listing_resource_version = var.core_app_catalog_listing_resource_version_agreement_listing_resource_version

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}