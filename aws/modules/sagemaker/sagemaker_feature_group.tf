#---------------------------------------------------
# AWS sagemaker feature group
#---------------------------------------------------
resource "aws_sagemaker_feature_group" "sagemaker_feature_group" {
  count = var.enable_sagemaker_feature_group ? 1 : 0

  feature_group_name             = var.sagemaker_feature_group_name != "" ? lower(var.sagemaker_feature_group_name) : "${lower(var.name)}-sagemaker-feature-group-${lower(var.environment)}"
  record_identifier_feature_name = var.sagemaker_feature_group_record_identifier_feature_name != "" ? lower(var.sagemaker_feature_group_record_identifier_feature_name) : "${lower(var.name)}-sagemaker-feature-group-${lower(var.environment)}"
  event_time_feature_name        = var.sagemaker_feature_group_event_time_feature_name != "" ? lower(var.sagemaker_feature_group_event_time_feature_name) : "${lower(var.name)}-sagemaker-feature-group-${lower(var.environment)}"
  role_arn                       = var.sagemaker_feature_group_role_arn

  description = var.sagemaker_feature_group_description

  dynamic "feature_definition" {
    iterator = feature_definition
    for_each = var.sagemaker_feature_group_feature_definition
    content {
      feature_name = lookup(feature_definition.value, "feature_name", null)
      feature_type = lookup(feature_definition.value, "feature_type", null)
    }
  }

  offline_store_config {
    dynamic "s3_storage_config" {
      iterator = s3_storage_config
      for_each = var.sagemaker_feature_group_s3_storage_config
      content {
        s3_uri = lookup(s3_storage_config.value, "s3_uri", null)

        kms_key_id = lookup(s3_storage_config.value, "kms_key_id", null)
      }
    }

    dynamic "data_catalog_config" {
      iterator = data_catalog_config
      for_each = var.sagemaker_feature_group_data_catalog_config
      content {
        catalog    = lookup(data_catalog_config.value, "catalog", null)
        database   = lookup(data_catalog_config.value, "database", null)
        table_name = lookup(data_catalog_config.value, "table_name", null)
      }
    }

  }

  online_store_config {
    dynamic "security_config" {
      iterator = security_config
      for_each = var.sagemaker_feature_group_security_config
      content {
        kms_key_id = lookup(security_config.value, "kms_key_id", null)
      }
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
