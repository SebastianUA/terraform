#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 1.0"
}

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "api_gateway" {
  source      = "../../modules/api_gateway"
  name        = "TEST"
  environment = "stage"

  # API gateway rest api
  enable_api_gateway_rest_api = true
  api_gateway_rest_api_name   = ""

  # API gateway resource
  enable_api_gateway_resource    = true
  api_gateway_resource_path_part = "path-part"

  # API gateway method
  enable_api_gateway_method        = true
  api_gateway_method_http_method   = "ANY"
  api_gateway_method_authorization = "NONE"

  # API gateway method
  enable_api_gateway_documentation_part     = true
  api_gateway_documentation_part_properties = "{\"description\":\"Example description\"}"

  api_gateway_documentation_part_location = [
    {
      type   = "METHOD"
      method = "GET"
      path   = "/example"
    }
  ]
}
