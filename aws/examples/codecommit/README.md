# Work with AWS Codecommit via terraform

A terraform module for making Codecommit.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
    required_version = "~> 0.12.12"
}

provider "aws" {
    region                  = "us-east-1"
    shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "codecommit" {
    source                              = "../../modules/codecommit"
    name                                = "TEST"
    environment                         = "stage"

    enable_codecommit_repository        = true
    codecommit_repository_name          = "myrepo"

    enable_codecommit_trigger           = false
    codecommit_trigger_name             = ""
    codecommit_trigger_destination_arn  = ""
    codecommit_trigger_branches         = []
    codecommit_trigger_events           = ["all"]

    tags                                = map("Env", "stage", "Orchestration", "Terraform")
}
```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default = {}`)
- `enable_codecommit_repository` - Enable codecommit repository usage (`default = False`)
- `codecommit_repository_name` - Set name for codecommit repository. The name for the repository. This needs to be less than 100 characters. (`default = ""`)
- `codecommit_repository_description` - (Optional) The description of the repository. This needs to be less than 1000 characters (`default = null`)
- `codecommit_repository_default_branch` - (Optional) The default branch of the repository. The branch specified here needs to exist. (`default = null`)
- `enable_codecommit_trigger` - Enable codecommit trigger usage (`default = False`)
- `codecommit_trigger_name` - The name of the trigger. (`default = ""`)
- `codecommit_trigger_destination_arn` - (Required) The ARN of the resource that is the target for a trigger. For example, the ARN of a topic in Amazon Simple Notification Service (SNS). (`default = null`)
- `codecommit_trigger_custom_data` - (Optional) Any custom data associated with the trigger that will be included in the information sent to the target of the trigger. (`default = null`)
- `codecommit_trigger_branches` - (Optional) The branches that will be included in the trigger configuration. If no branches are specified, the trigger will apply to all branches. (`default = null`)
- `codecommit_trigger_events` - (Required) The repository events that will cause the trigger to run actions in another service, such as sending a notification through Amazon Simple Notification Service (SNS). If no events are specified, the trigger will run for all repository events. Event types include: all, updateReference, createReference, deleteReference. (`default = null`)

## Module Output Variables
----------------------
- `codecommit_repository_id` - The ID of the repository
- `codecommit_repository_name` - The name of the repository
- `codecommit_repository_arn` - The ARN of the repository
- `codecommit_repository_clone_url_http` - The URL to use for cloning the repository over HTTPS.
- `codecommit_repository_clone_url_ssh` - The URL to use for cloning the repository over SSH.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
