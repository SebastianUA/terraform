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

module "cognito" {
  source      = "../../modules/cognito"
  name        = "TEST"
  environment = "stage"

  # enable cognito user pool
  enable_cognito_user_pool = true
  cognito_user_pool_name   = ""

  cognito_user_pool_mfa_configuration          = "ON"
  cognito_user_pool_sms_authentication_message = "Your code is {####}"

  cognito_user_pool_sms_configuration = {
    external_id    = "example"
    sns_caller_arn = "arn:aws:iam::123456789012:role/aws-cognito-role"
  }

  cognito_user_pool_software_token_mfa_configuration = {
    enabled = true
  }

  # enable cognito user pool domain
  enable_cognito_user_pool_domain = true
  cognito_user_pool_domain_domain = "linux-notes"

  # enable cognito user pool client
  enable_cognito_user_pool_client = true
  cognito_user_pool_client_name   = ""

  tags = tomap({ "Env" = "Stage", "CreatedBy" = "Vitaliy Natarov" })
}
