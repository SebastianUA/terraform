#---------------------------------------------------
# AWS dms certificate
#---------------------------------------------------
resource "aws_dms_certificate" "dms_certificate" {
  for_each = { for k, v in var.dms_certificates : k => v if var.enable_dms_certificate }

  certificate_id = lookup(each.value, "certificate_id", null)

  certificate_pem    = lookup(each.value, "certificate_pem", null)
  certificate_wallet = lookup(each.value, "certificate_wallet", null)

  tags = merge(
    {
      Name = lookup(each.value, "name", "${lower(var.name)}-dms-certificate-${lower(var.environment)}-${each.key + 1}")
    },
    var.tags,
    lookup(each.value, "tags", {})
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}