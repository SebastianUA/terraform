#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.14"
}

provider "aws" {
  region                  = "us-west-2"
  profile                 = "default"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

data "aws_partition" "current" {}
data "aws_region" "current" {}

module "serverlessapplicationrepository" {
  source = "../../modules/serverlessapplicationrepository"


  enable_serverlessapplicationrepository_cloudformation_stack         = true
  serverlessapplicationrepository_cloudformation_stack_name           = ""
  serverlessapplicationrepository_cloudformation_stack_application_id = "arn:aws:serverlessrepo:us-east-1:297356227824:applications/SecretsManagerRDSPostgreSQLRotationSingleUser"
  serverlessapplicationrepository_cloudformation_stack_capabilities = [
    "CAPABILITY_IAM",
    "CAPABILITY_RESOURCE_POLICY",
  ]

  serverlessapplicationrepository_cloudformation_stack_parameters = {
    functionName = "func-postgres-rotator"
    endpoint     = "secretsmanager.${data.aws_region.current.name}.${data.aws_partition.current.dns_suffix}"
  }

  tags = map("Env", "stage", "Orchestration", "Terraform")

}
