#---------------------------------------------------
# AWS EC2 transit gateway peering attachment
#---------------------------------------------------
resource "aws_ec2_transit_gateway_peering_attachment" "transit_gateway_peering_attachment" {
  count = var.enable_transit_gateway_peering_attachment ? 1 : 0

  peer_region             = var.transit_gateway_peering_attachment_peer_region
  peer_transit_gateway_id = var.transit_gateway_peering_attachment_peer_transit_gateway_id != "" ? var.transit_gateway_peering_attachment_peer_transit_gateway_id : null
  transit_gateway_id      = var.transit_gateway_peering_attachment_transit_gateway_id

  peer_account_id = var.transit_gateway_peering_attachment_peer_account_id != "" ? var.transit_gateway_peering_attachment_peer_account_id : (var.enable_transit_gateway ? aws_ec2_transit_gateway.transit_gateway[0].owner_id : null)

  tags = merge(
    {
      Name = var.transit_gateway_peering_attachment_name != "" ? lower(var.transit_gateway_peering_attachment_name) : "${lower(var.name)}-tgw-peering-attachment-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_ec2_transit_gateway.transit_gateway
  ]
}