#---------------------------------------------------
# AWS API Gateway documentation version
#---------------------------------------------------
resource "aws_api_gateway_documentation_version" "api_gateway_documentation_version" {
  count = var.enable_api_gateway_documentation_version ? 1 : 0

  rest_api_id = var.api_gateway_documentation_version_rest_api_id != "" && ! var.enable_api_gateway_rest_api ? var.api_gateway_documentation_version_rest_api_id : element(concat(aws_api_gateway_rest_api.api_gateway_rest_api.*.id, [""]), 0)
  version     = var.api_gateway_documentation_version_version != "" ? var.api_gateway_documentation_version_version : "${lower(var.name)}-api-gw-doc-version-${lower(var.environment)}"

  description = var.api_gateway_documentation_version_description

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_api_gateway_rest_api.api_gateway_rest_api
  ]
}
