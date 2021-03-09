#---------------------------------------------------------------
# VPC VPN
#---------------------------------------------------------------
module "vpc_vpn" {
  source      = "../../modules/vpc"
  name        = "vpn"
  environment = "stage"

  # VPC
  enable_vpc                           = true
  vpc_name                             = "vpc_vpn"
  vpc_instance_tenancy                 = "dedicated"
  vpc_enable_dns_support               = true
  vpc_enable_dns_hostnames             = true
  vpc_assign_generated_ipv6_cidr_block = false
  # Dedicated tenancy VPCs cannot be enabled for ClassicLink by default
  vpc_enable_classiclink = false
  vpc_cidr_block         = "10.10.0.0/16"

  private_subnet_cidrs = ["10.10.1.0/24"]
  public_subnet_cidrs  = ["10.10.2.0/24", "10.10.3.0/24"]
  azs                  = ["${data.aws_region.current.name}a", "${data.aws_region.current.name}b"]

  # Internet-GateWay
  enable_internet_gateway = true

  # NAT
  enable_nat_gateway = false
  single_nat_gateway = true

  # DHCP
  enable_dhcp                          = true
  vpc_dhcp_options_domain_name         = "ec2.internal"
  vpc_dhcp_options_domain_name_servers = ["AmazonProvidedDNS"]

  # EIP
  enable_eip = false

  # VPN
  enable_vpn_gateway            = true
  vpn_gateway_name              = ""
  vpn_gateway_availability_zone = null
  vpn_gateway_amazon_side_asn   = 64512

  enable_vpn_connection             = true
  vpn_connection_static_routes_only = true

  enable_vpn_connection_route     = true
  vpn_connection_route_cidr_block = "192.168.113.0/24" # Set IP addr cidr; For example: office's IP subnet.

  enable_customer_gateway     = true
  customer_gateway_bgp_asn    = 65000
  customer_gateway_ip_address = "1.2.3.4" # Set IP addr gateway; For example: office's IP GW.

  tags = map("Env", "stage", "Orchestration", "Terraform")
}
