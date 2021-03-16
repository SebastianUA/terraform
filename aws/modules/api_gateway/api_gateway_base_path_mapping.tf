#---------------------------------------------------
# AWS API Gateway base path mapping
#---------------------------------------------------
resource "aws_api_gateway_base_path_mapping" "api_gateway_base_path_mapping" {
  count = var.enable_api_gateway_base_path_mapping ? 1 : 0

  api_id      = var.api_gateway_base_path_mapping_api_id != "" && !var.enable_api_gateway_rest_api ? var.api_gateway_base_path_mapping_api_id : element(concat(aws_api_gateway_rest_api.api_gateway_rest_api.*.id, [""]), 0)
  domain_name = var.api_gateway_base_path_mapping_domain_name != "" && !var.enable_api_gateway_domain_name ? var.api_gateway_base_path_mapping_domain_name : element(concat(aws_api_gateway_domain_name.api_gateway_domain_name.*.domain_name, [""]), 0)

  stage_name = var.api_gateway_base_path_mapping_stage_name != "" && !var.enable_api_gateway_stage ? var.api_gateway_base_path_mapping_stage_name : element(concat(aws_api_gateway_deployment.api_gateway_deployment.*.stage_name, [""]), 0)
  base_path  = var.api_gateway_base_path_mapping_base_path

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_api_gateway_rest_api.api_gateway_rest_api,
    aws_api_gateway_deployment.api_gateway_deployment,
    aws_api_gateway_domain_name.api_gateway_domain_name
  ]
}
