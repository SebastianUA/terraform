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
  s3_bucket_acl    = "private"

  tags = map("Env", "stage", "Orchestration", "Terraform")
}

#---------------------------------------------------------------
# VPC
#---------------------------------------------------------------
module "vpc" {
  source      = "../../modules/vpc"
  name        = "vpc"
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

      log_destination = "arn:aws:logs:us-east-1:${data.aws_caller_identity.current.account_id}:log-group:vpc-flow-log-test"
    },
    {
      name                 = "vpc-flow-log-s3"
      traffic_type         = "ALL"
      iam_role_arn         = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/vpc-flow-log"
      log_destination_type = "s3"
      log_destination      = module.s3_flow_logs.s3_bucket_arn
    }
  ]


  tags = map("Env", "stage", "Orchestration", "Terraform")

  depends_on = [
    module.s3_flow_logs
  ]
}
