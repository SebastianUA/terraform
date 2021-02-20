#---------------------------------------------------
# AWS KMS key
#---------------------------------------------------
resource "aws_kms_key" "kms_key" {
  count = var.enable_kms_key ? 1 : 0

  description             = var.kms_key_description
  deletion_window_in_days = var.kms_key_deletion_window_in_days
  key_usage               = upper(var.kms_key_key_usage)

  is_enabled               = var.kms_key_is_enabled
  policy                   = var.kms_key_policy
  enable_key_rotation      = var.kms_key_enable_key_rotation
  customer_master_key_spec = var.kms_key_customer_master_key_spec

  tags = merge(
    {
      Name = var.kms_key_name != "" ? var.kms_key_name : "${lower(var.name)}-kms-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
