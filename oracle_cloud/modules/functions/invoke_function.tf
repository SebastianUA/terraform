#-----------------------------------------------------------
# functions invoke function
#-----------------------------------------------------------
resource "oci_functions_invoke_function" "functions_invoke_function" {
  count = var.enable_functions_invoke_function ? 1 : 0

  # Required
  function_id = var.functions_invoke_function_function_id != "" && !var.enable_functions_function ? var.functions_invoke_function_function_id : (var.enable_functions_function ? element(oci_functions_function.functions_function.*.id, 0) : null)

  # Optional
  invoke_function_body  = var.functions_invoke_function_invoke_function_body
  fn_intent             = var.functions_invoke_function_fn_intent
  fn_invoke_type        = var.functions_invoke_function_fn_invoke_type
  base64_encode_content = var.functions_invoke_function_base64_encode_content

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.functions_invoke_function_timeouts)) > 0 ? [var.functions_invoke_function_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}