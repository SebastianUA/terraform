#---------------------------------------------------
# AWS Sagemaker data quality job definition
#---------------------------------------------------
resource "aws_sagemaker_data_quality_job_definition" "sagemaker_data_quality_job_definition" {
  count = var.enable_sagemaker_data_quality_job_definition ? 1 : 0

  name = var.sagemaker_data_quality_job_definition_name != "" ? var.sagemaker_data_quality_job_definition_name : "${lower(var.name)}-data-quality-job-definition-${lower(var.environment)}"

  role_arn = var.sagemaker_data_quality_job_definition_role_arn

  data_quality_app_specification {
    image_uri = lookup(var.sagemaker_data_quality_job_definition_data_quality_app_specification, "image_uri", null)

    environment                         = lookup(var.sagemaker_data_quality_job_definition_data_quality_app_specification, "environment", null)
    post_analytics_processor_source_uri = lookup(var.sagemaker_data_quality_job_definition_data_quality_app_specification, "post_analytics_processor_source_uri", null)
    record_preprocessor_source_uri      = lookup(var.sagemaker_data_quality_job_definition_data_quality_app_specification, "record_preprocessor_source_uri", null)
  }

  data_quality_job_input {
    dynamic "batch_transform_input" {
      iterator = batch_transform_input
      for_each = length(keys(lookup(var.sagemaker_data_quality_job_definition_data_quality_job_input, "batch_transform_input", {}))) > 0 ? [lookup(var.sagemaker_data_quality_job_definition_data_quality_job_input, "batch_transform_input", {})] : []

      content {
        data_captured_destination_s3_uri = lookup(batch_transform_input.value, "data_captured_destination_s3_uri", null)

        dynamic "dataset_format" {
          iterator = dataset_format
          for_each = length(keys(lookup(batch_transform_input.value, "dataset_format", {}))) > 0 ? [lookup(batch_transform_input.value, "dataset_format", {})] : []

          content {
            dynamic "csv" {
              iterator = csv
              for_each = length(keys(lookup(dataset_format.value, "csv", {}))) > 0 ? [lookup(dataset_format.value, "csv", {})] : []

              content {
                header = lookup(csv.value, "header", null)
              }
            }

            dynamic "json" {
              iterator = json
              for_each = length(keys(lookup(dataset_format.value, "json", {}))) > 0 ? [lookup(dataset_format.value, "json", {})] : []

              content {
                line = lookup(json.value, "line", null)
              }
            }
          }
        }

        local_path                = lookup(batch_transform_input.value, "local_path", null)
        s3_data_distribution_type = lookup(batch_transform_input.value, "s3_data_distribution_type", null)
        s3_input_mode             = lookup(batch_transform_input.value, "s3_input_mode", null)
      }
    }

    dynamic "endpoint_input" {
      iterator = endpoint_input
      for_each = length(keys(lookup(var.sagemaker_data_quality_job_definition_data_quality_job_input, "endpoint_input", {}))) > 0 ? [lookup(var.sagemaker_data_quality_job_definition_data_quality_job_input, "endpoint_input", {})] : []

      content {
        endpoint_name = lookup(endpoint_input.value, "endpoint_name", null)

        local_path                = lookup(endpoint_input.value, "local_path", null)
        s3_data_distribution_type = lookup(endpoint_input.value, "s3_data_distribution_type", null)
        s3_input_mode             = lookup(endpoint_input.value, "s3_input_mode", null)
      }
    }
  }

  data_quality_job_output_config {
    kms_key_id = lookup(var.sagemaker_data_quality_job_definition_data_quality_job_output_config, "kms_key_id", null)

    dynamic "monitoring_outputs" {
      iterator = monitoring_outputs
      for_each = length(keys(lookup(var.sagemaker_data_quality_job_definition_data_quality_job_output_config, "monitoring_outputs", {}))) > 0 ? [lookup(var.sagemaker_data_quality_job_definition_data_quality_job_output_config, "monitoring_outputs", {})] : []

      content {
        dynamic "s3_output" {
          iterator = s3_output
          for_each = length(keys(lookup(monitoring_outputs.value, "s3_output", {}))) > 0 ? [lookup(monitoring_outputs.value, "s3_output", {})] : []

          content {
            s3_uri = lookup(s3_output.value, "s3_uri", null)

            local_path     = lookup(s3_output.value, "local_path", null)
            s3_upload_mode = lookup(s3_output.value, "s3_upload_mode", null)

          }
        }
      }
    }
  }

  job_resources {
    dynamic "cluster_config" {
      iterator = cluster_config
      for_each = length(keys(lookup(var.sagemaker_data_quality_job_definition_job_resources, "cluster_config", {}))) > 0 ? [lookup(var.sagemaker_data_quality_job_definition_job_resources, "cluster_config", {})] : []

      content {
        instance_count    = lookup(cluster_config.value, "instance_count", null)
        instance_type     = lookup(cluster_config.value, "instance_type", null)
        volume_size_in_gb = lookup(cluster_config.value, "volume_size_in_gb", null)

        volume_kms_key_id = lookup(cluster_config.value, "volume_kms_key_id", null)
      }
    }
  }

  dynamic "data_quality_baseline_config" {
    iterator = data_quality_baseline_config
    for_each = var.sagemaker_data_quality_job_definition_data_quality_baseline_config

    content {
      dynamic "constraints_resource" {
        iterator = constraints_resource
        for_each = length(keys(lookup(data_quality_baseline_config.value, "constraints_resource", {}))) > 0 ? [lookup(data_quality_baseline_config.value, "constraints_resource", {})] : []

        content {
          s3_uri = lookup(constraints_resource.value, "s3_uri", null)
        }
      }

      dynamic "statistics_resource" {
        iterator = statistics_resource
        for_each = length(keys(lookup(var.sagemaker_data_quality_job_definition_job_resources, "statistics_resource", {}))) > 0 ? [lookup(var.sagemaker_data_quality_job_definition_job_resources, "statistics_resource", {})] : []

        content {
          s3_uri = lookup(statistics_resource.value, "s3_uri", null)
        }
      }
    }
  }

  dynamic "network_config" {
    iterator = network_config
    for_each = var.sagemaker_data_quality_job_definition_network_config

    content {
      enable_inter_container_traffic_encryption = lookup(network_config.value, "enable_inter_container_traffic_encryption", null)
      enable_network_isolation                  = lookup(network_config.value, "enable_network_isolation", null)

      dynamic "vpc_config" {
        iterator = vpc_config
        for_each = length(keys(lookup(network_config.value, "vpc_config", {}))) > 0 ? [lookup(network_config.value, "vpc_config", {})] : []

        content {
          security_group_ids = lookup(vpc_config.value, "security_group_ids", null)
          subnets            = lookup(vpc_config.value, "subnets", null)
        }
      }
    }
  }

  dynamic "stopping_condition" {
    iterator = stopping_condition
    for_each = var.sagemaker_data_quality_job_definition_stopping_condition

    content {
      max_runtime_in_seconds = lookup(stopping_condition.value, "max_runtime_in_seconds", null)
    }
  }

  tags = merge(
    {
      Name = var.sagemaker_data_quality_job_definition_name != "" ? var.sagemaker_data_quality_job_definition_name : "${lower(var.name)}-data-quality-job-definition-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
