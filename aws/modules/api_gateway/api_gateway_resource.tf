#---------------------------------------------------
# AWS API Gateway resource
#---------------------------------------------------
resource "aws_api_gateway_resource" "api_gateway_resource" {
  count = var.enable_api_gateway_resource ? 1 : 0

  rest_api_id = var.api_gateway_resource_rest_api_id != "" && !var.enable_api_gateway_rest_api ? var.api_gateway_resource_rest_api_id : element(concat(aws_api_gateway_rest_api.api_gateway_rest_api.*.id, [""]), 0)
  parent_id   = var.api_gateway_resource_parent_id != "" && !var.enable_api_gateway_rest_api ? var.api_gateway_resource_parent_id : element(concat(aws_api_gateway_rest_api.api_gateway_rest_api.*.root_resource_id, [""]), 0)
  path_part   = var.api_gateway_resource_path_part

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_api_gateway_rest_api.api_gateway_rest_api
  ]
}
