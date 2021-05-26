#---------------------------------------------------
# AWS Glue data catalog encryption settings
#---------------------------------------------------
resource "aws_glue_data_catalog_encryption_settings" "glue_data_catalog_encryption_settings" {
  count = var.enable_glue_data_catalog_encryption_settings ? 1 : 0

  catalog_id = var.glue_data_catalog_encryption_settings_catalog_id

  data_catalog_encryption_settings {
    dynamic "connection_password_encryption" {
      iterator = connection_password_encryption
      for_each = var.glue_data_catalog_encryption_settings_connection_password_encryption

      content {
        aws_kms_key_id                       = lookup(connection_password_encryption.value, "aws_kms_key_id", null)
        return_connection_password_encrypted = lookup(connection_password_encryption.value, "return_connection_password_encrypted", null)
      }
    }

    dynamic "encryption_at_rest" {
      iterator = encryption_at_rest
      for_each = var.glue_data_catalog_encryption_settings_encryption_at_rest

      content {
        catalog_encryption_mode = lookup(encryption_at_rest.value, "catalog_encryption_mode", null)
        sse_aws_kms_key_id      = lookup(encryption_at_rest.value, "sse_aws_kms_key_id", null)
      }
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_glue_catalog_database.glue_catalog_database
  ]
}