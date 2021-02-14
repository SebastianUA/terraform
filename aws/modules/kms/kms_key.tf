#---------------------------------------------------
# Create AWS KMS key
#---------------------------------------------------
resource "aws_kms_key" "kms_key" {
  count = var.enable_kms_key ? 1 : 0

  description             = var.description
  deletion_window_in_days = var.deletion_window_in_days
  key_usage               = upper(var.key_usage)

  is_enabled          = var.is_enabled
  policy              = var.policy
  enable_key_rotation = var.enable_key_rotation

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
