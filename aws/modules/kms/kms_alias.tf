#---------------------------------------------------
# AWS KMS alias
#---------------------------------------------------
resource "aws_kms_alias" "kms_alias" {
  count = var.enable_kms_alias ? 1 : 0

  name          = var.kms_alias_name
  name_prefix   = var.kms_alias_name_prefix
  target_key_id = var.kms_alias_target_key_id != "" ? var.kms_alias_target_key_id : (var.enable_kms_key ? element(concat(aws_kms_key.kms_key.*.key_id, [""]), 0) : null)

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_kms_key.kms_key
  ]
}
