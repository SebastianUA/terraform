#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#

terraform {
  required_version = "~> 0.13"
}

provider "aws" {
  region                  = "us-east-1"
  profile                 = "default"
  shared_credentials_file = pathexpand("/Users/captain/.aws/credentials")
}

module "key_pair_name" {
  source = "../../modules/key_pair"

  enable_key_pair          = true
  key_pair_key_name        = "test"
  key_pair_key_name_prefix = null
  key_pair_public_key      = file("/Users/captain/.ssh/id_rsa.pub")

  tags = map(
    "CreatedBy", "Vitaliy Natarov",
    "Env", "dev"
  )
}

module "key_pair_prefix" {
  source = "../../modules/key_pair"

  enable_key_pair          = true
  key_pair_key_name_prefix = "kp-"
  key_pair_public_key      = file("/Users/captain/.ssh/id_rsa.pub")

  tags = map(
    "CreatedBy", "Vitaliy Natarov",
    "Env", "dev"
  )
}
