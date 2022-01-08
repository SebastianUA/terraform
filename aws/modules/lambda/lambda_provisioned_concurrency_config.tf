#---------------------------------------------------
# AWS lambda provisioned concurrency config
#---------------------------------------------------
resource "aws_lambda_provisioned_concurrency_config" "lambda_provisioned_concurrency_config" {
  count = var.enable_lambda_provisioned_concurrency_config ? 1 : 0

  function_name                     = var.lambda_provisioned_concurrency_config_function_name != "" && !var.enable_lambda_function && !var.enable_lambda_alias ? var.lambda_provisioned_concurrency_config_function_name : (var.enable_lambda_function && !var.enable_lambda_alias ? element(concat(aws_lambda_function.lambda_function.*.function_name, [""]), 0) : element(concat(aws_lambda_alias.lambda_alias.*.function_name, [""]), 0))
  qualifier                         = var.lambda_provisioned_concurrency_config_qualifier != "" && !var.enable_lambda_function && !var.enable_lambda_alias ? var.lambda_provisioned_concurrency_config_qualifier : (var.enable_lambda_function && !var.enable_lambda_alias ? element(concat(aws_lambda_function.lambda_function.*.version, [""]), 0) : element(concat(aws_lambda_alias.lambda_alias.*.name, [""]), 0))
  provisioned_concurrent_executions = var.lambda_provisioned_concurrency_config_provisioned_concurrent_executions

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.lambda_provisioned_concurrency_config_timeouts)) > 0 ? [var.lambda_provisioned_concurrency_config_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      update = lookup(timeouts.value, "update", null)
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
