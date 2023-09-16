#---------------------------------------------------
# AWS rolesanywhere trust anchor
#---------------------------------------------------
resource "aws_rolesanywhere_trust_anchor" "rolesanywhere_trust_anchor" {
  count = var.enable_rolesanywhere_trust_anchor ? 1 : 0

  name    = var.rolesanywhere_trust_anchor_name != "" ? lower(var.rolesanywhere_trust_anchor_name) : "${lower(var.name)}-rolesanywhere-trust-anchor-${lower(var.environment)}"
  enabled = var.rolesanywhere_trust_anchor_enabled

  dynamic "source" {
    iterator = source
    for_each = length(var.rolesanywhere_trust_anchor_source) > 0 ? [var.rolesanywhere_trust_anchor_source] : []

    content {
      dynamic "source_data" {
        iterator = source_data
        for_each = length(keys(lookup(source.value, "source_data", {}))) > 0 ? [lookup(source.value, "source_data", {})] : []

        content {
          acm_pca_arn           = lookup(source_data.value, "acm_pca_arn", null)
          x509_certificate_data = lookup(source_data.value, "x509_certificate_data", null)
        }
      }
      source_type = lookup(source.value, "source_type", null)
    }
  }

  tags = merge(
    {
      Name = var.rolesanywhere_trust_anchor_name != "" ? lower(var.rolesanywhere_trust_anchor_name) : "${lower(var.name)}-rolesanywhere-trust-anchor-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}