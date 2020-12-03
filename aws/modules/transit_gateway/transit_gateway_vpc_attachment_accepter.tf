#---------------------------------------------------
# AWS EC2 transit gateway vpc attachment accepter
#---------------------------------------------------
resource "aws_ec2_transit_gateway_vpc_attachment_accepter" "transit_gateway_vpc_attachment_accepter" {
  count = var.enable_transit_gateway_vpc_attachment_accepter ? 1 : 0

  transit_gateway_attachment_id = var.transit_gateway_vpc_attachment_accepter_transit_gateway_attachment_id != "" ? var.transit_gateway_vpc_attachment_accepter_transit_gateway_attachment_id : (var.enable_transit_gateway_vpc_attachment ? aws_ec2_transit_gateway_vpc_attachment.transit_gateway_vpc_attachment[0].id : null)

  transit_gateway_default_route_table_association = var.transit_gateway_vpc_attachment_accepter_transit_gateway_default_route_table_association
  transit_gateway_default_route_table_propagation = var.transit_gateway_vpc_attachment_accepter_transit_gateway_default_route_table_propagation

  tags = merge(
    {
      Name = var.transit_gateway_vpc_attachment_accepter_name != "" ? lower(var.transit_gateway_vpc_attachment_accepter_name) : "${lower(var.name)}-tgw-vpc-attachment-accepter-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_ec2_transit_gateway_vpc_attachment.transit_gateway_vpc_attachment
  ]
}