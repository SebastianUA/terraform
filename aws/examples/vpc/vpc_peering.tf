#---------------------------------------------------------------
# 1rst VPC for peering
#---------------------------------------------------------------
module "vpc_1" {
  source      = "../../modules/vpc"
  name        = "test"
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

  vpc_cidr             = "6.6.0.0/16"
  private_subnet_cidrs = ["6.6.1.0/24"]
  public_subnet_cidrs  = ["6.6.2.0/24", "6.6.3.0/24"]
  #azs                                 = ["us-east-1a", "us-east-1b"]

  #Internet-GateWay
  enable_internet_gateway = true
  #NAT
  #enable_nat_gateway                  = true
  single_nat_gateway = true
  #VPN
  enable_vpn_gateway = false
  #DHCP
  enable_dhcp = true
  # EIP
  enable_eip = false

  tags = map("Env", "stage", "Orchestration", "Terraform")

  # for peering
  peering_destination_cidr_block = "172.32.0.0/16"
  peering_gateway_id             = module.vpc_2.vpc_peering_connection_id
}

#---------------------------------------------------------------
# 2d VPC for peering with VPC flow log & VPC network ACLs
#---------------------------------------------------------------
module "vpc_2" {
  source      = "../../modules/vpc"
  name        = "test2"
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

  vpc_cidr             = "172.32.0.0/16"
  private_subnet_cidrs = ["172.32.64.0/20"]
  public_subnet_cidrs  = ["172.32.80.0/20", "172.32.0.0/20"]
  #azs                                 = ["us-east-1a", "us-east-1b"]


  #Internet-GateWay
  enable_internet_gateway = true
  #NAT
  #enable_nat_gateway                  = true
  single_nat_gateway = true
  #VPN
  enable_vpn_gateway = false
  #DHCP
  enable_dhcp = true
  # EIP
  enable_eip = false

  # VPC flow log
  enable_flow_log          = false
  flow_log_name            = ""
  flow_log_traffic_type    = "ALL"
  flow_log_iam_role_arn    = "arn:aws:iam::167127734783:role/vpc-flow-log"
  flow_log_log_destination = "arn:aws:logs:us-east-1:167127734783:log-group:vpc-flow-log-test"

  # VPC network ACLs
  enable_network_acl     = true
  network_acl_name       = ""
  network_acl_subnet_ids = []

  network_acl_ingress = [{
    from_port       = 0
    to_port         = 0
    rule_no         = 100
    action          = "allow"
    protocol        = -1
    cidr_block      = "0.0.0.0/0"
    ipv6_cidr_block = null
    icmp_type       = 0
    icmp_code       = 0
  }]

  network_acl_egress = [{
    from_port       = 0
    to_port         = 0
    rule_no         = 100
    action          = "allow"
    protocol        = -1
    cidr_block      = "0.0.0.0/0"
    ipv6_cidr_block = null
    icmp_type       = 0
    icmp_code       = 0
  }]

  # VPC peering
  enable_vpc_peering                 = true
  vpc_peering_connection_peer_vpc_id = module.vpc_1.vpc_id
  vpc_peering_connection_auto_accept = true
  peering_destination_cidr_block     = "6.6.0.0/16"

  tags = map("Env", "stage", "Orchestration", "Terraform")
}
