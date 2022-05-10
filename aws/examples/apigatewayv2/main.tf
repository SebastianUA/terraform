#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 1.0"
}

provider "aws" {
  region                  = "us-west-2"
  profile                 = "default"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "apigatewayv2" {
  source = "../../modules/apigatewayv2"


  // API gateway v2 api
  enable_apigatewayv2_api        = true
  apigatewayv2_api_name          = ""
  apigatewayv2_api_protocol_type = "HTTP"

  // API gateway v2 api domain name
  enable_apigatewayv2_domain_name      = true
  apigatewayv2_domain_name_domain_name = "domain.org"
  apigatewayv2_domain_name_domain_name_configuration = {
    certificate_arn = "aws_acm_certificate_arn"
    endpoint_type   = "REGIONAL"
    security_policy = "TLS_1_2"
  }

  // API gateway v2 api stage
  enable_apigatewayv2_stage = true
  apigatewayv2_stage_name   = ""

  // API gateway v2 api mapping
  enable_apigatewayv2_api_mapping = true

  tags = tomap({
    "Environment" = "dev",
    "Createdby"   = "Vitaliy Natarov"
  })

}
