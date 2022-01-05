#---------------------------------------------------
# AWS glue security configuration
#---------------------------------------------------
resource "aws_glue_security_configuration" "glue_security_configuration" {
  count = var.enable_glue_security_configuration ? 1 : 0

  name = var.glue_security_configuration_name != "" ? lower(var.glue_security_configuration_name) : "${lower(var.name)}-glue-sec-conf-${lower(var.environment)}"

  encryption_configuration {
    dynamic "cloudwatch_encryption" {
      iterator = cloudwatch_encryption
      for_each = lookup(var.glue_security_configuration_encryption_configuration, "cloudwatch_encryption", [])

      content {
        cloudwatch_encryption_mode = lookup(cloudwatch_encryption.value, "cloudwatch_encryption_mode", null)
        kms_key_arn                = lookup(cloudwatch_encryption.value, "kms_key_arn", null)
      }
    }

    dynamic "job_bookmarks_encryption" {
      iterator = job_bookmarks_encryption
      for_each = lookup(var.glue_security_configuration_encryption_configuration, "job_bookmarks_encryption", [])

      content {
        job_bookmarks_encryption_mode = lookup(job_bookmarks_encryption.value, "job_bookmarks_encryption_mode", null)
        kms_key_arn                   = lookup(job_bookmarks_encryption.value, "kms_key_arn", null)
      }
    }

    dynamic "s3_encryption" {
      iterator = s3_encryption
      for_each = lookup(var.glue_security_configuration_encryption_configuration, "s3_encryption", [])

      content {
        s3_encryption_mode = lookup(s3_encryption.value, "s3_encryption_mode", null)
        kms_key_arn        = lookup(s3_encryption.value, "kms_key_arn", null)
      }
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
