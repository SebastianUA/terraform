#---------------------------------------------------------------
# VPC Endpoint
#---------------------------------------------------------------
module "vpc_endpoint" {
  source      = "../../modules/vpc"
  name        = "endpoint"
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

  vpc_cidr             = "10.11.0.0/16"
  private_subnet_cidrs = ["10.11.1.0/24"]
  public_subnet_cidrs  = ["10.11.2.0/24", "10.11.3.0/24"]
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
  enable_vpn_gateway                = false
  vpn_gw_name                       = ""
  vpn_gw_availability_zone          = null
  vpn_gw_amazon_side_asn            = 64512
  vpn_connection_static_routes_only = true
  vpn_connection_route_cidr_block   = "192.168.113.0/24" # Set IP addr cidr; For example: office's IP subnet.

  customer_gateway_bgp_asn    = 65000
  customer_gateway_ip_address = "1.2.3.4" # Set IP addr gateway; For example: office's IP GW.

  # VPC endpoint (S3)
  enable_vpc_endpoint              = false
  vpc_endpoint_name                = "s3-endpoint-for-emr"
  vpc_endpoint_service_name        = "com.amazonaws.us-east-1.s3"
  vpc_endpoint_vpc_endpoint_type   = "Gateway"
  vpc_endpoint_security_group_ids  = ["sg-0ac2ce954f45c8f6a", "sg-0919aabecaea96510"]
  vpc_endpoint_auto_accept         = true
  vpc_endpoint_private_dns_enabled = true

  # VPC endpoint (SQS)
  #enable_vpc_endpoint                 = false
  #vpc_endpoint_name                   = "sqs-endpoint-for-emr"
  #vpc_endpoint_service_name           = "com.amazonaws.us-east-1.sqs"
  #vpc_endpoint_vpc_endpoint_type      = "Interface"
  #vpc_endpoint_security_group_ids     = ["sg-0ac2ce954f45c8f6a", "sg-0919aabecaea96510"]
  #vpc_endpoint_auto_accept            = true
  #vpc_endpoint_private_dns_enabled    = true

  # VPC endpoint (SNS)
  #enable_vpc_endpoint                 = false
  #vpc_endpoint_name                   = "sns-endpoint-for-emr"
  #vpc_endpoint_service_name           = "com.amazonaws.us-east-1.sns"
  #vpc_endpoint_vpc_endpoint_type      = "Interface"
  #vpc_endpoint_security_group_ids     = ["sg-0ac2ce954f45c8f6a", "sg-0919aabecaea96510"]
  #vpc_endpoint_auto_accept            = true
  #vpc_endpoint_private_dns_enabled    = true

  tags = map("Env", "stage", "Orchestration", "Terraform")
}
