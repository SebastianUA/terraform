#---------------------------------------------------
# AWS API Gateway api key
#---------------------------------------------------
resource "aws_api_gateway_api_key" "api_gateway_api_key" {
  count = var.enable_api_gateway_api_key ? 1 : 0

  name = var.api_gateway_api_key_name != "" ? var.api_gateway_api_key_name : "${lower(var.name)}-api-gw-api-key-${lower(var.environment)}"

  description = var.api_gateway_api_key_description
  enabled     = var.api_gateway_api_key_enabled
  value       = var.api_gateway_api_key_value

  tags = merge(
    {
      Name = var.api_gateway_api_key_name != "" ? var.api_gateway_api_key_name : "${lower(var.name)}-api-gw-api-key-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
