#---------------------------------------------------
# AWS API Gateway documentation part
#---------------------------------------------------
resource "aws_api_gateway_documentation_part" "api_gateway_documentation_part" {
  count = var.enable_api_gateway_documentation_part ? 1 : 0

  rest_api_id = var.api_gateway_documentation_part_rest_api_id != "" && !var.enable_api_gateway_rest_api ? var.api_gateway_documentation_part_rest_api_id : element(concat(aws_api_gateway_rest_api.api_gateway_rest_api.*.id, [""]), 0)
  properties  = var.api_gateway_documentation_part_properties

  dynamic "location" {
    iterator = location
    for_each = var.api_gateway_documentation_part_location
    content {
      type = lookup(location.value, "type", null)

      method      = lookup(location.value, "method", null)
      name        = lookup(location.value, "name", null)
      path        = lookup(location.value, "path", null)
      status_code = lookup(location.value, "status_code", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_api_gateway_rest_api.api_gateway_rest_api
  ]
}
