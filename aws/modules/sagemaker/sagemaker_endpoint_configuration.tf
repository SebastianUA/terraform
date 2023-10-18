#---------------------------------------------------
# AWS Sagemaker endpoint configuration
#---------------------------------------------------
resource "aws_sagemaker_endpoint_configuration" "sagemaker_endpoint_configuration" {
  count = var.enable_sagemaker_endpoint_configuration ? 1 : 0

  name        = var.sagemaker_endpoint_configuration_name != "" ? lower(var.sagemaker_endpoint_configuration_name) : null
  name_prefix = var.sagemaker_endpoint_configuration_name_prefix != "" ? lower(var.sagemaker_endpoint_configuration_name_prefix) : null

  kms_key_arn = var.sagemaker_endpoint_configuration_kms_key_arn
  dynamic "production_variants" {
    iterator = production_variants
    for_each = var.sagemaker_endpoint_configuration_production_variants

    content {
      model_name             = lookup(production_variants.value, "model_name", element(concat(aws_sagemaker_model.sagemaker_model.*.name, [""]), 0))
      initial_instance_count = lookup(production_variants.value, "initial_instance_count", 0)
      instance_type          = lookup(production_variants.value, "instance_type", "ml.t2.medium")

      variant_name           = lookup(production_variants.value, "variant_name", null)
      accelerator_type       = lookup(production_variants.value, "accelerator_type", null)
      initial_variant_weight = lookup(production_variants.value, "initial_variant_weight", null)
    }
  }

  dynamic "data_capture_config" {
    iterator = data_capture_config
    for_each = var.sagemaker_endpoint_configuration_data_capture_config

    content {
      initial_sampling_percentage = lookup(data_capture_config.value, "initial_sampling_percentage", null)
      destination_s3_uri          = lookup(data_capture_config.value, "destination_s3_uri", null)

      dynamic "capture_options" {
        iterator = capture_options
        for_each = length(keys(lookup(data_capture_config.value, "capture_options", {}))) > 0 ? [lookup(data_capture_config.value, "capture_options", {})] : []

        content {
          capture_mode = lookup(capture_options.value, "capture_mode", null)
        }
      }

      kms_key_id     = lookup(data_capture_config.value, "kms_key_id", null)
      enable_capture = lookup(data_capture_config.value, "enable_capture", null)

      dynamic "capture_content_type_header" {
        iterator = capture_content_type_header
        for_each = length(keys(lookup(data_capture_config.value, "capture_content_type_header", {}))) > 0 ? [lookup(data_capture_config.value, "capture_content_type_header", {})] : []

        content {
          csv_content_types  = lookup(capture_content_type_header.value, "csv_content_types", null)
          json_content_types = lookup(capture_content_type_header.value, "json_content_types", null)
        }
      }
    }
  }

  dynamic "shadow_production_variants" {
    iterator = shadow_production_variants
    for_each = var.sagemaker_endpoint_configuration_shadow_production_variants

    content {
      model_name             = lookup(production_variants.value, "model_name", null)
      initial_instance_count = lookup(production_variants.value, "initial_instance_count", null)
      instance_type          = lookup(production_variants.value, "instance_type", null)

      variant_name           = lookup(production_variants.value, "variant_name", null)
      accelerator_type       = lookup(production_variants.value, "accelerator_type", null)
      initial_variant_weight = lookup(production_variants.value, "initial_variant_weight", null)
    }
  }

  dynamic "async_inference_config" {
    iterator = async_inference_config
    for_each = var.sagemaker_endpoint_configuration_async_inference_config

    content {
      dynamic "output_config" {
        iterator = output_config
        for_each = length(keys(lookup(async_inference_config.value, "output_config", {}))) > 0 ? [lookup(async_inference_config.value, "output_config", {})] : []

        content {
          s3_output_path = lookup(output_config.value, "s3_output_path", null)

          s3_failure_path = lookup(output_config.value, "s3_failure_path", null)
          kms_key_id      = lookup(output_config.value, "kms_key_id", null)

          dynamic "notification_config" {
            iterator = notification_config
            for_each = length(keys(lookup(output_config.value, "notification_config", {}))) > 0 ? [lookup(output_config.value, "notification_config", {})] : []

            content {
              include_inference_response_in = lookup(notification_config.value, "include_inference_response_in", null)
              error_topic                   = lookup(notification_config.value, "error_topic", null)
              success_topic                 = lookup(notification_config.value, "success_topic", null)
            }
          }
        }
      }

      dynamic "client_config" {
        iterator = client_config
        for_each = length(keys(lookup(async_inference_config.value, "client_config", {}))) > 0 ? [lookup(async_inference_config.value, "client_config", {})] : []

        content {
          max_concurrent_invocations_per_instance = lookup(client_config.value, "max_concurrent_invocations_per_instance", null)
        }
      }
    }
  }

  tags = merge(
    {
      Name = var.sagemaker_endpoint_configuration_name != "" ? lower(var.sagemaker_endpoint_configuration_name) : "${lower(var.name)}-sagemaker-endpoint-conf-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_sagemaker_model.sagemaker_model
  ]
}
