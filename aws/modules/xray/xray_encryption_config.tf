#---------------------------------------------------
# AWS xray encryption config
#---------------------------------------------------
resource "aws_xray_encryption_config" "xray_encryption_config" {
  count = var.enable_xray_encryption_config ? 1 : 0

  type = var.xray_encryption_config_type

  key_id = var.xray_encryption_config_key_id

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
