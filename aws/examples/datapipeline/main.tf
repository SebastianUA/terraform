#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.13.5"
}

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "datapipeline" {
  source      = "../../modules/datapipeline"
  name        = "TEST"
  environment = "dev"

  enable_datapipeline_pipeline      = true
  datapipeline_pipeline_name        = ""
  datapipeline_pipeline_description = null

  tags = map("Env", "stage", "Orchestration", "Terraform", "Createdby", "Vitalii Natarov")
}
