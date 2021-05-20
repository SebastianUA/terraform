#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.15"
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Account from resoure will be shared (owner)
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
  profile                 = "owner"

  alias = "owner"
}


module "ram_owner" {
  source      = "../../modules/ram"
  name        = "tmp"
  environment = "dev"

  providers = {
    aws = aws.owner
  }

  # RAM resource share
  enable_ram_resource_share                    = true
  ram_resource_share_name                      = "test-ram-shared-resource-1"
  ram_resource_share_allow_external_principals = true

  # RAM resource association
  enable_ram_resource_association       = true
  ram_resource_association_resource_arn = "arn:aws:ec2:us-east-1:167127734783:transit-gateway/tgw-095a7bb025f42d2b0"

  # RAM principal association
  enable_ram_principal_association    = true
  ram_principal_association_principal = "XXXXXXXXXXXXXXXXX"

  tags = map("Env", "stage", "Orchestration", "Terraform")
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Account to resoure will be shared (main)
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
  profile                 = "main"
}

module "ram_main_accepter" {
  source      = "../../modules/ram"
  name        = "tmp"
  environment = "dev"

  # RAM resource share accepter
  enable_ram_resource_share_accepter    = true
  ram_resource_share_accepter_share_arn = module.ram_owner.ram_principal_association_id

  depends_on = [
    module.ram_owner
  ]
}
