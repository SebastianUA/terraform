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
