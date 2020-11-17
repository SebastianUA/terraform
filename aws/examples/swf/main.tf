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

module "swf" {
  source = "../../modules/swf"

  enable_swf_domain                                      = true
  swf_domain_name                                        = "name"
  swf_domain_description                                 = "Managing by Terrafrom"
  swf_domain_workflow_execution_retention_period_in_days = 0

  tags = map("Env", "dev", "Createdby", "Vitalii Natarov", "Orchestration", "Terraform")
}
