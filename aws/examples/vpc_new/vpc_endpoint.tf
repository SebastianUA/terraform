#---------------------------------------------------------------
# VPC Endpoint
#---------------------------------------------------------------
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
  vpc_dhcp_options_domain_name         = "ec2.internal"
  vpc_dhcp_options_domain_name_servers = ["AmazonProvidedDNS"]

  # EIP
  enable_eip = false

  # VPC endpoints
  enable_vpc_endpoint = true

  vpc_endpoint_name              = "s3-endpoint-for-emr"
  vpc_endpoint_vpc_id            = module.vpc_endpoint.vpc_id
  vpc_endpoint_service_name      = "com.amazonaws.${data.aws_region.current.name}.s3"
  vpc_endpoint_vpc_endpoint_type = "Gateway"
  vpc_endpoint_auto_accept       = true

  #
  #vpc_endpoint_name                = "sqs-endpoint-for-emr"
  #vpc_endpoint_vpc_id              = module.vpc_endpoint.vpc_id
  #vpc_endpoint_service_name        = "com.amazonaws.${data.aws_region.current.name}.sqs"
  #vpc_endpoint_vpc_endpoint_type   = "Interface"
  #vpc_endpoint_security_group_ids  = ["sg-04c894799d3d0d9dd", "sg-0cfb43249902af8f2"]
  #vpc_endpoint_auto_accept         = true
  #vpc_endpoint_private_dns_enabled = true
  #
  #vpc_endpoint_name = "sns-endpoint-for-emr"
  #vpc_endpoint_vpc_id              = module.vpc_endpoint.vpc_id
  #vpc_endpoint_service_name        = "com.amazonaws.${data.aws_region.current.name}.sns"
  #vpc_endpoint_vpc_endpoint_type   = "Interface"
  #vpc_endpoint_security_group_ids  = ["sg-04c894799d3d0d9dd", "sg-0cfb43249902af8f2"]
  #vpc_endpoint_auto_accept         = true
  #vpc_endpoint_private_dns_enabled = true


  # VPC endpoint subnet association
  enable_vpc_endpoint_subnet_association = true

  # VPC endpoint route table association
  enable_vpc_endpoint_route_table_association = true

  # VPC endpoint connection notification
  enable_vpc_endpoint_connection_notification                      = false
  vpc_endpoint_connection_notification_connection_notification_arn = ""
  vpc_endpoint_connection_notification_connection_events           = ["Accept", "Reject"]

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}

// module "vpc_endpoint" {
//   source      = "../../modules/vpc"
//   name        = "endpoint"
//   environment = "stage"

//   # VPC
//   enable_vpc                           = true
//   vpc_name                             = ""
//   vpc_instance_tenancy                 = "dedicated"
//   vpc_enable_dns_support               = true
//   vpc_enable_dns_hostnames             = true
//   vpc_assign_generated_ipv6_cidr_block = false
//   # Dedicated tenancy VPCs cannot be enabled for ClassicLink by default
//   vpc_enable_classiclink = false
//   vpc_cidr_block         = "10.11.0.0/16"

//   private_subnet_cidrs = ["10.11.1.0/24"]
//   public_subnet_cidrs  = ["10.11.2.0/24", "10.11.3.0/24"]

//   # Internet-GateWay
//   enable_internet_gateway = true

//   # NAT
//   enable_nat_gateway = false
//   single_nat_gateway = false

//   # DHCP
//   enable_dhcp                          = true
//   vpc_dhcp_options_domain_name         = "ec2.internal"
//   vpc_dhcp_options_domain_name_servers = ["AmazonProvidedDNS"]

//   # EIP
//   enable_eip = false

//   # VPC endpoints
//   enable_vpc_endpoint = true
//   vpc_endpoint_stack = [
//     {
//       name              = "s3-endpoint-for-emr"
//       service_name      = "com.amazonaws.${data.aws_region.current.name}.s3"
//       vpc_endpoint_type = "Gateway"
//       auto_accept       = true
//     },
//     {
//       name                = "sqs-endpoint-for-emr"
//       service_name        = "com.amazonaws.${data.aws_region.current.name}.sqs"
//       vpc_endpoint_type   = "Interface"
//       security_group_ids  = ["sg-0ac2ce954f45c8f6a", "sg-0919aabecaea96510"]
//       auto_accept         = true
//       private_dns_enabled = true
//     },
//     {
//       name                = "sns-endpoint-for-emr"
//       service_name        = "com.amazonaws.${data.aws_region.current.name}.sns"
//       vpc_endpoint_type   = "Interface"
//       security_group_ids  = ["sg-0ac2ce954f45c8f6a", "sg-0919aabecaea96510"]
//       auto_accept         = true
//       private_dns_enabled = true
//     }
//   ]

//   tags = tomap({
//   "Environment"="dev",
//   "Createdby"="Vitaliy Natarov",
//   "Orchestration"="Terraform"
// })
// }

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
    }
  ]

  # VPC endpoint service allowed principal
  enable_vpc_endpoint_service_allowed_principal        = false
  vpc_endpoint_service_allowed_principal_principal_arn = ""

  # VPC endpoint connection notification
  enable_vpc_endpoint_connection_notification                      = false
  vpc_endpoint_connection_notification_connection_notification_arn = ""
  vpc_endpoint_connection_notification_connection_events           = ["Accept", "Reject"]

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}
