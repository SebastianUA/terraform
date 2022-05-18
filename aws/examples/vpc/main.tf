#---------------------------------------------------------------
# AWS S3
#---------------------------------------------------------------
module "s3_flow_logs" {
  source      = "../../modules/s3"
  name        = "TEST"
  environment = "dev"

  # AWS S3 bucket
  enable_s3_bucket = true
  s3_bucket_name   = "s3-flow-log-test"

  // Enable S3 bucket ACL
  enable_s3_bucket_acl = true
  s3_bucket_acl_acl    = "private"

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}

#---------------------------------------------------------------
# VPC
#---------------------------------------------------------------
module "vpc" {
  source      = "../../modules/vpc"
  name        = "tmp"
  environment = "dev"

  # VPC
  enable_vpc                           = true
  vpc_name                             = "vpc"
  vpc_instance_tenancy                 = "default"
  vpc_enable_dns_support               = true
  vpc_enable_dns_hostnames             = true
  vpc_assign_generated_ipv6_cidr_block = false
  vpc_cidr_block                       = "12.6.0.0/16"

  private_subnet_cidrs = ["12.6.1.0/24"]
  public_subnet_cidrs  = ["12.6.2.0/24", "12.6.3.0/24"]

  # Internet-GateWay
  enable_internet_gateway = true

  # NAT
  enable_nat_gateway = true
  single_nat_gateway = true

  # DHCP
  enable_dhcp                          = true
  vpc_dhcp_options_domain_name         = "ec2.internal"
  vpc_dhcp_options_domain_name_servers = ["AmazonProvidedDNS"]

  # NACLs
  enable_network_acl  = true
  network_acl_ingress = []
  network_acl_egress  = []

  # VPC flow log
  enable_flow_log = true
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

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

  depends_on = [
    module.s3_flow_logs
  ]
}

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
  vpn_gateway_name              = "tmp-vpn"
  vpn_gateway_availability_zone = null
  vpn_gateway_amazon_side_asn   = 64512

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


  private_custom_peering_destination_cidr_block = ["1.2.3.4/32", "4.3.2.1/32"]
  private_custom_gateway_id                     = "tgw-05b56a37c420a2635"

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}

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

#---------------------------------------------------------------
# VPC Endpoint
#---------------------------------------------------------------

variable "vpc_id" {
  default = "vpc-0ea8873ab2bf7900d"
}


module "vpc_endpoint" {
  source      = "../../modules/vpc"
  name        = "endpoint"
  environment = "stage"

  # VPC
  enable_vpc                           = true
  vpc_name                             = "vpc_endpoint"
  vpc_instance_tenancy                 = "dedicated"
  vpc_enable_dns_support               = true
  vpc_enable_dns_hostnames             = true
  vpc_assign_generated_ipv6_cidr_block = false
  # Dedicated tenancy VPCs cannot be enabled for ClassicLink by default
  vpc_enable_classiclink = false
  vpc_cidr_block         = "10.11.0.0/16"

  private_subnet_cidrs = ["10.11.1.0/24"]
  public_subnet_cidrs  = ["10.11.2.0/24", "10.11.3.0/24"]

  # Internet-GateWay
  enable_internet_gateway = true

  # NAT
  enable_nat_gateway = false
  single_nat_gateway = false

  # DHCP
  enable_dhcp                          = true
  vpc_dhcp_name                        = "dhcp-name"
  vpc_dhcp_options_domain_name         = "ec2.internal"
  vpc_dhcp_options_domain_name_servers = ["AmazonProvidedDNS"]

  # VPC endpoints
  enable_vpc_endpoint = true

  vpc_endpoint_stack = [
    {
      vpc_id = var.vpc_id

      name              = "s3-endpoint-for-emr"
      service_name      = "com.amazonaws.${data.aws_region.current.name}.s3"
      vpc_endpoint_type = "Gateway"
      auto_accept       = true

      policy              = null
      route_table_ids     = null
      subnet_ids          = null
      security_group_ids  = null
      private_dns_enabled = null
    },
    {
      vpc_id = var.vpc_id

      name                = "sqs-endpoint-for-emr"
      service_name        = "com.amazonaws.${data.aws_region.current.name}.sqs"
      vpc_endpoint_type   = "Interface"
      security_group_ids  = ["sg-04c894799d3d0d9dd", "sg-0cfb43249902af8f2"]
      auto_accept         = true
      private_dns_enabled = true
    },
    {
      vpc_id = var.vpc_id

      name                = "sns-endpoint-for-emr"
      service_name        = "com.amazonaws.${data.aws_region.current.name}.sns"
      vpc_endpoint_type   = "Interface"
      security_group_ids  = ["sg-04c894799d3d0d9dd", "sg-0cfb43249902af8f2"]
      auto_accept         = true
      private_dns_enabled = true
    },
    // {
    //       vpc_id = var.vpc_id

    //       name              = "dynamodb-endpoint-for-emr"
    //       service_name      = "com.amazonaws.${data.aws_region.current.name}.dynamodb"
    //       vpc_endpoint_type = "Gateway"
    //       auto_accept       = true

    //       policy              = null
    //       route_table_ids     = null
    //       subnet_ids          = null
    //       security_group_ids  = null
    //       private_dns_enabled = null
    //     },
  ]

  # VPC endpoint connection notification
  enable_vpc_endpoint_connection_notification                      = false
  vpc_endpoint_connection_notification_connection_notification_arn = "arn:aws:sns:us-east-1:${data.aws_caller_identity.current.id}:sns_topic"
  vpc_endpoint_connection_notification_connection_events           = ["Accept", "Reject"]


  # VPC endpoint route table association
  enable_vpc_endpoint_route_table_association         = false
  vpc_endpoint_route_table_association_route_table_id = "rtb-07472044c2935ac68"


  # VPC endpoint subnet association
  enable_vpc_endpoint_subnet_association = false


  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}


module "vpc_endpoint_service" {
  source      = "../../modules/vpc"
  name        = "endpoint_service"
  environment = "stage"

  # VPC endpoint service
  enable_vpc_endpoint_service = false
  vpc_endpoint_service_stack = [
    {
      acceptance_required = false

      name                       = "test-end-svc"
      gateway_load_balancer_arns = null
      network_load_balancer_arns = null
      allowed_principals         = null
      private_dns_name           = null
    },
    {
      acceptance_required = true

      name                       = "test-end-svc2"
      gateway_load_balancer_arns = null
      network_load_balancer_arns = null
      allowed_principals         = null
      private_dns_name           = true
    }
  ]

  # VPC endpoint service allowed principal
  enable_vpc_endpoint_service_allowed_principal        = false
  vpc_endpoint_service_allowed_principal_principal_arn = data.aws_caller_identity.current.arn

  # VPC endpoint connection notification
  enable_vpc_endpoint_connection_notification                      = false
  vpc_endpoint_connection_notification_connection_notification_arn = "arn:aws:sns:us-east-1:${data.aws_caller_identity.current.id}:sns_topic"
  vpc_endpoint_connection_notification_connection_events           = ["Accept", "Reject"]

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}
