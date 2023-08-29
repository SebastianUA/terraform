#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 1.0"
}

provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = [pathexpand("~/.aws/credentials")]
}

module "access_analyzer" {
  source      = "../../modules/access_analyzer"
  name        = "TEST"
  environment = "dev"

  enable_accessanalyzer_analyzer = true
  accessanalyzer_analyzer_name   = ""

  tags = tomap({
    "Environment" = "dev",
    "Createdby"   = "Vitalii Natarov"
  })
}
