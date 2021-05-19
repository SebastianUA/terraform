#---------------------------------------------------
# AWS API Gateway rest api
#---------------------------------------------------
resource "aws_api_gateway_rest_api" "api_gateway_rest_api" {
  count = var.enable_api_gateway_rest_api ? 1 : 0

  name = var.api_gateway_rest_api_name != "" ? var.api_gateway_rest_api_name : "${lower(var.name)}-api-gw-rest-api-${lower(var.environment)}"

  description              = var.api_gateway_rest_api_description
  binary_media_types       = var.api_gateway_rest_api_binary_media_types
  minimum_compression_size = var.api_gateway_rest_api_minimum_compression_size
  body                     = var.api_gateway_rest_api_body
  policy                   = var.api_gateway_rest_api_policy
  api_key_source           = upper(var.api_gateway_rest_api_api_key_source)

  dynamic "endpoint_configuration" {
    iterator = endpoint_configuration
    for_each = var.api_gateway_rest_api_endpoint_configuration

    content {
      types = lookup(endpoint_configuration.value, "types", ["EDGE"])

      vpc_endpoint_ids = lookup(endpoint_configuration.value, "types", null)
    }
  }

  tags = merge(
    {
      Name = var.api_gateway_rest_api_name != "" ? var.api_gateway_rest_api_name : "${lower(var.name)}-api-gw-rest-api-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
