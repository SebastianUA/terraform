#---------------------------------------------------
# AWS lambda permission
#---------------------------------------------------
resource "aws_lambda_permission" "lambda_permission" {
  count = var.enable_lambda_permission ? 1 : 0

  action        = var.lambda_permission_action
  function_name = var.lambda_permission_function_name != "" && !var.enable_lambda_function && !var.enable_lambda_alias ? var.lambda_permission_function_name : (var.enable_lambda_function && !var.enable_lambda_alias ? element(concat(aws_lambda_function.lambda_function.*.function_name, [""]), 0) : (var.enable_lambda_alias ? element(concat(aws_lambda_alias.lambda_alias.*.function_name, [""]), 0) : null))
  principal     = var.lambda_permission_principal

  event_source_token = var.lambda_permission_event_source_token
  # qualifier           = var.lambda_permission_qualifier != "" && !var.enable_lambda_function && !var.enable_lambda_alias ? var.lambda_permission_qualifier : (var.enable_lambda_function && !var.enable_lambda_alias ? element(concat(aws_lambda_function.lambda_function.*.version, [""]), 0) : (var.enable_lambda_alias ? element(concat(aws_lambda_alias.lambda_alias.*.name, [""]), 0) : null))
  qualifier = var.lambda_permission_qualifier != "" ? var.lambda_permission_qualifier : (var.enable_lambda_function && !var.enable_lambda_alias ? element(concat(aws_lambda_function.lambda_function.*.version, [""]), 0) : (var.enable_lambda_alias ? element(concat(aws_lambda_alias.lambda_alias.*.name, [""]), 0) : null))

  source_account      = var.lambda_permission_source_account
  source_arn          = var.lambda_permission_source_arn
  statement_id        = var.lambda_permission_statement_id
  statement_id_prefix = var.lambda_permission_statement_id_prefix

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_lambda_function.lambda_function,
    aws_lambda_alias.lambda_alias
  ]
}
