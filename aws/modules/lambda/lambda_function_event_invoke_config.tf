#---------------------------------------------------
# AWS lambda function event invoke config
#---------------------------------------------------
resource "aws_lambda_function_event_invoke_config" "lambda_function_event_invoke_config" {
  count = var.enable_lambda_function_event_invoke_config ? 1 : 0

  function_name = var.lambda_function_event_invoke_config_function_name != "" && !var.enable_lambda_function && !var.enable_lambda_alias ? var.lambda_function_event_invoke_config_function_name : (var.enable_lambda_function && !var.enable_lambda_alias ? element(concat(aws_lambda_function.lambda_function.*.function_name, [""]), 0) : element(concat(aws_lambda_alias.lambda_alias.*.function_name, [""]), 0))

  qualifier                    = var.lambda_function_event_invoke_config_qualifier != "" && !var.enable_lambda_function && !var.enable_lambda_alias ? var.lambda_function_event_invoke_config_qualifier : (var.enable_lambda_function && !var.enable_lambda_alias ? element(concat(aws_lambda_function.lambda_function.*.version, [""]), 0) : element(concat(aws_lambda_alias.lambda_alias.*.name, [""]), 0))
  maximum_event_age_in_seconds = var.lambda_function_event_invoke_config_maximum_event_age_in_seconds
  maximum_retry_attempts       = var.lambda_function_event_invoke_config_maximum_retry_attempts

  dynamic "destination_config" {
    iterator = destination_config
    for_each = var.lambda_function_event_invoke_config_destination_config

    content {
      dynamic "on_success" {
        iterator = on_success
        for_each = length(keys(lookup(destination_config.value, "on_success", {}))) > 0 ? [lookup(destination_config.value, "on_success", {})] : []

        content {
          destination = lookup(on_success.value, "destination", null)
        }
      }

      dynamic "on_failure" {
        iterator = on_failure
        for_each = length(keys(lookup(destination_config.value, "on_failure", {}))) > 0 ? [lookup(destination_config.value, "on_failure", {})] : []

        content {
          destination = lookup(on_failure.value, "destination", null)
        }
      }
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_lambda_function.lambda_function,
    aws_lambda_alias.lambda_alias
  ]
}
