# Work with CLOUD9 via terraform

A terraform module for making CLOUD9.


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

module "cloud9" {
  source      = "../../modules/cloud9"
  name        = "TEST"
  environment = "stage"

  enable_cloud9_environment_ec2        = true
  cloud9_environment_ec2_name          = ""
  cloud9_environment_ec2_instance_type = "t2.micro"

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
- `enable_cloud9_environment_ec2` - Enable cloud9 environment ec2 usage (`default = False`)
- `cloud9_environment_ec2_name` - The name of the environment. (`default = ""`)
- `cloud9_environment_ec2_instance_type` - (Required) The type of instance to connect to the environment, e.g. t2.micro. (`default = t2.micro`)
- `cloud9_environment_ec2_automatic_stop_time_minutes` - (Optional) The number of minutes until the running instance is shut down after the environment has last been used. (`default = null`)
- `cloud9_environment_ec2_description` - (Optional) The description of the environment. (`default = null`)
- `cloud9_environment_ec2_owner_arn` - (Optional) The ARN of the environment owner. This can be ARN of any AWS IAM principal. Defaults to the environment's creator. (`default = null`)
- `cloud9_environment_ec2_subnet_id` - (Optional) The ID of the subnet in Amazon VPC that AWS Cloud9 will use to communicate with the Amazon EC2 instance. (`default = null`)

## Module Output Variables
----------------------
- `cloud9_environment_ec2_id` - The ID of the environment.
- `cloud9_environment_ec2_arn` - The ARN of the environment.
- `cloud9_environment_ec2_type` - The type of the environment (e.g. ssh or ec2)


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
