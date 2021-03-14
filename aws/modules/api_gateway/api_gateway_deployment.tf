#---------------------------------------------------
# AWS API Gateway deployment
#---------------------------------------------------
resource "aws_api_gateway_deployment" "api_gateway_deployment" {
  count = var.enable_api_gateway_deployment ? 1 : 0

  rest_api_id = var.api_gateway_deployment_rest_api_id != "" && ! var.enable_api_gateway_rest_api ? var.api_gateway_deployment_rest_api_id : element(concat(aws_api_gateway_rest_api.api_gateway_rest_api.*.id, [""]), 0)

  description       = var.api_gateway_deployment_description
  stage_name        = var.api_gateway_deployment_stage_name
  stage_description = var.api_gateway_deployment_stage_description
  variables         = var.api_gateway_deployment_variables

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_api_gateway_rest_api.api_gateway_rest_api
  ]
}
