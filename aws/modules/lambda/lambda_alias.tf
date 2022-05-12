#---------------------------------------------------
# AWS lambda alias
#---------------------------------------------------
resource "aws_lambda_alias" "lambda_alias" {
  count = var.enable_lambda_alias ? 1 : 0

  name             = var.lambda_alias_name != "" ? var.lambda_alias_name : "${lower(var.name)}-lambda-alias-${lower(var.environment)}"
  description      = var.lambda_alias_description
  function_name    = var.lambda_alias_function_name != "" && !var.enable_lambda_function ? var.lambda_alias_function_name : element(concat(aws_lambda_function.lambda_function.*.arn, [""]), 0)
  function_version = var.lambda_alias_function_version

  dynamic "routing_config" {
    iterator = routing_config
    for_each = [var.lambda_alias_routing_config]

    content {
      additional_version_weights = lookup(routing_config.value, "additional_version_weights", {})
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [routing_config]
  }

  depends_on = [
    aws_lambda_function.lambda_function
  ]
}
