#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.14"
}
provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "transit_gateway" {
  source      = "../../modules/transit_gateway"
  name        = "TEST"
  environment = "stage"

  # TGW
  enable_transit_gateway = true
  transit_gateway_name   = ""

  # TGW attachment
  enable_transit_gateway_vpc_attachment                                          = true
  transit_gateway_vpc_attachment_name                                            = ""
  transit_gateway_vpc_attachment_subnet_ids                                      = ["subnet-00db3165c99b03ee0", "subnet-07021252bab163bcf", "subnet-01b817896302a1b98"]
  transit_gateway_vpc_attachment_vpc_id                                          = "vpc-0ea8873ab2bf7900d"
  transit_gateway_default_route_table_association                                = "disable" # disable
  transit_gateway_default_route_table_propagation                                = "disable" # disable
  transit_gateway_dns_support                                                    = "enable"
  transit_gateway_vpn_ecmp_support                                               = "enable"
  transit_gateway_vpc_attachment_transit_gateway_default_route_table_association = false
  transit_gateway_vpc_attachment_transit_gateway_default_route_table_propagation = false
  transit_gateway_vpc_attachment_transit_gateway_id                              = ""

  # TGW route table
  enable_transit_gateway_route_table             = true
  transit_gateway_route_table_name               = ""
  transit_gateway_route_table_transit_gateway_id = ""

  # TGW route 
  enable_transit_gateway_route                         = true
  transit_gateway_route_destination_cidr_blocks        = ["1.2.3.4/32", "10.0.0.0/8"]
  transit_gateway_route_transit_gateway_route_table_id = ""
  transit_gateway_route_transit_gateway_attachment_id  = ""

  # TGW route table propaganation
  enable_transit_gateway_route_table_propagation                         = true
  transit_gateway_route_table_propagation_transit_gateway_attachment_id  = ""
  transit_gateway_route_table_propagation_transit_gateway_route_table_id = ""

  # TGW route table association 
  enable_transit_gateway_route_table_association                         = true
  transit_gateway_route_table_association_transit_gateway_attachment_id  = ""
  transit_gateway_route_table_association_transit_gateway_route_table_id = ""

  # TGW peering attachment
  enable_transit_gateway_peering_attachment = false

  # TGW peering attachment accepter
  enable_transit_gateway_peering_attachment_accepter                        = false
  transit_gateway_peering_attachment_accepter_transit_gateway_attachment_id = ""

  tags = map(
    "Env", "dev",
    "Orchestration", "Terraform"
  )
}
