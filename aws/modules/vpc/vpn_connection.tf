#---------------------------------------------------
# Create AWS VPN connection
#---------------------------------------------------

# resource "aws_vpn_connection" "example" {
#   customer_gateway_id = "${aws_customer_gateway.example.id}"
#   transit_gateway_id  = "${aws_ec2_transit_gateway.example.id}"
#   type                = "${aws_customer_gateway.example.type}"
#}

# https://www.terraform.io/docs/providers/aws/r/vpn_connection.html
