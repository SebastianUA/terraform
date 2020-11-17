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

module "access_analyzer" {
  source      = "../../modules/access_analyzer"
  name        = "TEST"
  environment = "dev"

  enable_accessanalyzer_analyzer = true
  accessanalyzer_analyzer_name   = ""

  tags = map(
    "ENV", "dev",
    "Createdby", "Vitalii Natarov",
  )
}
