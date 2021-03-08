#---------------------------------------------------------------
# VPC Endpoint
#---------------------------------------------------------------
module "vpc_endpoint" {
  source      = "../../modules/vpc"
  name        = "endpoint"
  environment = "stage"

  # VPC
  enable_vpc                           = true
  vpc_name                             = ""
  vpc_instance_tenancy                 = "dedicated"
  vpc_enable_dns_support               = true
  vpc_enable_dns_hostnames             = true
  vpc_assign_generated_ipv6_cidr_block = false
  # Dedicated tenancy VPCs cannot be enabled for ClassicLink by default
  vpc_enable_classiclink = false
  vpc_cidr_block         = "10.11.0.0/16"

  private_subnet_cidrs = ["10.11.1.0/24"]
  public_subnet_cidrs  = ["10.11.2.0/24", "10.11.3.0/24"]
  #azs                                 = ["us-east-1a", "us-east-1b"]

  # Internet-GateWay
  enable_internet_gateway = true

  # NAT
  #enable_nat_gateway                  = true
  single_nat_gateway = true

  # DHCP
  enable_dhcp                          = true
  vpc_dhcp_options_domain_name         = "ec2.internal"
  vpc_dhcp_options_domain_name_servers = ["AmazonProvidedDNS"]

  # EIP
  enable_eip = false

  # VPN
  enable_vpn_gateway                = false
  vpn_gateway_name                  = ""
  vpn_gateway_availability_zone     = null
  vpn_gateway_amazon_side_asn       = 64512
  vpn_connection_static_routes_only = true
  vpn_connection_route_cidr_block   = "192.168.113.0/24" # Set IP addr cidr; For example: office's IP subnet.

  customer_gateway_bgp_asn    = 65000
  customer_gateway_ip_address = "1.2.3.4" # Set IP addr gateway; For example: office's IP GW.

  # VPC endpoints
  enable_vpc_endpoint = true
  vpc_endpoint_stack = [
    {
      name                = "s3-endpoint-for-emr"
      service_name        = "com.amazonaws.us-east-1.s3"
      vpc_endpoint_type   = "Gateway"
      security_group_ids  = ["sg-0ac2ce954f45c8f6a", "sg-0919aabecaea96510"]
      auto_accept         = true
      private_dns_enabled = true
    },
    {
      name                = "sqs-endpoint-for-emr"
      service_name        = "com.amazonaws.us-east-1.sqs"
      vpc_endpoint_type   = "Interface"
      security_group_ids  = ["sg-0ac2ce954f45c8f6a", "sg-0919aabecaea96510"]
      auto_accept         = true
      private_dns_enabled = true
    },
    {
      name                = "sns-endpoint-for-emr"
      service_name        = "com.amazonaws.us-east-1.sns"
      vpc_endpoint_type   = "Interface"
      security_group_ids  = ["sg-0ac2ce954f45c8f6a", "sg-0919aabecaea96510"]
      auto_accept         = true
      private_dns_enabled = true
    }
  ]

  # VPC endpoint service
  enable_vpc_endpoint_service = true
  vpc_endpoint_service_stack = [
    {
      acceptance_required = false

      gateway_load_balancer_arns = null
      network_load_balancer_arns = null
      allowed_principals         = null
      private_dns_name           = null
    }
  ]


  tags = map("Env", "stage", "Orchestration", "Terraform")
}
