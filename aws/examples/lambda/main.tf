#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#

terraform {
  required_version = "~> 0.15"
}

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
  profile                 = "default"
}

module "lambda" {
  source      = "../../modules/lambda"
  name        = "mylambdaonpython"
  environment = "dev"

  # AWS Lambda
  enable_lambda_function  = true
  lambda_function_name    = ""
  lambda_function_handler = "lambda_function.lambda_handler"
  lambda_function_role    = "arn:aws:iam::167127734783:role/test-lambda-role"
  lambda_function_runtime = "python3.7"

  lambda_function_filename         = "./additional_files/lambda_function_payload.zip"
  lambda_function_source_code_hash = filebase64sha256("./additional_files/lambda_function_payload.zip")

  lambda_function_environment = {
    key = "value",
    Env = "dev"
  }

  # AWS Lambda Alias
  enable_lambda_alias           = true
  lambda_alias_name             = ""
  lambda_alias_function_version = "$LATEST"
  lambda_alias_routing_config = {
    "2" = 0.5
  }

  # Add lambda event source mapping
  enable_lambda_event_source_mapping           = false
  lambda_event_source_mapping_event_source_arn = "SQS_ARN_HERE"
  ## for DynamoDB or Kinessis need to add:
  lambda_event_source_mapping_starting_position = null

  # Lambda fun event invoke config
  enable_lambda_function_event_invoke_config = false
  lambda_function_event_invoke_config_destination_config = [{
    destination_on_failure = "SQS_ARN_HERE"
    destination_on_success = "SNS_ARN_HERE"
  }]

  # Lambda provisioned concurrency config
  enable_lambda_provisioned_concurrency_config = true

  # Lambda permission
  enable_lambda_permission    = false
  lambda_permission_action    = "lambda:InvokeFunction"
  lambda_permission_principal = "events.amazonaws.com"

  lambda_permission_source_arn = "arn:aws:events:eu-west-1:111122223333:rule/RunDaily"

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}
