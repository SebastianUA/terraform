#---------------------------------------------------------------
# VPC VPN
#---------------------------------------------------------------
module "vpc_vpn" {
  source      = "../../modules/vpn"
  name        = "vpn"
  environment = "stage"


  # VPN
  enable_vpn_gateway            = true
  vpn_gateway_vpc_id            = "vpc-1"
  vpn_gateway_name              = "tmp-vpn"
  vpn_gateway_availability_zone = null
  vpn_gateway_amazon_side_asn   = 64512

  enable_vpn_gateway_route_propagation         = false
  vpn_gateway_route_propagation_vpn_gateway_id = ""
  vpn_gateway_route_propagation_route_table_id = "rt-434fdf"

  enable_vpn_connection             = true
  vpn_connection_static_routes_only = true

  enable_vpn_connection_route     = true
  vpn_connection_route_cidr_block = "192.168.113.0/24" # Set IP addr cidr; For example: office's IP subnet.

  enable_customer_gateway     = true
  customer_gateway_bgp_asn    = 65000
  customer_gateway_ip_address = "1.2.3.4" # Set IP addr gateway; For example: office's IP GW.

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}
