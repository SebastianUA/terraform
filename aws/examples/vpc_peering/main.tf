#---------------------------------------------------------------
# 1rst VPC for peering
#---------------------------------------------------------------
module "vpc_1" {
  source      = "../../modules/vpc_peering"
  name        = "test"
  environment = "stage"


  # VPC peering
  enable_vpc_peering_connection_accepter      = true
  vpc_peering_connection_accepter_auto_accept = true
  vpc_peering_connection_vpc_id               = "vpc_id_1"


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
  source      = "../../modules/vpc_peering"
  name        = "test2"
  environment = "stage"

  # VPC peering
  enable_vpc_peering_connection      = true
  vpc_peering_connection_vpc_id      = "vpc_id_2"
  vpc_peering_connection_peer_vpc_id = "vpc_id_1" #module.vpc_1.vpc_id


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

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

  depends_on = [
    module.vpc_1
  ]
}


############
############
############

#---------------------------------------------------------------
# VPC for Vault
#---------------------------------------------------------------
module "linux_notes_vpc" {
  source = "git@github.com:SebastianUA/terraform.git//aws/modules/vpc?ref=dev"

  providers = {
    aws = aws.linux_notes_vault
  }

  name        = "linuxnotes-vault"
  environment = "prod"

  # VPC
  enable_vpc                           = true
  vpc_name                             = "linuxnotes-prod-vpc"
  vpc_instance_tenancy                 = "default"
  vpc_enable_dns_support               = true
  vpc_enable_dns_hostnames             = true
  vpc_assign_generated_ipv6_cidr_block = false
  vpc_cidr_block                       = "172.32.0.0/16"

  public_subnet_cidrs = ["172.32.1.0/24", "172.32.2.0/24"]
  private_subnet_cidrs = ["172.32.10.0/24", "172.32.11.0/24", "172.32.12.0/24", "172.32.13.0/24", "172.32.14.0/24", "172.32.15.0/24",
    "172.32.240.0/20", "172.32.224.0/20", "172.32.208.0/20"
  ]

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

  tags = tomap({
    "Environment"   = "prod",
    "Createdby"     = "Vitalii Natarov",
    "Orchestration" = "Terraform"
  })

  depends_on = []
}

#---------------------------------------------------------------
# VPC for peering (from Vault VPC to linuxnotes prod) - peering
#---------------------------------------------------------------
module "vpc_linux_notes_prod_peering_to_vault" {
  source = "git@github.com:SebastianUA/terraform.git//aws/modules/vpc_peering?ref=master"

  providers = {
    aws = aws.linux_notes_prod
  }

  name        = "linuxnotes-vault"
  environment = "prod"

  # VPC peering
  enable_vpc_peering_connection        = true
  vpc_peering_connection_name          = "us-east-1-from-linuxnotes-prod-to-vault"
  vpc_peering_connection_vpc_id        = "vpc-04670c278728b2672"
  vpc_peering_connection_peer_vpc_id   = module.linux_notes_vpc.vpc_id
  vpc_peering_connection_peer_owner_id = data.aws_caller_identity.linux_notes_vault.account_id
  vpc_peering_connection_peer_region   = data.aws_region.linux_notes_prod.name

  vpc_peering_connection_accepter = {}

  vpc_peering_connection_requester = {}

  // Enable if using the same AWS account
  vpc_peering_connection_auto_accept = false

  tags = tomap({
    "Environment"   = "prod",
    "Createdby"     = "Vitalii Natarov",
    "Orchestration" = "Terraform"
  })

  depends_on = [
    module.linux_notes_vpc,
    data.aws_caller_identity.linux_notes_vault,
    data.aws_caller_identity.linux_notes_prod,
    data.aws_region.linux_notes_prod
  ]
}

#---------------------------------------------------------------
# VPC for peering (from Vault VPC to linuxnotes prod) - accepter
#---------------------------------------------------------------
module "vpc_peering_to_linux_notes_prod" {
  source = "git@github.com:SebastianUA/terraform.git//aws/modules/vpc_peering?ref=master"

  providers = {
    aws = aws.linux_notes_vault
  }

  name        = "linuxnotes-vault"
  environment = "prod"

  # VPC peering accepter
  enable_vpc_peering_connection_accepter                    = true
  vpc_peering_connection_accepter_auto_accept               = true
  vpc_peering_connection_accepter_vpc_peering_connection_id = module.vpc_linux_notes_prod_peering_to_vault.vpc_peering_connection_id

  tags = tomap({
    "Environment"   = "prod",
    "Createdby"     = "Vitalii Natarov",
    "Orchestration" = "Terraform"
  })

  depends_on = [
    module.vpc_linux_notes_prod_peering_to_vault
  ]
}
