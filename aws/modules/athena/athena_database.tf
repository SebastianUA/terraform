#---------------------------------------------------
# AWS athena database
#---------------------------------------------------
resource "aws_athena_database" "athena_database" {
  count = var.enable_athena_database ? 1 : 0

  name   = var.athena_database_name != "" ? var.athena_database_name : "${lower(var.name)}-athena-db-${lower(var.environment)}"
  bucket = var.athena_database_bucket

  force_destroy = var.athena_database_force_destroy

  dynamic "encryption_configuration" {
    iterator = encryption_configuration
    for_each = var.athena_database_encryption_configuration

    content {
      encryption_option = lookup(encryption_configuration.value, "encryption_option", null)

      kms_key = lookup(encryption_configuration.value, "kms_key", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
