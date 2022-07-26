# Work with SERVERLESSAPPLICATIONREPOSITORY via terraform

A terraform module for making SERVERLESSAPPLICATIONREPOSITORY.


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

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

}

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default = {}`)
- `enable_serverlessapplicationrepository_cloudformation_stack` - Enable serverlessapplicationrepository cloudformation stack usage (`default = False`)
- `serverlessapplicationrepository_cloudformation_stack_name` - The name of the stack to create. The resource deployed in AWS will be prefixed with serverlessrepo- (`default = ""`)
- `serverlessapplicationrepository_cloudformation_stack_application_id` - (Required) The ARN of the application from the Serverless Application Repository. (`default = null`)
- `serverlessapplicationrepository_cloudformation_stack_capabilities` - (Required) A list of capabilities. Valid values are CAPABILITY_IAM, CAPABILITY_NAMED_IAM, CAPABILITY_RESOURCE_POLICY, or CAPABILITY_AUTO_EXPAND (`default = null`)
- `serverlessapplicationrepository_cloudformation_stack_parameters` - (Optional) A map of Parameter structures that specify input parameters for the stack. (`default = null`)
- `serverlessapplicationrepository_cloudformation_stack_semantic_version` - (Optional) The version of the application to deploy. If not supplied, deploys the latest version. (`default = null`)

## Module Output Variables
----------------------
- `serverlessapplicationrepository_cloudformation_stack_id` - A unique identifier of the stack.
- `serverlessapplicationrepository_cloudformation_stack_outputs` - A map of outputs from the stack.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
