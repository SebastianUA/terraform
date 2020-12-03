#---------------------------------------------------
# AWS EC2 transit gateway peering attachment accepter
#---------------------------------------------------
resource "aws_ec2_transit_gateway_peering_attachment_accepter" "transit_gateway_peering_attachment_accepter" {
  count = var.enable_transit_gateway_peering_attachment_accepter ? 1 : 0

  transit_gateway_attachment_id = var.transit_gateway_peering_attachment_accepter_transit_gateway_attachment_id != "" ? var.transit_gateway_peering_attachment_accepter_transit_gateway_attachment_id : (var.enable_transit_gateway_peering_attachment ? aws_ec2_transit_gateway_peering_attachment.transit_gateway_peering_attachment[0].id : null)

  tags = merge(
    {
      Name = var.transit_gateway_peering_attachment_accepter_name != "" ? lower(var.transit_gateway_peering_attachment_accepter_name) : "${lower(var.name)}-tgw-peering-attachment-accepter-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_ec2_transit_gateway_peering_attachment.transit_gateway_peering_attachment
  ]
}