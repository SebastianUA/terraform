#---------------------------------------------------
# AWS API Gateway VPC link
#---------------------------------------------------
resource "aws_api_gateway_vpc_link" "api_gateway_vpc_link" {
  count = var.enable_api_gateway_vpc_link ? 1 : 0

  name        = var.api_gateway_vpc_link_name != "" ? var.api_gateway_vpc_link_name : "${lower(var.name)}-api-gw-vpc-link-${lower(var.environment)}"
  target_arns = var.api_gateway_vpc_link_target_arns

  description = var.api_gateway_vpc_link_description

  tags = merge(
    {
      "Name" = var.api_gateway_vpc_link_name != "" ? var.api_gateway_vpc_link_name : "${lower(var.name)}-api-gw-vpc-link-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
