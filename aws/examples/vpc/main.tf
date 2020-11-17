#---------------------------------------------------------------
# VPC
#---------------------------------------------------------------
module "vpc" {
  source      = "../../modules/vpc"
  name        = "vpc"
  environment = "dev"

  # VPC
  enable_vpc = true
  vpc_name   = "vpc"

  instance_tenancy                 = "default"
  enable_dns_support               = true
  enable_dns_hostnames             = true
  assign_generated_ipv6_cidr_block = false

  vpc_cidr             = "12.6.0.0/16"
  private_subnet_cidrs = ["12.6.1.0/24"]
  public_subnet_cidrs  = ["12.6.2.0/24", "12.6.3.0/24"]

  #Internet-GateWay
  enable_internet_gateway = true
  #NAT
  enable_nat_gateway = true
  single_nat_gateway = true

  #DHCP
  enable_dhcp                      = true
  dhcp_options_domain_name         = "ec2.internal"
  dhcp_options_domain_name_servers = ["AmazonProvidedDNS"]

  tags = map("Env", "stage", "Orchestration", "Terraform")
}
