#---------------------------------------------------
# AWS API Gateway response
#---------------------------------------------------
resource "aws_api_gateway_gateway_response" "api_gateway_gateway_response" {
  count = var.enable_api_gateway_gateway_response ? 1 : 0

  rest_api_id   = var.api_gateway_gateway_response_rest_api_id != "" && ! var.enable_api_gateway_rest_api ? var.api_gateway_gateway_response_rest_api_id : element(concat(aws_api_gateway_rest_api.api_gateway_rest_api.*.id, [""]), 0)
  response_type = upper(var.api_gateway_gateway_response_response_type)

  status_code         = var.api_gateway_gateway_response_status_code
  response_templates  = var.api_gateway_gateway_response_response_templates
  response_parameters = var.api_gateway_gateway_response_response_parameters

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_api_gateway_rest_api.api_gateway_rest_api
  ]
}
