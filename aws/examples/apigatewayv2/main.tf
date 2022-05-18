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

#---------------------------------------------------------------
# lambda for Firehose
#---------------------------------------------------------------
module "api_gateway_staging_firehose" {
  source = "git@github.com:sebastianua/terraform.git//aws/modules/apigatewayv2?ref=dev"

  providers = {
    aws = aws.default
  }

  name        = "test-api-gateway-staging-firehose"
  environment = "staging"

  // API gateway v2 api
  enable_apigatewayv2_api        = true
  apigatewayv2_api_name          = "test-firehose-staging-apigatewayv2"
  apigatewayv2_api_protocol_type = "HTTP"

  // API gateway v2 api stage
  enable_apigatewayv2_stage      = true
  apigatewayv2_stage_name        = "default"
  apigatewayv2_stage_auto_deploy = true

  // apigatewayv2_api_cors_configuration = {
  //   allow_credentials = ""
  //   allow_headers     = ""
  //   allow_methods     = ""
  //   allow_origins     = ""
  //   expose_headers    = ""
  //   max_age           = 3600
  // }

  depends_on = []
}

module "api_gateway_stage_staging_firehose" {
  source = "git@github.com:sebastianua/terraform.git//aws/modules/apigatewayv2?ref=dev"

  providers = {
    aws = aws.default
  }

  name        = "test-api-gateway-staging-firehose"
  environment = "staging"

  // API gateway v2 api stage
  enable_apigatewayv2_stage      = true
  apigatewayv2_stage_name        = "firehose"
  apigatewayv2_stage_auto_deploy = true
  apigatewayv2_stage_api_id      = module.api_gateway_staging_firehose.apigatewayv2_api_id

  depends_on = [
    module.api_gateway_staging_firehose
  ]
}

module "api_gateway_route_staging_firehose" {
  source = "git@github.com:sebastianua/terraform.git//aws/modules/apigatewayv2?ref=dev"

  providers = {
    aws = aws.default
  }

  name        = "test-api-gateway-staging-firehose"
  environment = "staging"

  // API gateway route
  enable_apigatewayv2_route      = true
  apigatewayv2_route_route_key   = "ANY /firehose"
  apigatewayv2_stage_auto_deploy = false
  apigatewayv2_route_api_id      = module.api_gateway_staging_firehose.apigatewayv2_api_id

  apigatewayv2_route_target = "integrations/${module.api_gateway_integration_staging_firehose.apigatewayv2_integration_id}"

  depends_on = [
    module.api_gateway_staging_firehose,
    module.api_gateway_integration_staging_firehose
  ]
}

module "api_gateway_domain_name_staging_firehose" {
  source = "git@github.com:sebastianua/terraform.git//aws/modules/apigatewayv2?ref=dev"

  providers = {
    aws = aws.default
  }

  name        = "test-api-gateway-staging-firehose"
  environment = "staging"

  // API gateway v2 api domain name
  enable_apigatewayv2_domain_name      = true
  apigatewayv2_domain_name_domain_name = "firehose.internal.test.io"
  apigatewayv2_domain_name_domain_name_configuration = {
    certificate_arn = "arn:aws:acm:us-east-1:${data.aws_caller_identity.default.account_id}:certificate/802132ce-c944-4e44-8365-8fd8d7616aab"
    endpoint_type   = "REGIONAL"
    security_policy = "TLS_1_2"
  }

  depends_on = []
}

module "api_gateway_integration_staging_firehose" {
  source = "git@github.com:sebastianua/terraform.git//aws/modules/apigatewayv2?ref=dev"

  providers = {
    aws = aws.default
  }

  name        = "test-api-gateway-staging-firehose"
  environment = "staging"

  // API gateway integration
  enable_apigatewayv2_integration           = true
  apigatewayv2_integration_integration_type = "AWS_PROXY" // "PROXY" // "AWS" // "HTTP_PROXY" // "AWS_PROXY"

  apigatewayv2_integration_connection_type    = "INTERNET"
  apigatewayv2_integration_description        = "Lambda firehose"
  apigatewayv2_integration_integration_method = "ANY" # "POST"
  apigatewayv2_integration_integration_uri    = data.terraform_remote_state.testio_lambda_staging_firehose.outputs.lambda_staging_firehose_lambda_function_arn
  apigatewayv2_integration_api_id             = module.api_gateway_staging_firehose.apigatewayv2_api_id

  depends_on = [
    module.api_gateway_staging_firehose
  ]
}

module "api_gateway_authorizer_staging_firehose" {
  source = "git@github.com:sebastianua/terraform.git//aws/modules/apigatewayv2?ref=dev"

  providers = {
    aws = aws.default
  }

  name        = "test-api-gateway-staging-firehose"
  environment = "staging"

  // API gateway authorizer
  enable_apigatewayv2_authorizer = true
  apigatewayv2_authorizer_name   = ""
  apigatewayv2_authorizer_api_id = module.api_gateway_staging_firehose.apigatewayv2_api_id

  apigatewayv2_authorizer_authorizer_type                   = "REQUEST"
  apigatewayv2_authorizer_authorizer_uri                    = data.terraform_remote_state.testio_lambda_staging_firehose.outputs.lambda_staging_firehose_lambda_invoke_arn
  apigatewayv2_authorizer_identity_sources                  = []
  apigatewayv2_authorizer_authorizer_result_ttl_in_seconds  = 0
  apigatewayv2_authorizer_authorizer_payload_format_version = "2.0"

  depends_on = [
    data.terraform_remote_state.testio_lambda_staging_firehose,
    module.api_gateway_staging_firehose
  ]
}

// not working fine for now
module "api_gateway_deployment_staging_firehose" {
  source = "git@github.com:sebastianua/terraform.git//aws/modules/apigatewayv2?ref=dev"

  providers = {
    aws = aws.default
  }

  name        = "test-api-gateway-staging-firehose"
  environment = "staging"

  // API gateway deployment
  enable_apigatewayv2_deployment      = true
  apigatewayv2_deployment_description = "Firehose deployment"
  apigatewayv2_deployment_triggers    = {}
  apigatewayv2_deployment_api_id      = module.api_gateway_staging_firehose.apigatewayv2_api_id

  depends_on = [
    module.api_gateway_staging_firehose
  ]
}

#---------------------------------------------------------------
# lambda trigger for Firehose
#---------------------------------------------------------------
module "lambda_staging_firehose_trigger" {
  source = "git@github.com:sebastianua/terraform.git//aws/modules/lambda?ref=dev"

  providers = {
    aws = aws.default
  }

  name        = "test-lambda-firehose"
  environment = "staging"

  enable_lambda_permission        = true
  lambda_permission_function_name = "test-lambda-staging-firehose"
  lambda_permission_source_arn    = "arn:aws:execute-api:${data.aws_region.default.name}:${data.aws_caller_identity.default.account_id}:${module.api_gateway_staging_firehose.apigatewayv2_api_id}/default/*"

  lambda_permission_action    = "lambda:InvokeFunction"
  lambda_permission_principal = "apigateway.amazonaws.com"

  tags = tomap({
    "Environment"   = "staging",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

  depends_on = [
    module.api_gateway_staging_firehose
  ]
}

#---------------------------------------------------------------
# Route53 for Firehose
#---------------------------------------------------------------
module "route53_lambda_staging_firehose" {
  source = "git@github.com:sebastianua/terraform.git//aws/modules/route53?ref=dev"

  # Route53 alias
  enable_route53_record         = true
  route53_record_parent_zone_id = "Z16BИТIERZ9NH6" # internal.test.io
  route53_record_type           = "A"
  route53_record_name           = module.api_gateway_domain_name_staging_firehose.apigatewayv2_domain_name_domain_name
  route53_record_records        = null
  route53_record_alias = [
    {
      name                   = module.api_gateway_domain_name_staging_firehose.apigatewayv2_domain_name_domain_name_configuration[0][0]["target_domain_name"]
      zone_id                = module.api_gateway_domain_name_staging_firehose.apigatewayv2_domain_name_domain_name_configuration[0][0]["hosted_zone_id"]
      evaluate_target_health = false
    }
  ]

  tags = tomap({
    "Environment"   = "staging",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

  depends_on = [
    module.api_gateway_domain_name_staging_firehose
  ]
}
