#-----------------------------------------------------------
# identity domain
#-----------------------------------------------------------
resource "oci_identity_domain" "identity_domain" {
  count = var.enable_identity_domain ? 1 : 0

  # Required
  compartment_id = var.compartment_id
  description    = var.identity_domain_description
  display_name   = var.identity_domain_display_name != "" ? var.identity_domain_display_name : "${lower(var.name)}-identity-domain-${lower(var.environment)}"
  home_region    = var.identity_domain_home_region
  license_type   = var.identity_domain_license_type

  # Optional
  admin_email               = var.identity_domain_admin_email
  admin_first_name          = var.identity_domain_admin_first_name
  admin_last_name           = var.identity_domain_admin_last_name
  admin_user_name           = var.identity_domain_admin_user_name != "" && !var.enable_identity_user ? var.identity_domain_admin_user_name : (var.enable_identity_user ? element(oci_identity_user.identity_user.*.name, 0) : null)
  is_hidden_on_login        = var.identity_domain_is_hidden_on_login
  is_notification_bypassed  = var.identity_domain_is_notification_bypassed
  is_primary_email_required = var.identity_domain_is_primary_email_required

  defined_tags = var.identity_domain_defined_tags
  freeform_tags = merge(
    {
      "Name" = var.identity_domain_display_name != "" ? var.identity_domain_display_name : "${lower(var.name)}-identity-domain-${lower(var.environment)}"
    },
    var.tags
  )

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.identity_domain_timeouts)) > 0 ? [var.identity_domain_timeouts] : []

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