#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.13"
}

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "servicecatalog" {
  source = "../../modules/servicecatalog"

  enable_servicecatalog_portfolio        = true
  servicecatalog_portfolio_name          = "servicecatalog"
  servicecatalog_portfolio_description   = ""
  servicecatalog_portfolio_provider_name = "captain"
}
