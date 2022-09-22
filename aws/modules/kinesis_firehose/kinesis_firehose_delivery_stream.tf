#---------------------------------------------------
# AWS kinesis firehose delivery stream
#---------------------------------------------------
resource "aws_kinesis_firehose_delivery_stream" "kinesis_firehose_delivery_stream" {
  count = var.enable_kinesis_firehose_delivery_stream ? 1 : 0

  name        = var.kinesis_firehose_delivery_stream_name != "" ? var.kinesis_firehose_delivery_stream_name : "${lower(var.name)}-kinesis-firehose-${lower(var.environment)}"
  destination = var.kinesis_firehose_delivery_stream_destination

  dynamic "kinesis_source_configuration" {
    iterator = kinesis_source_configuration
    for_each = length(keys(var.kinesis_firehose_delivery_stream_kinesis_source_configuration)) > 0 ? [var.kinesis_firehose_delivery_stream_kinesis_source_configuration] : []

    content {
      kinesis_stream_arn = lookup(kinesis_source_configuration.value, "kinesis_stream_arn", null)
      role_arn           = lookup(kinesis_source_configuration.value, "role_arn", null)
    }
  }

  dynamic "server_side_encryption" {
    iterator = server_side_encryption
    for_each = length(keys(var.kinesis_firehose_delivery_stream_server_side_encryption)) > 0 ? [var.kinesis_firehose_delivery_stream_server_side_encryption] : []

    content {
      enabled  = lookup(server_side_encryption.value, "enabled", null)
      key_type = lookup(server_side_encryption.value, "key_type", null)
      key_arn  = lookup(server_side_encryption.value, "key_arn", null)
    }
  }

  dynamic "s3_configuration" {
    iterator = s3_configuration
    for_each = length(keys(var.kinesis_firehose_delivery_stream_s3_configuration)) > 0 ? [var.kinesis_firehose_delivery_stream_s3_configuration] : []

    content {
      role_arn   = lookup(s3_configuration.value, "role_arn", null)
      bucket_arn = lookup(s3_configuration.value, "bucket_arn", null)

      prefix              = lookup(s3_configuration.value, "prefix", null)
      buffer_size         = lookup(s3_configuration.value, "buffer_size", null)
      buffer_interval     = lookup(s3_configuration.value, "buffer_interval", null)
      compression_format  = lookup(s3_configuration.value, "compression_format", null)
      error_output_prefix = lookup(s3_configuration.value, "error_output_prefix", null)
      kms_key_arn         = lookup(s3_configuration.value, "kms_key_arn", null)
      dynamic "cloudwatch_logging_options" {
        iterator = cloudwatch_logging_options
        for_each = length(keys(lookup(s3_configuration.value, "cloudwatch_logging_options", {}))) > 0 ? [lookup(s3_configuration.value, "cloudwatch_logging_options", {})] : []

        content {
          enabled         = lookup(cloudwatch_logging_options.value, "enabled", null)
          log_group_name  = lookup(cloudwatch_logging_options.value, "log_group_name", null)
          log_stream_name = lookup(cloudwatch_logging_options.value, "log_stream_name", null)
        }
      }


    }
  }
  dynamic "extended_s3_configuration" {
    iterator = extended_s3_configuration
    for_each = length(keys(var.kinesis_firehose_delivery_stream_extended_s3_configuration)) > 0 ? [var.kinesis_firehose_delivery_stream_extended_s3_configuration] : []

    content {
      role_arn   = lookup(extended_s3_configuration.value, "role_arn", null)
      bucket_arn = lookup(extended_s3_configuration.value, "bucket_arn", null)

      s3_backup_mode = lookup(extended_s3_configuration.value, "s3_backup_mode", null)

      dynamic "s3_backup_configuration" {
        iterator = s3_backup_configuration
        for_each = length(keys(lookup(extended_s3_configuration.value, "s3_backup_configuration", {}))) > 0 ? [lookup(extended_s3_configuration.value, "s3_backup_configuration", {})] : []

        content {
          role_arn   = lookup(s3_backup_configuration.value, "role_arn", null)
          bucket_arn = lookup(s3_backup_configuration.value, "bucket_arn", null)

          prefix              = lookup(s3_backup_configuration.value, "prefix", null)
          buffer_size         = lookup(s3_backup_configuration.value, "buffer_size", null)
          buffer_interval     = lookup(s3_backup_configuration.value, "buffer_interval", null)
          compression_format  = lookup(s3_backup_configuration.value, "compression_format", null)
          error_output_prefix = lookup(s3_backup_configuration.value, "error_output_prefix", null)
          kms_key_arn         = lookup(s3_backup_configuration.value, "kms_key_arn", null)

          dynamic "cloudwatch_logging_options" {
            iterator = cloudwatch_logging_options
            for_each = length(keys(lookup(s3_backup_configuration.value, "cloudwatch_logging_options", {}))) > 0 ? [lookup(s3_backup_configuration.value, "cloudwatch_logging_options", {})] : []

            content {
              enabled         = lookup(cloudwatch_logging_options.value, "enabled", null)
              log_group_name  = lookup(cloudwatch_logging_options.value, "log_group_name", null)
              log_stream_name = lookup(cloudwatch_logging_options.value, "log_stream_name", null)
            }
          }
        }
      }

      dynamic "data_format_conversion_configuration" {
        iterator = data_format_conversion_configuration
        for_each = length(keys(lookup(extended_s3_configuration.value, "data_format_conversion_configuration", {}))) > 0 ? [lookup(extended_s3_configuration.value, "data_format_conversion_configuration", {})] : []

        content {
          enabled = lookup(data_format_conversion_configuration.value, "enabled", null)

          dynamic "input_format_configuration" {
            iterator = input_format_configuration
            for_each = length(keys(lookup(data_format_conversion_configuration.value, "input_format_configuration", {}))) > 0 ? [lookup(extended_s3_configuration.value, "input_format_configuration", {})] : []

            content {
              dynamic "deserializer" {
                iterator = deserializer
                for_each = length(keys(lookup(input_format_configuration.value, "deserializer", {}))) > 0 ? [lookup(input_format_configuration.value, "deserializer", {})] : []
                content {

                  dynamic "hive_json_ser_de" {
                    iterator = hive_json_ser_de
                    for_each = length(keys(lookup(input_format_configuration.value, "hive_json_ser_de", {}))) > 0 ? [lookup(input_format_configuration.value, "hive_json_ser_de", {})] : []
                    content {
                      timestamp_formats = lookup(hive_json_ser_de.value, "timestamp_formats", null)
                    }

                  }
                  dynamic "open_x_json_ser_de" {
                    iterator = open_x_json_ser_de
                    for_each = length(keys(lookup(input_format_configuration.value, "open_x_json_ser_de", {}))) > 0 ? [lookup(input_format_configuration.value, "open_x_json_ser_de", {})] : []
                    content {
                      case_insensitive                         = lookup(open_x_json_ser_de.value, "case_insensitive", null)
                      column_to_json_key_mappings              = lookup(open_x_json_ser_de.value, "column_to_json_key_mappings", null)
                      convert_dots_in_json_keys_to_underscores = lookup(open_x_json_ser_de.value, "convert_dots_in_json_keys_to_underscores", null)
                    }
                  }
                }
              }
            }
          }

          dynamic "output_format_configuration" {
            iterator = output_format_configuration
            for_each = length(keys(lookup(data_format_conversion_configuration.value, "output_format_configuration", {}))) > 0 ? [lookup(extended_s3_configuration.value, "output_format_configuration", {})] : []

            content {
              dynamic "serializer" {
                iterator = serializer
                for_each = length(keys(lookup(output_format_configuration.value, "serializer", {}))) > 0 ? [lookup(output_format_configuration.value, "serializer", {})] : []
                content {

                  dynamic "orc_ser_de" {
                    iterator = orc_ser_de
                    for_each = length(keys(lookup(serializer.value, "orc_ser_de", {}))) > 0 ? [lookup(serializer.value, "orc_ser_de", {})] : []
                    content {
                      block_size_bytes                        = lookup(orc_ser_de.value, "block_size_bytes", null)
                      bloom_filter_columns                    = lookup(orc_ser_de.value, "bloom_filter_columns", null)
                      bloom_filter_false_positive_probability = lookup(orc_ser_de.value, "bloom_filter_false_positive_probability", null)
                      compression                             = lookup(orc_ser_de.value, "compression", null)
                      dictionary_key_threshold                = lookup(orc_ser_de.value, "dictionary_key_threshold", null)
                      enable_padding                          = lookup(orc_ser_de.value, "enable_padding", null)
                      format_version                          = lookup(orc_ser_de.value, "format_version", null)
                      padding_tolerance                       = lookup(orc_ser_de.value, "padding_tolerance", null)
                      row_index_stride                        = lookup(orc_ser_de.value, "row_index_stride", null)
                      stripe_size_bytes                       = lookup(orc_ser_de.value, "stripe_size_bytes", null)
                    }

                  }
                  dynamic "parquet_ser_de" {
                    iterator = parquet_ser_de
                    for_each = length(keys(lookup(serializer.value, "parquet_ser_de", {}))) > 0 ? [lookup(serializer.value, "parquet_ser_de", {})] : []
                    content {
                      block_size_bytes              = lookup(parquet_ser_de.value, "block_size_bytes", null)
                      compression                   = lookup(parquet_ser_de.value, "compression", null)
                      enable_dictionary_compression = lookup(parquet_ser_de.value, "enable_dictionary_compression", null)
                      max_padding_bytes             = lookup(parquet_ser_de.value, "max_padding_bytes", null)
                      page_size_bytes               = lookup(parquet_ser_de.value, "page_size_bytes", null)
                      writer_version                = lookup(parquet_ser_de.value, "writer_version", null)

                    }
                  }
                }
              }
            }
          }

          dynamic "schema_configuration" {
            iterator = schema_configuration
            for_each = length(keys(lookup(data_format_conversion_configuration.value, "schema_configuration", {}))) > 0 ? [lookup(extended_s3_configuration.value, "schema_configuration", {})] : []

            content {
              database_name = lookup(schema_configuration.value, "database_name", null)
              role_arn      = lookup(schema_configuration.value, "role_arn", null)
              table_name    = lookup(schema_configuration.value, "table_name", null)

              catalog_id = lookup(schema_configuration.value, "catalog_id", null)
              region     = lookup(schema_configuration.value, "region", null)
              version_id = lookup(schema_configuration.value, "version_id", null)
            }
          }
        }
      }
      dynamic "dynamic_partitioning_configuration" {
        iterator = dynamic_partitioning_configuration
        for_each = length(keys(lookup(extended_s3_configuration.value, "dynamic_partitioning_configuration", {}))) > 0 ? [lookup(extended_s3_configuration.value, "dynamic_partitioning_configuration", {})] : []

        content {
          enabled        = lookup(dynamic_partitioning_configuration.value, "enabled", null)
          retry_duration = lookup(dynamic_partitioning_configuration.value, "retry_duration", null)
        }
      }

      dynamic "processing_configuration" {
        iterator = processing_configuration
        for_each = length(keys(lookup(extended_s3_configuration.value, "processing_configuration", {}))) > 0 ? [lookup(extended_s3_configuration.value, "processing_configuration", {})] : []

        content {
          enabled = lookup(processing_configuration.value, "enabled", null)

          dynamic "processors" {
            iterator = processors
            for_each = lookup(processing_configuration.value, "processors", [])

            content {
              type = lookup(processors.value, "type", null)

              dynamic "parameters" {
                iterator = parameters
                for_each = lookup(processors.value, "parameters", [])

                content {
                  parameter_name  = lookup(parameters.value, "parameter_name", null)
                  parameter_value = lookup(parameters.value, "parameter_value", null)
                }
              }
            }
          }
        }
      }
    }
  }

  dynamic "redshift_configuration" {
    iterator = redshift_configuration
    for_each = length(keys(var.kinesis_firehose_delivery_stream_redshift_configuration)) > 0 ? [var.kinesis_firehose_delivery_stream_redshift_configuration] : []

    content {
      cluster_jdbcurl = lookup(redshift_configuration.value, "cluster_jdbcurl", null)
      username        = lookup(redshift_configuration.value, "username", null)
      password        = lookup(redshift_configuration.value, "password", null)
      role_arn        = lookup(redshift_configuration.value, "role_arn", null)
      data_table_name = lookup(redshift_configuration.value, "data_table_name", null)

      retry_duration     = lookup(redshift_configuration.value, "retry_duration", null)
      s3_backup_mode     = lookup(redshift_configuration.value, "s3_backup_mode", null)
      copy_options       = lookup(redshift_configuration.value, "copy_options", null)
      data_table_columns = lookup(redshift_configuration.value, "data_table_columns", null)

      dynamic "cloudwatch_logging_options" {
        iterator = cloudwatch_logging_options
        for_each = length(keys(lookup(redshift_configuration.value, "cloudwatch_logging_options", {}))) > 0 ? [lookup(redshift_configuration.value, "cloudwatch_logging_options", {})] : []

        content {
          enabled         = lookup(cloudwatch_logging_options.value, "enabled", null)
          log_group_name  = lookup(cloudwatch_logging_options.value, "log_group_name", null)
          log_stream_name = lookup(cloudwatch_logging_options.value, "log_stream_name", null)
        }
      }

      dynamic "processing_configuration" {
        iterator = processing_configuration
        for_each = length(keys(lookup(redshift_configuration.value, "processing_configuration", {}))) > 0 ? [lookup(redshift_configuration.value, "processing_configuration", {})] : []

        content {
          enabled = lookup(processing_configuration.value, "enabled", null)

          dynamic "processors" {
            iterator = processors
            for_each = lookup(processing_configuration.value, "processors", [])

            content {
              type = lookup(processors.value, "type", null)

              dynamic "parameters" {
                iterator = parameters
                for_each = lookup(processors.value, "parameters", [])

                content {
                  parameter_name  = lookup(parameters.value, "parameter_name", null)
                  parameter_value = lookup(parameters.value, "parameter_value", null)
                }
              }
            }
          }
        }
      }

      dynamic "s3_backup_configuration" {
        iterator = s3_backup_configuration
        for_each = length(keys(lookup(redshift_configuration.value, "s3_backup_configuration", {}))) > 0 ? [lookup(redshift_configuration.value, "s3_backup_configuration", {})] : []

        content {
          role_arn   = lookup(s3_backup_configuration.value, "role_arn", null)
          bucket_arn = lookup(s3_backup_configuration.value, "bucket_arn", null)

          prefix              = lookup(s3_backup_configuration.value, "prefix", null)
          buffer_size         = lookup(s3_backup_configuration.value, "buffer_size", null)
          buffer_interval     = lookup(s3_backup_configuration.value, "buffer_interval", null)
          compression_format  = lookup(s3_backup_configuration.value, "compression_format", null)
          error_output_prefix = lookup(s3_backup_configuration.value, "error_output_prefix", null)
          kms_key_arn         = lookup(s3_backup_configuration.value, "kms_key_arn", null)

          dynamic "cloudwatch_logging_options" {
            iterator = cloudwatch_logging_options
            for_each = length(keys(lookup(s3_backup_configuration.value, "cloudwatch_logging_options", {}))) > 0 ? [lookup(s3_backup_configuration.value, "cloudwatch_logging_options", {})] : []

            content {
              enabled         = lookup(cloudwatch_logging_options.value, "enabled", null)
              log_group_name  = lookup(cloudwatch_logging_options.value, "log_group_name", null)
              log_stream_name = lookup(cloudwatch_logging_options.value, "log_stream_name", null)
            }
          }
        }
      }
    }
  }

  dynamic "elasticsearch_configuration" {
    iterator = elasticsearch_configuration
    for_each = length(keys(var.kinesis_firehose_delivery_stream_elasticsearch_configuration)) > 0 ? [var.kinesis_firehose_delivery_stream_elasticsearch_configuration] : []

    content {
      index_name = lookup(elasticsearch_configuration.value, "index_name", null)
      role_arn   = lookup(elasticsearch_configuration.value, "role_arn", null)

      buffering_interval    = lookup(elasticsearch_configuration.value, "buffering_interval", null)
      buffering_size        = lookup(elasticsearch_configuration.value, "buffering_size", null)
      domain_arn            = lookup(elasticsearch_configuration.value, "domain_arn", null)
      cluster_endpoint      = lookup(elasticsearch_configuration.value, "cluster_endpoint", null)
      index_rotation_period = lookup(elasticsearch_configuration.value, "index_rotation_period", null)
      retry_duration        = lookup(elasticsearch_configuration.value, "retry_duration", null)
      s3_backup_mode        = lookup(elasticsearch_configuration.value, "s3_backup_mode", null)
      type_name             = lookup(elasticsearch_configuration.value, "type_name", null)

      dynamic "cloudwatch_logging_options" {
        iterator = cloudwatch_logging_options
        for_each = length(keys(lookup(elasticsearch_configuration.value, "cloudwatch_logging_options", {}))) > 0 ? [lookup(elasticsearch_configuration.value, "cloudwatch_logging_options", {})] : []

        content {
          enabled         = lookup(cloudwatch_logging_options.value, "enabled", null)
          log_group_name  = lookup(cloudwatch_logging_options.value, "log_group_name", null)
          log_stream_name = lookup(cloudwatch_logging_options.value, "log_stream_name", null)
        }
      }

      dynamic "vpc_config" {
        iterator = vpc_config
        for_each = length(keys(lookup(elasticsearch_configuration.value, "vpc_config", {}))) > 0 ? [lookup(elasticsearch_configuration.value, "vpc_config", {})] : []

        content {
          subnet_ids         = lookup(vpc_config.value, "subnet_ids", null)
          security_group_ids = lookup(vpc_config.value, "security_group_ids", null)
          role_arn           = lookup(vpc_config.value, "role_arn", null)
        }
      }

      dynamic "processing_configuration" {
        iterator = processing_configuration
        for_each = length(keys(lookup(elasticsearch_configuration.value, "processing_configuration", {}))) > 0 ? [lookup(elasticsearch_configuration.value, "processing_configuration", {})] : []

        content {
          enabled = lookup(processing_configuration.value, "enabled", null)

          dynamic "processors" {
            iterator = processors
            for_each = lookup(processing_configuration.value, "processors", [])

            content {
              type = lookup(processors.value, "type", null)

              dynamic "parameters" {
                iterator = parameters
                for_each = lookup(processors.value, "parameters", [])

                content {
                  parameter_name  = lookup(parameters.value, "parameter_name", null)
                  parameter_value = lookup(parameters.value, "parameter_value", null)
                }
              }
            }
          }
        }
      }
    }
  }

  dynamic "splunk_configuration" {
    iterator = splunk_configuration
    for_each = length(keys(var.kinesis_firehose_delivery_stream_splunk_configuration)) > 0 ? [var.kinesis_firehose_delivery_stream_splunk_configuration] : []

    content {
      hec_endpoint = lookup(splunk_configuration.value, "hec_endpoint", null)
      hec_token    = lookup(splunk_configuration.value, "hec_token", null)

      hec_acknowledgment_timeout = lookup(splunk_configuration.value, "hec_acknowledgment_timeout", null)
      hec_endpoint_type          = lookup(splunk_configuration.value, "hec_endpoint_type", null)
      s3_backup_mode             = lookup(splunk_configuration.value, "s3_backup_mode", null)
      retry_duration             = lookup(splunk_configuration.value, "retry_duration", null)

      dynamic "cloudwatch_logging_options" {
        iterator = cloudwatch_logging_options
        for_each = length(keys(lookup(splunk_configuration.value, "cloudwatch_logging_options", {}))) > 0 ? [lookup(splunk_configuration.value, "cloudwatch_logging_options", {})] : []

        content {
          enabled         = lookup(cloudwatch_logging_options.value, "enabled", null)
          log_group_name  = lookup(cloudwatch_logging_options.value, "log_group_name", null)
          log_stream_name = lookup(cloudwatch_logging_options.value, "log_stream_name", null)
        }
      }

      dynamic "processing_configuration" {
        iterator = processing_configuration
        for_each = length(keys(lookup(splunk_configuration.value, "processing_configuration", {}))) > 0 ? [lookup(splunk_configuration.value, "processing_configuration", {})] : []

        content {
          enabled = lookup(processing_configuration.value, "enabled", null)

          dynamic "processors" {
            iterator = processors
            for_each = lookup(processing_configuration.value, "processors", [])

            content {
              type = lookup(processors.value, "type", null)

              dynamic "parameters" {
                iterator = parameters
                for_each = lookup(processors.value, "parameters", [])

                content {
                  parameter_name  = lookup(parameters.value, "parameter_name", null)
                  parameter_value = lookup(parameters.value, "parameter_value", null)
                }
              }
            }
          }
        }
      }
    }
  }

  dynamic "http_endpoint_configuration" {
    iterator = http_endpoint_configuration
    for_each = length(keys(var.kinesis_firehose_delivery_stream_http_endpoint_configuration)) > 0 ? [var.kinesis_firehose_delivery_stream_http_endpoint_configuration] : []

    content {
      url      = lookup(http_endpoint_configuration.value, "url", null)
      role_arn = lookup(http_endpoint_configuration.value, "role_arn", null)

      name               = lookup(http_endpoint_configuration.value, "name", null)
      access_key         = lookup(http_endpoint_configuration.value, "access_key", null)
      s3_backup_mode     = lookup(http_endpoint_configuration.value, "s3_backup_mode", null)
      buffering_size     = lookup(http_endpoint_configuration.value, "buffering_size", null)
      buffering_interval = lookup(http_endpoint_configuration.value, "buffering_interval", null)
      retry_duration     = lookup(http_endpoint_configuration.value, "retry_duration", null)

      dynamic "cloudwatch_logging_options" {
        iterator = cloudwatch_logging_options
        for_each = length(keys(lookup(http_endpoint_configuration.value, "cloudwatch_logging_options", {}))) > 0 ? [lookup(http_endpoint_configuration.value, "cloudwatch_logging_options", {})] : []

        content {
          enabled         = lookup(cloudwatch_logging_options.value, "enabled", null)
          log_group_name  = lookup(cloudwatch_logging_options.value, "log_group_name", null)
          log_stream_name = lookup(cloudwatch_logging_options.value, "log_stream_name", null)
        }
      }

      dynamic "processing_configuration" {
        iterator = processing_configuration
        for_each = length(keys(lookup(http_endpoint_configuration.value, "processing_configuration", {}))) > 0 ? [lookup(http_endpoint_configuration.value, "processing_configuration", {})] : []

        content {
          enabled = lookup(processing_configuration.value, "enabled", null)

          dynamic "processors" {
            iterator = processors
            for_each = lookup(processing_configuration.value, "processors", [])

            content {
              type = lookup(processors.value, "type", null)

              dynamic "parameters" {
                iterator = parameters
                for_each = lookup(processors.value, "parameters", [])

                content {
                  parameter_name  = lookup(parameters.value, "parameter_name", null)
                  parameter_value = lookup(parameters.value, "parameter_value", null)
                }
              }
            }
          }
        }
      }

      dynamic "request_configuration" {
        iterator = request_configuration
        for_each = length(keys(lookup(http_endpoint_configuration.value, "request_configuration", {}))) > 0 ? [lookup(http_endpoint_configuration.value, "request_configuration", {})] : []

        content {
          content_encoding = lookup(request_configuration.value, "content_encoding", null)

          dynamic "common_attributes" {
            iterator = common_attributes
            for_each = lookup(request_configuration.value, "common_attributes", [])

            content {
              name  = lookup(common_attributes.value, "name", null)
              value = lookup(common_attributes.value, "value", null)
            }
          }
        }
      }
    }
  }

  tags = merge(
    {
      Name = var.kinesis_firehose_delivery_stream_name != "" ? var.kinesis_firehose_delivery_stream_name : "${lower(var.name)}-kinesis-firehose-delivery-stream-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}