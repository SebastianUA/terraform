#---------------------------------------------------
# AWS Lambda function
#---------------------------------------------------
resource "aws_lambda_function" "lambda_function" {
  count = var.enable_lambda_function ? 1 : 0

  function_name = var.lambda_function_name != "" ? var.lambda_function_name : "${lower(var.name)}-lambda-fun-${lower(var.environment)}"
  handler       = var.lambda_function_handler
  role          = var.lambda_function_role
  runtime       = var.lambda_function_runtime

  filename                       = var.lambda_function_filename
  s3_bucket                      = var.lambda_function_s3_bucket
  s3_key                         = var.lambda_function_s3_key
  s3_object_version              = var.lambda_function_s3_object_version
  description                    = var.lambda_function_description
  layers                         = var.lambda_function_layers
  memory_size                    = var.lambda_function_memory_size
  timeout                        = var.lambda_function_timeout
  reserved_concurrent_executions = var.lambda_function_reserved_concurrent_executions
  publish                        = var.lambda_function_publish
  kms_key_arn                    = var.lambda_function_kms_key_arn
  source_code_hash               = var.lambda_function_source_code_hash

  dynamic "dead_letter_config" {
    iterator = dead_letter_config
    for_each = var.lambda_function_dead_letter_config

    content {
      target_arn = lookup(dead_letter_config.value, "target_arn", null)
    }
  }

  dynamic "tracing_config" {
    iterator = tracing_config
    for_each = var.lambda_function_tracing_config

    content {
      mode = lookup(tracing_config.value, "mode", null)
    }
  }

  dynamic "vpc_config" {
    iterator = vpc_config
    for_each = var.lambda_function_vpc_config

    content {
      subnet_ids         = lookup(vpc_config.value, "subnet_ids", null)
      security_group_ids = lookup(vpc_config.value, "security_group_ids", null)
    }
  }

  dynamic "environment" {
    for_each = var.lambda_function_environment == null ? [] : [var.lambda_function_environment]

    content {
      variables = var.lambda_function_environment
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.lambda_function_timeouts)) > 0 ? [var.lambda_function_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
    }
  }

  tags = merge(
    {
      Name = var.lambda_function_name != "" ? var.lambda_function_name : "${lower(var.name)}-lambda-fun-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
