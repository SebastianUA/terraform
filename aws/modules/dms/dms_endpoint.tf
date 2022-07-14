#---------------------------------------------------
# AWS dms endpoint
#---------------------------------------------------
resource "aws_dms_endpoint" "dms_endpoint" {
  count = var.enable_dms_endpoint ? 1 : 0

  endpoint_type = var.dms_endpoint_endpoint_type
  engine_name   = var.dms_endpoint_engine_name
  endpoint_id   = var.dms_endpoint_endpoint_id != "" ? lower(var.dms_endpoint_endpoint_id) : "${lower(var.name)}-dms-endpoint-${lower(var.environment)}"

  certificate_arn             = var.dms_endpoint_certificate_arn
  database_name               = var.dms_endpoint_database_name
  extra_connection_attributes = var.dms_endpoint_extra_connection_attributes
  kms_key_arn                 = var.dms_endpoint_kms_key_arn
  password                    = var.dms_endpoint_password
  port                        = var.dms_endpoint_port
  username                    = var.dms_endpoint_username
  server_name                 = var.dms_endpoint_server_name
  ssl_mode                    = var.dms_endpoint_ssl_mode
  service_access_role         = var.dms_endpoint_service_access_role

  dynamic "elasticsearch_settings" {
    iterator = elasticsearch_settings
    for_each = length(keys(var.dms_endpoint_elasticsearch_settings)) > 0 ? [var.dms_endpoint_elasticsearch_settings] : []

    content {
      endpoint_uri            = lookup(elasticsearch_settings.value, "endpoint_uri", null)
      service_access_role_arn = lookup(elasticsearch_settings.value, "service_access_role_arn", null)

      error_retry_duration       = lookup(elasticsearch_settings.value, "error_retry_duration", null)
      full_load_error_percentage = lookup(elasticsearch_settings.value, "full_load_error_percentage", null)
    }
  }

  dynamic "kafka_settings" {
    iterator = kafka_settings
    for_each = length(keys(var.dms_endpoint_kafka_settings)) > 0 ? [var.dms_endpoint_kafka_settings] : []

    content {
      broker = lookup(kafka_settings.value, "broker", null)

      topic = lookup(kafka_settings.value, "topic", null)
    }
  }

  dynamic "kinesis_settings" {
    iterator = kinesis_settings
    for_each = length(keys(var.dms_endpoint_kinesis_settings)) > 0 ? [var.dms_endpoint_kinesis_settings] : []

    content {
      message_format          = lookup(kinesis_settings.value, "message_format", null)
      service_access_role_arn = lookup(kinesis_settings.value, "service_access_role_arn", null)
      stream_arn              = lookup(kinesis_settings.value, "stream_arn", null)
    }
  }

  dynamic "mongodb_settings" {
    iterator = mongodb_settings
    for_each = length(keys(var.dms_endpoint_mongodb_settings)) > 0 ? [var.dms_endpoint_mongodb_settings] : []

    content {
      auth_mechanism      = lookup(mongodb_settings.value, "auth_mechanism", null)
      auth_source         = lookup(mongodb_settings.value, "auth_source", null)
      auth_type           = lookup(mongodb_settings.value, "auth_type", null)
      docs_to_investigate = lookup(mongodb_settings.value, "docs_to_investigate", null)
      extract_doc_id      = lookup(mongodb_settings.value, "extract_doc_id", null)
      nesting_level       = lookup(mongodb_settings.value, "nesting_level", null)
    }
  }

  dynamic "s3_settings" {
    iterator = s3_settings
    for_each = length(keys(var.dms_endpoint_s3_settings)) > 0 ? [var.dms_endpoint_s3_settings] : []

    content {
      bucket_folder             = lookup(s3_settings.value, "bucket_folder", null)
      bucket_name               = lookup(s3_settings.value, "bucket_name", null)
      compression_type          = lookup(s3_settings.value, "compression_type", null)
      csv_delimiter             = lookup(s3_settings.value, "csv_delimiter", null)
      csv_row_delimiter         = lookup(s3_settings.value, "csv_row_delimiter", null)
      date_partition_enabled    = lookup(s3_settings.value, "date_partition_enabled", null)
      external_table_definition = lookup(s3_settings.value, "external_table_definition", null)
      service_access_role_arn   = lookup(s3_settings.value, "service_access_role_arn", null)
    }
  }

  tags = merge(
    {
      Name = var.dms_endpoint_endpoint_id != "" ? lower(var.dms_endpoint_endpoint_id) : "${lower(var.name)}-dms-endpoint-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}