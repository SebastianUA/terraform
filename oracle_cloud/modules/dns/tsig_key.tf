#-----------------------------------------------------------
# dns tsig key
#-----------------------------------------------------------
resource "oci_dns_tsig_key" "dns_tsig_key" {
  count = var.enable_dns_tsig_key ? 1 : 0

  # Required
  algorithm      = var.dns_tsig_key_algorithm
  compartment_id = var.compartment_id
  name           = var.dns_tsig_key_name != "" ? var.dns_tsig_key_name : "${lower(var.name)}-dns-tsig-key-${lower(var.environment)}"
  secret         = var.dns_tsig_key_secret

  # Optional
  defined_tags = var.dns_tsig_key_defined_tags
  freeform_tags = merge(
    {
      "Name" = var.dns_tsig_key_name != "" ? var.dns_tsig_key_name : "${lower(var.name)}-dns-tsig-key-${lower(var.environment)}"
    },
    var.tags
  )

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.dns_tsig_key_timeouts)) > 0 ? [var.dns_tsig_key_timeouts] : []

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