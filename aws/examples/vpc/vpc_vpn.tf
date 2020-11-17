#---------------------------------------------------------------
# VPC VPN
#---------------------------------------------------------------
module "vpc_vpn" {
  source      = "../../modules/vpc"
  name        = "vpn"
  environment = "stage"

  # VPC
  enable_vpc = true
  vpc_name   = ""

  instance_tenancy                 = "dedicated"
  enable_dns_support               = true
  enable_dns_hostnames             = true
  assign_generated_ipv6_cidr_block = false
  # Dedicated tenancy VPCs cannot be enabled for ClassicLink by default
  enable_classiclink = false

  vpc_cidr             = "10.10.0.0/16"
  private_subnet_cidrs = ["10.10.1.0/24"]
  public_subnet_cidrs  = ["10.10.2.0/24", "10.10.3.0/24"]
  #azs                                 = ["us-east-1a", "us-east-1b"]

  #Internet-GateWay
  enable_internet_gateway = true
  #NAT
  #enable_nat_gateway                  = true
  single_nat_gateway = true
  #DHCP
  enable_dhcp = true
  # EIP
  enable_eip = false

  #VPN
  enable_vpn_gateway                = true
  vpn_gw_name                       = ""
  vpn_gw_availability_zone          = null
  vpn_gw_amazon_side_asn            = 64512
  vpn_connection_static_routes_only = true
  vpn_connection_route_cidr_block   = "192.168.113.0/24" # Set IP addr cidr; For example: office's IP subnet.

  customer_gateway_bgp_asn    = 65000
  customer_gateway_ip_address = "1.2.3.4" # Set IP addr gateway; For example: office's IP GW.

  tags = map("Env", "stage", "Orchestration", "Terraform")
}
