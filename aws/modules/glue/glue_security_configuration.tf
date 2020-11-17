#---------------------------------------------------
# AWS glue security configuration
#---------------------------------------------------
resource "aws_glue_security_configuration" "glue_security_configuration" {
  count = var.enable_glue_security_configuration ? 1 : 0

  name = var.glue_security_configuration_name != "" ? lower(var.glue_security_configuration_name) : "${lower(var.name)}-glue-sec-conf-${lower(var.environment)}"

  encryption_configuration {
    cloudwatch_encryption {
      cloudwatch_encryption_mode = var.glue_security_configuration_cloudwatch_encryption_mode
      kms_key_arn                = var.glue_security_configuration_cloudwatch_encryption_kms_key_arn
    }

    job_bookmarks_encryption {
      job_bookmarks_encryption_mode = var.glue_security_configuration_job_bookmarks_encryption_job_bookmarks_encryption_mode
      kms_key_arn                   = var.glue_security_configuration_job_bookmarks_encryption_kms_key_arn
    }

    s3_encryption {
      s3_encryption_mode = var.glue_security_configuration_s3_encryption_s3_encryption_mode
      kms_key_arn        = var.glue_security_configuration_s3_encryption_kms_key_arn
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
