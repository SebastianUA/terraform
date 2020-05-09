# Work with AWS elastic beanstalk via terraform

A terraform module for making elastic beanstalk.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = ">= 0.12.12"
}

provider "aws" {
    region                  = "us-west-2"
    shared_credentials_file = pathexpand("~/.aws/credentials")
    profile                 = "default"
}

module "elasticbeanstalk" {
    source                                      = "../../modules/elasticbeanstalk"
    name                                        = "TESTmeNow"
    environment                                 = "stage"

    enable_elastic_beanstalk_application        = true
    elastic_beanstalk_application_name          = ""
    elastic_beanstalk_application_description   = ""
    appversion_lifecycle                        = []

    enable_elastic_beanstalk_environment        = true
    elastic_beanstalk_environment_name          = ""
    elastic_beanstalk_environment_description   = ""
    application_name                            = ""

    tags                                        = map("Env", "stage", "Orchestration", "Terraform")

}
```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - Add additional tags (`default = {}`)
- `enable_elastic_beanstalk_application` - Enable to create elastic_beanstalk_application (`default = False`)
- `elastic_beanstalk_application_name` - The name of the application, must be unique within your account (`default = ""`)
- `elastic_beanstalk_application_description` - (Optional) Short description of the application (`default = ""`)
- `appversion_lifecycle` - Application version lifecycle (appversion_lifecycle) supports the following settings. Only one of either max_count or max_age_in_days can be provided (`default = []`)
- `enable_elastic_beanstalk_environment` - Enable to create elastic_beanstalk_environment (`default = False`)
- `elastic_beanstalk_environment_name` - A unique name for this Environment. This name is used in the application URL (`default = ""`)
- `elastic_beanstalk_environment_description` - (Optional) Short description of the Environment (`default = ""`)
- `application_name` - A unique name for this Environment. This name is used in the application URL. If not set, will be used from elastic_beanstalk_application (`default = ""`)
- `solution_stack_name` - (Optional) A solution stack to base your environment off of. Example stacks can be found in the Amazon API documentation (`default = 64bit Amazon Linux 2018.03 v2.11.7 running Multi-container Docker 18.06.1-ce (Generic)`)
- `cname_prefix` - (Optional) Prefix to use for the fully qualified DNS name of the Environment. (`default = ""`)
- `tier` - (Optional) Elastic Beanstalk Environment tier. Valid values are Worker or WebServer. If tier is left blank WebServer will be used. (`default = WebServer`)
- `setting` - (Optional) Option settings to configure the new Environment. These override specific values that are set as defaults. The format is detailed below in Option Settings. (`default = [{'namespace': 'aws:autoscaling:asg', 'name': 'MaxSize', 'value': '1'}]`)
- `template_name` - (Optional) The name of the Elastic Beanstalk Configuration template to use in deployment (`default = ""`)
- `platform_arn` - (Optional) The ARN of the Elastic Beanstalk Platform to use in deployment (`default = null`)
- `wait_for_ready_timeout` - (Default: 20m) The maximum duration that Terraform should wait for an Elastic Beanstalk Environment to be in a ready state before timing out. (`default = 20m`)
- `poll_interval` - The time between polling the AWS API to check if changes have been applied. Use this to adjust the rate of API calls for any create or update action. Minimum 10s, maximum 180s. Omit this to use the default behavior, which is an exponential backoff (`default = 10s`)
- `version_label` - (Optional) The name of the Elastic Beanstalk Application Version to use in deployment. (`default = ""`)
- `enable_elastic_beanstalk_application_version` - Enable creating beanstalk application version (`default = False`)
- `elastic_beanstalk_application_version_name` - A unique name for the this Application Version. (`default = ""`)
- `elastic_beanstalk_application_version_description` - (Optional) Short description of the Application Version. (`default = ""`)
- `bucket` - (Required) S3 bucket that contains the Application Version source bundle. (`default = ""`)
- `key` - (Required) S3 object that is the Application Version source bundle. (`default = ""`)
- `force_delete` - (Optional) On delete, force an Application Version to be deleted when it may be in use by multiple Elastic Beanstalk Environments. (`default = False`)
- `enable_elastic_beanstalk_configuration_template` - Enable creating beanstalk configuration template (`default = False`)
- `configuration_template_name` - (Required) A unique name for this Template. (`default = ""`)
- `configuration_template_description` - (Optional) Short description of the Template (`default = ""`)
- `environment_id` - (Optional) The ID of the environment used with this configuration template (`default = ""`)

## Module Output Variables
----------------------
- `elastic_beanstalk_application_name` - Name for elastic_beanstalk_application
- `elastic_beanstalk_application_arn` - Name for elastic_beanstalk_application
- `elastic_beanstalk_environment_id` - ID of the Elastic Beanstalk Environment.
- `elastic_beanstalk_environment_name` - Name of the Elastic Beanstalk Environment.
- `elastic_beanstalk_environment_application` - The Elastic Beanstalk Application specified for this environment.
- `elastic_beanstalk_environment_setting` - Settings specifically set for this Environment.
- `elastic_beanstalk_environment_all_settings` - List of all option settings configured in the Environment. These are a combination of default settings and their overrides from setting in the configuration.
- `elastic_beanstalk_environment_cname` - Fully qualified DNS name for the Environment.
- `elastic_beanstalk_environment_autoscaling_groups` - The autoscaling groups used by this environment.
- `elastic_beanstalk_environment_instances` - Instances used by this environment.
- `elastic_beanstalk_environment_launch_configurations` - Launch configurations in use by this environment.
- `elastic_beanstalk_environment_load_balancers` - Elastic load balancers in use by this environment.
- `elastic_beanstalk_environment_queues` - SQS queues in use by this environment.
- `elastic_beanstalk_environment_triggers` - Autoscaling triggers in use by this environment.
- `elastic_beanstalk_application_version_name` - The Application Version name.
- `elastic_beanstalk_configuration_template_name` - Name for created config-template


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
