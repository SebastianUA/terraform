#---------------------------------------------------------------
# 1rst VPC for peering
#---------------------------------------------------------------
module "vpc_1" {
  source      = "../../modules/vpc"
  name        = "test"
  environment = "stage"

  # VPC
  enable_vpc                           = true
  vpc_name                             = "vpc_1_peering"
  vpc_instance_tenancy                 = "dedicated"
  vpc_enable_dns_support               = true
  vpc_enable_dns_hostnames             = true
  vpc_assign_generated_ipv6_cidr_block = false
  # Dedicated tenancy VPCs cannot be enabled for ClassicLink by default
  vpc_enable_classiclink = false
  vpc_cidr_block         = "6.6.0.0/16"

  private_subnet_cidrs = ["6.6.1.0/24"]
  public_subnet_cidrs  = ["6.6.2.0/24", "6.6.3.0/24"]

  # Internet-GateWay
  enable_internet_gateway = true

  # NAT
  enable_nat_gateway = false
  single_nat_gateway = true

  # VPN
  enable_vpn_gateway = false

  # DHCP
  enable_dhcp                          = true
  vpc_dhcp_options_domain_name         = "ec2.internal"
  vpc_dhcp_options_domain_name_servers = ["AmazonProvidedDNS"]

  # EIP
  enable_eip = false

  # VPC peering
  enable_vpc_peering_connection_accepter      = true
  vpc_peering_connection_accepter_auto_accept = true


  peering_destination_cidr_block = "172.32.0.0/16"
  peering_gateway_id             = module.vpc_2.vpc_peering_connection_id

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}

#---------------------------------------------------------------
# 2d VPC for peering with VPC flow log & VPC network ACLs
#---------------------------------------------------------------
module "vpc_2" {
  source      = "../../modules/vpc"
  name        = "test2"
  environment = "stage"

  # VPC
  enable_vpc                           = true
  vpc_name                             = "vpc_2_peering"
  vpc_instance_tenancy                 = "dedicated"
  vpc_enable_dns_support               = true
  vpc_enable_dns_hostnames             = true
  vpc_assign_generated_ipv6_cidr_block = false
  # Dedicated tenancy VPCs cannot be enabled for ClassicLink by default
  vpc_enable_classiclink = false
  vpc_cidr_block         = "172.32.0.0/16"

  private_subnet_cidrs = ["172.32.64.0/20"]
  public_subnet_cidrs  = ["172.32.80.0/20", "172.32.0.0/20"]

  # Internet-GateWay
  enable_internet_gateway = true

  # NAT
  enable_nat_gateway = false
  single_nat_gateway = true

  # VPN
  enable_vpn_gateway = false

  # DHCP
  enable_dhcp                          = true
  vpc_dhcp_options_domain_name         = "ec2.internal"
  vpc_dhcp_options_domain_name_servers = ["AmazonProvidedDNS"]

  # EIP
  enable_eip = false

  # VPC flow log
  enable_flow_log = false
  flow_log_stack = [
    {
      name         = "vpc-flow-log-cloud-watch-logs"
      traffic_type = "REJECT"
      iam_role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/vpc-flow-log"

      log_destination = "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:vpc-flow-log-test"
    },
    {
      name                 = "vpc-flow-log-s3"
      traffic_type         = "ALL"
      iam_role_arn         = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/vpc-flow-log"
      log_destination_type = "s3"
      log_destination      = module.s3_flow_logs.s3_bucket_arn
    }
  ]

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
  enable_vpc_peering_connection      = true
  vpc_peering_connection_peer_vpc_id = module.vpc_1.vpc_id

  vpc_peering_connection_accepter = [
    {
      allow_remote_vpc_dns_resolution  = true
      allow_classic_link_to_remote_vpc = true
      allow_vpc_to_remote_classic_link = true
    }
  ]

  vpc_peering_connection_requester = [
    {
      allow_remote_vpc_dns_resolution  = true
      allow_classic_link_to_remote_vpc = true
      allow_vpc_to_remote_classic_link = true
    }
  ]

  vpc_peering_connection_auto_accept = true

  peering_destination_cidr_block = "6.6.0.0/16"

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

  depends_on = [
    module.s3_flow_logs
  ]
}
