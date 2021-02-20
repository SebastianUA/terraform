#---------------------------------------------------
# KSM external key
#---------------------------------------------------
resource "aws_kms_external_key" "kms_external_key" {
  count = var.enable_kms_external_key ? 1 : 0

  description             = var.kms_external_key_description
  enabled                 = var.kms_external_key_enabled
  policy                  = var.kms_external_key_policy
  valid_to                = var.kms_external_key_valid_to
  deletion_window_in_days = var.kms_external_key_deletion_window_in_days
  key_material_base64     = var.kms_external_key_key_material_base64

  tags = merge(
    {
      Name = var.kms_external_key_name != "" ? var.kms_external_key_name : "${lower(var.name)}-kms-external-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
