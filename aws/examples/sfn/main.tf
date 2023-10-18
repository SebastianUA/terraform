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

module "sfn" {
  source      = "../../modules/sfn"
  name        = "TEST"
  environment = "stage"

  enable_sfn_activity = true
  sfn_activity_name   = ""


  enable_sfn_state_machine     = true
  sfn_state_machine_name       = ""
  sfn_state_machine_role_arn   = "role_arn_here"
  sfn_state_machine_definition = <<EOF
{
  "Comment": "A Hello World example of the Amazon States Language using an AWS Lambda Function",
  "StartAt": "HelloWorld",
  "States": {
    "HelloWorld": {
      "Type": "Task",
      "Resource": "lambda_arn_here",
      "End": true
    }
  }
}
EOF

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}
