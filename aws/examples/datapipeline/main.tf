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

module "datapipeline" {
  source      = "../../modules/datapipeline"
  name        = "TEST"
  environment = "dev"

  enable_datapipeline_pipeline      = true
  datapipeline_pipeline_name        = ""
  datapipeline_pipeline_description = null

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}
