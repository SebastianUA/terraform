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

module "appsync" {
  source      = "../../modules/appsync"
  name        = "TEST"
  environment = "stage"

  enable_appsync_graphql_api              = true
  appsync_graphql_api_name                = ""
  appsync_graphql_api_authentication_type = "API_KEY"

  enable_appsync_api_key = true

  enable_appsync_datasource = true
  appsync_datasource_name   = ""
  appsync_datasource_type   = "NONE"

  enable_appsync_function                    = true
  appsync_function_name                      = ""
  appsync_function_request_mapping_template  = <<EOF
{
    "version": "2018-05-29",
    "method": "GET",
    "resourcePath": "/",
    "params":{
        "headers": $utils.http.copyheaders($ctx.request.headers)
    }
}
EOF
  appsync_function_response_mapping_template = <<EOF
#if($ctx.result.statusCode == 200)
    $ctx.result.body
#else
    $utils.appendError($ctx.result.body, $ctx.result.statusCode)
#end
EOF

  enable_appsync_resolver = true
  appsync_resolver_api_id = ""
  appsync_resolver_type   = "Query"
  appsync_resolver_field  = "singlePost"

  appsync_resolver_request_template = <<EOF
{
    "version": "2018-05-29",
    "method": "GET",
    "resourcePath": "/",
    "params":{
        "headers": $utils.http.copyheaders($ctx.request.headers)
    }
}
EOF

  appsync_resolver_response_template = <<EOF
#if($ctx.result.statusCode == 200)
    $ctx.result.body
#else
    $utils.appendError($ctx.result.body, $ctx.result.statusCode)
#end
EOF


}
