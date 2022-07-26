# Work with SFN via terraform

A terraform module for making SFN.


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

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default = {}`)
- `enable_sfn_activity` - Enable sfn activity (`default = False`)
- `sfn_activity_name` - The name of the activity to create. (`default = ""`)
- `enable_sfn_state_machine` - Enable sfn state machine (`default = False`)
- `sfn_state_machine_name` - The name of the state machine. (`default = ""`)
- `sfn_state_machine_definition` - (Required) The Amazon States Language definition of the state machine. (`default = null`)
- `sfn_state_machine_role_arn` - (Required) The Amazon Resource Name (ARN) of the IAM role to use for this state machine. (`default = null`)

## Module Output Variables
----------------------
- `sfn_activity_id` - The Amazon Resource Name (ARN) that identifies the created activity.
- `sfn_activity_name` - The name of the activity.
- `sfn_activity_creation_date` - The date the activity was created.
- `sfn_state_machine_id` - The ARN of the state machine.
- `sfn_state_machine_creation_date` - The date the state machine was created.
- `sfn_state_machine_status` - The current status of the state machine. Either 'ACTIVE' or 'DELETING'.
- `sfn_state_machine_arn` - The ARN of the state machine.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
