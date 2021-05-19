#---------------------------------------------------
# AWS elastictranscoder pipeline
#---------------------------------------------------
resource "aws_elastictranscoder_pipeline" "elastictranscoder_pipeline" {
  count = var.enable_elastictranscoder_pipeline ? 1 : 0

  input_bucket = var.elastictranscoder_pipeline_input_bucket
  role         = var.elastictranscoder_pipeline_role

  name            = var.elastictranscoder_pipeline_name != null ? lower(var.elastictranscoder_pipeline_name) : "${lower(var.name)}-elastictranscoder-pipeline-${lower(var.environment)}"
  output_bucket   = var.elastictranscoder_pipeline_output_bucket
  aws_kms_key_arn = var.elastictranscoder_pipeline_aws_kms_key_arn

  dynamic "content_config" {
    iterator = content_config
    for_each = var.elastictranscoder_pipeline_content_config

    content {
      bucket        = lookup(content_config.value, "bucket", null)
      storage_class = lookup(content_config.value, "storage_class", null)
    }
  }

  dynamic "content_config_permissions" {
    iterator = content_config_permissions
    for_each = var.elastictranscoder_pipeline_content_config_permissions

    content {
      access       = lookup(content_config_permissions.value, "access", null)
      grantee      = lookup(content_config_permissions.value, "grantee", null)
      grantee_type = lookup(content_config_permissions.value, "grantee_type", null)
    }
  }

  dynamic "notifications" {
    iterator = notifications
    for_each = var.elastictranscoder_pipeline_notifications

    content {
      completed   = lookup(notifications.value, "completed", null)
      error       = lookup(notifications.value, "error", null)
      progressing = lookup(notifications.value, "progressing", null)
      warning     = lookup(notifications.value, "warning", null)
    }
  }

  dynamic "thumbnail_config" {
    iterator = thumbnail_config
    for_each = var.elastictranscoder_pipeline_thumbnail_config

    content {
      bucket        = lookup(thumbnail_config.value, "bucket", null)
      storage_class = lookup(thumbnail_config.value, "storage_class", null)
    }
  }

  dynamic "thumbnail_config_permissions" {
    iterator = thumbnail_config_permissions
    for_each = var.elastictranscoder_pipeline_thumbnail_config_permissions

    content {
      access       = lookup(thumbnail_config_permissions.value, "access", null)
      grantee      = lookup(thumbnail_config_permissions.value, "grantee", null)
      grantee_type = lookup(thumbnail_config_permissions.value, "grantee_type", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
