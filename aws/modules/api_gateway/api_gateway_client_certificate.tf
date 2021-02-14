#---------------------------------------------------
# AWS API Gateway client certificate
#---------------------------------------------------
resource "aws_api_gateway_client_certificate" "api_gateway_client_certificate" {
  count = var.enable_api_gateway_client_certificate ? 1 : 0

  description = var.api_gateway_client_certificate_description

  tags = merge(
    {
      Name = var.api_gateway_domain_name_domain_name != "" ? var.api_gateway_domain_name_domain_name : "${lower(var.name)}-api-gw-domain-name-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
