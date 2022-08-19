# Work with APPSYNC2 via terraform

A terraform module for making APPSYNC2.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
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

module "appsync2" {
  source      = "../../modules/appsync2"
  name        = "TEST"
  environment = "stage"

}

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default = {}`)
- `enable_appsync_api_key` - Enable appsync api key usage (`default = False`)
- `appsync_api_key_api_id` - The ID of the associated AppSync API (`default = ""`)
- `appsync_api_key_description` - (Optional) The API key description. Defaults to 'Managed by Terraform'. (`default = Managed by Terraform`)
- `appsync_api_key_expires` - (Optional) RFC3339 string representation of the expiry date. Rounded down to nearest hour. By default, it is 7 days from the date of creation. (`default = null`)
- `enable_appsync_graphql_api` - Enable appsync graphql api usage (`default = False`)
- `appsync_graphql_api_name` - A user-supplied name for the GraphqlApi. (`default = ""`)
- `appsync_graphql_api_authentication_type` - (Required) The authentication type. Valid values: API_KEY, AWS_IAM, AMAZON_COGNITO_USER_POOLS, OPENID_CONNECT (`default = API_KEY`)
- `appsync_graphql_api_schema` - (Optional) The schema definition, in GraphQL schema language format. Terraform cannot perform drift detection of this configuration. (`default = null`)
- `appsync_graphql_api_xray_enabled` - (Optional) Whether tracing with X-ray is enabled. Defaults to false. (`default = False`)
- `appsync_graphql_api_log_config` - (Optional) Nested argument containing logging configuration. (`default = []`)
- `appsync_graphql_api_openid_connect_config` - (Optional) Nested argument containing OpenID Connect configuration. (`default = []`)
- `appsync_graphql_api_user_pool_config` - (Optional) The Amazon Cognito User Pool configuration. (`default = []`)
- `appsync_graphql_api_additional_authentication_provider` - (Optional) One or more additional authentication providers for the GraphqlApi. (`default = []`)
- `enable_appsync_datasource` - Enable appsync datasource usage (`default = False`)
- `appsync_datasource_name` - A user-supplied name for the DataSource. (`default = ""`)
- `appsync_datasource_api_id` - The API ID for the GraphQL API for the DataSource. (`default = ""`)
- `appsync_datasource_type` - (Required) The type of the DataSource. Valid values: AWS_LAMBDA, AMAZON_DYNAMODB, AMAZON_ELASTICSEARCH, HTTP, NONE. (`default = NONE`)
- `appsync_datasource_description` - (Optional) A description of the DataSource. (`default = null`)
- `appsync_datasource_service_role_arn` - (Optional) The IAM service role ARN for the data source. (`default = null`)
- `appsync_datasource_dynamodb_config` - (Optional) DynamoDB settings. (`default = []`)
- `appsync_datasource_elasticsearch_config` - (Optional) Amazon Elasticsearch settings.  (`default = []`)
- `appsync_datasource_http_config` - (Optional) HTTP settings. (`default = []`)
- `appsync_datasource_lambda_config` - (Optional) AWS Lambda settings. (`default = []`)
- `enable_appsync_function` - Enable appsync function usage (`default = False`)
- `appsync_function_name` - The Function name. The function name does not have to be unique. (`default = ""`)
- `appsync_function_api_id` - The ID of the associated AppSync API. (`default = ""`)
- `appsync_function_data_source` - The Function DataSource name. (`default = ""`)
- `appsync_function_request_mapping_template` - (Required) The Function request mapping template. Functions support only the 2018-05-29 version of the request mapping template. (`default = null`)
- `appsync_function_response_mapping_template` - (Required) The Function response mapping template. (`default = null`)
- `appsync_function_description` - (Optional) The Function description. (`default = null`)
- `appsync_function_function_version` - (Optional) The version of the request mapping template. Currently the supported value is 2018-05-29. (`default = null`)
- `enable_appsync_resolver` - Enable appsync resolver usage (`default = False`)
- `appsync_resolver_api_id` - The API ID for the GraphQL API. (`default = ""`)
- `appsync_resolver_type` - The type name from the schema defined in the GraphQL API. (`default = Query`)
- `appsync_resolver_field` - (Required) The field name from the schema defined in the GraphQL API. (`default = singlePost`)
- `appsync_resolver_request_template` - (Required) The request mapping template for UNIT resolver or 'before mapping template' for PIPELINE resolver. (`default = null`)
- `appsync_resolver_response_template` - (Required) The response mapping template for UNIT resolver or 'after mapping template' for PIPELINE resolver. (`default = null`)
- `appsync_resolver_data_source` - (Optional) The DataSource name. (`default = null`)
- `appsync_resolver_pipeline_config` - (Optional) The PipelineConfig.  (`default = []`)
- `appsync_resolver_kind` - (Optional) The resolver type. Valid values are UNIT and PIPELINE. (`default = null`)

## Module Output Variables
----------------------
