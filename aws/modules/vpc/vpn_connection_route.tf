#---------------------------------------------------
# Create AWS VPN connection route
#---------------------------------------------------
# resource "aws_vpn_connection_route" "office" {
#   destination_cidr_block = "192.168.10.0/24"
#   vpn_connection_id      = "${aws_vpn_connection.main.id}"
# }

# https://www.terraform.io/docs/providers/aws/r/vpn_connection_route.html
