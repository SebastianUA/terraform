#---------------------------------------------------
# AWS API Gateway vpc link
#---------------------------------------------------
resource "aws_apigatewayv2_vpc_link" "apigatewayv2_vpc_link" {
  count = var.enable_apigatewayv2_vpc_link ? 1 : 0

  name               = var.apigatewayv2_vpc_link_name != "" ? var.apigatewayv2_vpc_link_name : "${lower(var.name)}-apigatewayv2-vpc-link-${lower(var.environment)}"
  security_group_ids = var.apigatewayv2_vpc_link_security_group_ids
  subnet_ids         = var.apigatewayv2_vpc_link_subnet_ids

  tags = merge(
    {
      Name = var.apigatewayv2_vpc_link_name != "" ? var.apigatewayv2_vpc_link_name : "${lower(var.name)}-apigatewayv2-vpc-link-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}