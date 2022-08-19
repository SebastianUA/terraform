#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#

terraform {
  required_version = "~> 1.0"
}

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("/Users/captain/.aws/credentials")
  profile                 = "default"

}

module "detective" {
  source      = "../../modules/detective"
  name        = ""
  environment = "staging"

  tags = tomap({
    "Environment" = "dev",
    "Createdby"   = "Vitaliy Natarov"
  })

}
