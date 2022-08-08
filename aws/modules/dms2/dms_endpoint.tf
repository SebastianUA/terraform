resource "aws_dms_endpoint" "dms_endpoint" {
  for_each = { for k, v in var.dms_endpoints : k => v if var.enable_dms_endpoint }

  endpoint_type = lookup(each.value, "endpoint_type", null)
  engine_name   = lookup(each.value, "engine_name", null)
  endpoint_id   = lookup(each.value, "endpoint_id", "${lower(var.name)}-dms-endpoint-${lower(var.environment)}")
  # lookup(each.value, "endpoint_id", "${lower(var.name)}-dms-endpoint-${lower(var.environment)}-${each.key + 1}")

  certificate_arn             = lookup(each.value, "certificate_arn", (var.enable_dms_certificate ? try(aws_dms_certificate.dms_certificate[each.value.certificate_key].certificate_arn, null) : null))
  database_name               = lookup(each.value, "database_name", null)
  extra_connection_attributes = lookup(each.value, "extra_connection_attributes", null)
  kms_key_arn                 = lookup(each.value, "kms_key_arn", null)
  password                    = lookup(each.value, "password", null)
  port                        = lookup(each.value, "port", null)
  username                    = lookup(each.value, "username", null)
  server_name                 = lookup(each.value, "server_name", null)
  ssl_mode                    = lookup(each.value, "ssl_mode", null)
  service_access_role         = lookup(each.value, "service_access_role", null)

  # https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Target.Elasticsearch.html
  dynamic "elasticsearch_settings" {
    iterator = elasticsearch_settings
    for_each = length(lookup(each.value, "elasticsearch_settings", {})) == 0 ? [] : [each.value.elasticsearch_settings]

    content {
      endpoint_uri            = lookup(elasticsearch_settings.value, "endpoint_uri", null)
      service_access_role_arn = lookup(elasticsearch_settings.value, "service_access_role_arn", null)

      error_retry_duration       = lookup(elasticsearch_settings.value, "error_retry_duration", null)
      full_load_error_percentage = lookup(elasticsearch_settings.value, "full_load_error_percentage", null)
    }
  }

  # https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Target.Kafka.html
  dynamic "kafka_settings" {
    iterator = kafka_settings
    for_each = length(lookup(each.value, "kafka_settings", {})) == 0 ? [] : [each.value.kafka_settings]

    content {
      broker = lookup(kafka_settings.value, "broker", null)

      topic             = lookup(kafka_settings.value, "topic", null)
      message_format    = lookup(kafka_settings.value, "message_format", null)
      message_max_bytes = lookup(kafka_settings.value, "message_max_bytes", null)

      partition_include_schema_table = lookup(kafka_settings.value, "partition_include_schema_table", null)
      no_hex_prefix                  = lookup(kafka_settings.value, "no_hex_prefix", null)

      include_control_details        = lookup(kafka_settings.value, "include_control_details", null)
      include_null_and_empty         = lookup(kafka_settings.value, "include_null_and_empty", null)
      include_partition_value        = lookup(kafka_settings.value, "include_partition_value", null)
      include_table_alter_operations = lookup(kafka_settings.value, "include_table_alter_operations", null)
      include_transaction_details    = lookup(kafka_settings.value, "include_transaction_details", null)

      ssl_ca_certificate_arn     = lookup(kafka_settings.value, "ssl_ca_certificate_arn", null)
      ssl_client_certificate_arn = lookup(kafka_settings.value, "ssl_client_certificate_arn", null)
      ssl_client_key_arn         = lookup(kafka_settings.value, "ssl_client_key_arn", null)
      ssl_client_key_password    = lookup(kafka_settings.value, "ssl_client_key_password", null)

      sasl_password     = lookup(kafka_settings.value, "sasl_password", null)
      sasl_username     = lookup(kafka_settings.value, "sasl_username", null)
      security_protocol = lookup(kafka_settings.value, "security_protocol", null)
    }
  }

  # https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Target.Kinesis.html
  dynamic "kinesis_settings" {
    iterator = kinesis_settings
    for_each = length(lookup(each.value, "kinesis_settings", {})) == 0 ? [] : [each.value.kinesis_settings]

    content {
      message_format          = lookup(kinesis_settings.value, "message_format", null)
      service_access_role_arn = lookup(kinesis_settings.value, "service_access_role_arn", null)
      stream_arn              = lookup(kinesis_settings.value, "stream_arn", null)

      partition_include_schema_table = lookup(kinesis_settings.value, "partition_include_schema_table", null)

      include_control_details        = lookup(kinesis_settings.value, "include_control_details", null)
      include_null_and_empty         = lookup(kinesis_settings.value, "include_null_and_empty", null)
      include_partition_value        = lookup(kinesis_settings.value, "include_partition_value", null)
      include_table_alter_operations = lookup(kinesis_settings.value, "include_table_alter_operations", null)
      include_transaction_details    = lookup(kinesis_settings.value, "include_transaction_details", null)
    }
  }

  # https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Source.MongoDB.html
  dynamic "mongodb_settings" {
    iterator = mongodb_settings
    for_each = length(lookup(each.value, "mongodb_settings", {})) == 0 ? [] : [each.value.mongodb_settings]

    content {
      auth_mechanism      = lookup(mongodb_settings.value, "auth_mechanism", null)
      auth_source         = lookup(mongodb_settings.value, "auth_source", null)
      auth_type           = lookup(mongodb_settings.value, "auth_type", null)
      docs_to_investigate = lookup(mongodb_settings.value, "docs_to_investigate", null)
      extract_doc_id      = lookup(mongodb_settings.value, "extract_doc_id", null)
      nesting_level       = lookup(mongodb_settings.value, "nesting_level", null)
    }
  }

  # https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Source.S3.html
  # https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Target.S3.html
  dynamic "s3_settings" {
    iterator = s3_settings
    for_each = length(lookup(each.value, "s3_settings", {})) == 0 ? [] : [each.value.s3_settings]

    content {
      bucket_folder                     = lookup(s3_settings.value, "bucket_folder", null)
      bucket_name                       = lookup(s3_settings.value, "bucket_name", null)
      compression_type                  = lookup(s3_settings.value, "compression_type", null)
      csv_delimiter                     = lookup(s3_settings.value, "csv_delimiter", null)
      csv_row_delimiter                 = lookup(s3_settings.value, "csv_row_delimiter", null)
      csv_no_sup_value                  = lookup(s3_settings.value, "csv_no_sup_value", null)
      csv_null_value                    = lookup(s3_settings.value, "csv_null_value", null)
      date_partition_enabled            = lookup(s3_settings.value, "date_partition_enabled", null)
      data_format                       = lookup(s3_settings.value, "data_format", null)
      data_page_size                    = lookup(s3_settings.value, "data_page_size", null)
      date_partition_delimiter          = lookup(s3_settings.value, "date_partition_delimiter", null)
      date_partition_sequence           = lookup(s3_settings.value, "date_partition_sequence", null)
      external_table_definition         = lookup(s3_settings.value, "external_table_definition", null)
      service_access_role_arn           = lookup(s3_settings.value, "service_access_role_arn", null)
      add_column_name                   = lookup(s3_settings.value, "add_column_name", null)
      canned_acl_for_objects            = lookup(s3_settings.value, "canned_acl_for_objects", null)
      cdc_inserts_and_updates           = lookup(s3_settings.value, "cdc_inserts_and_updates", null)
      cdc_inserts_only                  = lookup(s3_settings.value, "cdc_inserts_only", null)
      cdc_max_batch_interval            = lookup(s3_settings.value, "cdc_max_batch_interval", null)
      cdc_min_file_size                 = lookup(s3_settings.value, "cdc_min_file_size", null)
      cdc_path                          = lookup(s3_settings.value, "cdc_path", null)
      dict_page_size_limit              = lookup(s3_settings.value, "dict_page_size_limit", null)
      enable_statistics                 = lookup(s3_settings.value, "enable_statistics", null)
      encoding_type                     = lookup(s3_settings.value, "encoding_type", null)
      encryption_mode                   = lookup(s3_settings.value, "encryption_mode", null)
      ignore_headers_row                = lookup(s3_settings.value, "ignore_headers_row", null)
      include_op_for_full_load          = lookup(s3_settings.value, "include_op_for_full_load", null)
      max_file_size                     = lookup(s3_settings.value, "max_file_size", null)
      parquet_timestamp_in_millisecond  = lookup(s3_settings.value, "parquet_timestamp_in_millisecond", null)
      parquet_version                   = lookup(s3_settings.value, "parquet_version", null)
      preserve_transactions             = lookup(s3_settings.value, "preserve_transactions", null)
      rfc_4180                          = lookup(s3_settings.value, "rfc_4180", null)
      row_group_length                  = lookup(s3_settings.value, "row_group_length", null)
      server_side_encryption_kms_key_id = lookup(s3_settings.value, "server_side_encryption_kms_key_id", null)
      timestamp_column_name             = lookup(s3_settings.value, "timestamp_column_name", null)
      use_csv_no_sup_value              = lookup(s3_settings.value, "use_csv_no_sup_value", null)
    }
  }

  tags = merge(
    {
      Name = lookup(each.value, "endpoint_id", "${lower(var.name)}-dms-endpoint-${lower(var.environment)}-${replace(each.key, "_", "-")}")
    },
    var.tags,
    lookup(each.value, "tags", {})
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}