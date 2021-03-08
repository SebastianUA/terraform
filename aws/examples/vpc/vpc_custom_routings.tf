#---------------------------------------------------------------
# VPC custom routing
#---------------------------------------------------------------
module "vpc_custom_routings" {
  source      = "../../modules/vpc"
  name        = "vpc_custom_routings"
  environment = "dev"

  # VPC
  enable_vpc                           = true
  vpc_name                             = "vpc-custom-routings"
  vpc_instance_tenancy                 = "default"
  vpc_enable_dns_support               = true
  vpc_enable_dns_hostnames             = true
  vpc_assign_generated_ipv6_cidr_block = false
  vpc_cidr_block                       = "12.11.0.0/16"

  private_subnet_cidrs = ["12.11.1.0/24"]
  public_subnet_cidrs  = ["12.11.2.0/24", "12.11.3.0/24"]

  # Internet-GateWay
  enable_internet_gateway = true

  # NAT
  enable_nat_gateway = false
  single_nat_gateway = false

  # DHCP
  enable_dhcp                          = true
  vpc_dhcp_options_domain_name         = "ec2.internal"
  vpc_dhcp_options_domain_name_servers = ["AmazonProvidedDNS"]

  # EIP
  enable_eip = false

  private_custom_peering_destination_cidr_block = ["1.2.3.4/32", "4.3.2.1/32"]
  private_custom_gateway_id                     = "tgw-05b56a37c420a2635"

  tags = map("Env", "stage", "Orchestration", "Terraform")
}
