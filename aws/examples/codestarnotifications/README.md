# Work with CODESTARNOTIFICATIONS via terraform

A terraform module for making CODESTARNOTIFICATIONS.


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

module "codestarnotifications" {
  source      = "../../modules/codestarnotifications"
  name        = "TEST"
  environment = "stage"

  enable_codestarnotifications_notification_rule         = true
  codestarnotifications_notification_rule_name           = ""
  codestarnotifications_notification_rule_resource       = "arn:aws:codecommit:us-east-2:111111111111:MyDemoRepo"
  codestarnotifications_notification_rule_detail_type    = "FULL"
  codestarnotifications_notification_rule_event_type_ids = ["codecommit-repository-comments-on-commits"]
  codestarnotifications_notification_rule_status         = "ENABLED"

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
- `enable_codestarnotifications_notification_rule` - Enable codestarnotifications notification rule usage (`default = False`)
- `codestarnotifications_notification_rule_name` - The name of notification rule. (`default = ""`)
- `codestarnotifications_notification_rule_resource` - (Required) The ARN of the resource to associate with the notification rule. For exapmle: aws_codecommit_repository.codecommit_repository.arn (`default = ""`)
- `codestarnotifications_notification_rule_detail_type` - (Required) The level of detail to include in the notifications for this resource. Possible values are BASIC and FULL (`default = FULL`)
- `codestarnotifications_notification_rule_event_type_ids` - (Required) A list of event types associated with this notification rule. (`default = ['codecommit-repository-comments-on-commits']`)
- `codestarnotifications_notification_rule_status` - (Optional) The status of the notification rule. Possible values are ENABLED and DISABLED, default is ENABLED. (`default = ENABLED`)
- `codestarnotifications_notification_rule_target` - (Optional) Configuration blocks containing notification target information. Can be specified multiple times. At least one target must be specified on creation. (`default = []`)

## Module Output Variables
----------------------
- `codestarnotifications_notification_rule_id` - The codestar notification rule ARN.
- `codestarnotifications_notification_rule_arn` - The codestar notification rule ARN.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
