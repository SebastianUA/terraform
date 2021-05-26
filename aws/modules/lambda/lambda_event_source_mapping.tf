#---------------------------------------------------
# AWS lambda event source mapping
#---------------------------------------------------
resource "aws_lambda_event_source_mapping" "lambda_event_source_mapping" {
  count = var.enable_lambda_event_source_mapping ? 1 : 0

  event_source_arn = var.lambda_event_source_mapping_event_source_arn
  function_name    = var.lambda_event_source_mapping_function_name != "" && !var.enable_lambda_function ? var.lambda_event_source_mapping_function_name : element(concat(aws_lambda_function.lambda_function.*.arn, [""]), 0)

  starting_position = var.lambda_event_source_mapping_starting_position

  batch_size                         = var.lambda_event_source_mapping_batch_size
  maximum_batching_window_in_seconds = var.lambda_event_source_mapping_maximum_batching_window_in_seconds
  enabled                            = var.lambda_event_source_mapping_enabled
  starting_position_timestamp        = var.lambda_event_source_mapping_starting_position_timestamp
  parallelization_factor             = var.lambda_event_source_mapping_parallelization_factor
  maximum_retry_attempts             = var.lambda_event_source_mapping_maximum_retry_attempts
  maximum_record_age_in_seconds      = var.lambda_event_source_mapping_maximum_record_age_in_seconds
  bisect_batch_on_function_error     = var.lambda_event_source_mapping_bisect_batch_on_function_error

  dynamic "destination_config" {
    iterator = destination_config
    for_each = var.lambda_event_source_mapping_destination_config

    content {
      dynamic "on_failure" {
        iterator = on_failure
        for_each = length(keys(lookup(destination_config.value, "on_failure", {}))) > 0 ? [lookup(destination_config.value, "on_failure", {})] : []

        content {
          destination_arn = lookup(on_failure.value, "destination_arn", null)
        }
      }
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_lambda_function.lambda_function
  ]
}
