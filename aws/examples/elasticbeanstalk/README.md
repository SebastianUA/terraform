# Work with ELASTICBEANSTALK via terraform

A terraform module for making ELASTICBEANSTALK.


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
  shared_credentials_file = pathexpand("~/.aws/credentials")
  profile                 = "default"
}

module "elasticbeanstalk" {
  source      = "../../modules/elasticbeanstalk"
  name        = "TESTmeNow"
  environment = "stage"

  # EB app 
  enable_elastic_beanstalk_application      = true
  elastic_beanstalk_application_name        = "eb-app"
  elastic_beanstalk_application_description = "Test EB app"
  elastic_beanstalk_application_appversion_lifecycle = [
    //{
    //  service_role          = null
    //  max_count             = null
    //  max_age_in_days       = null
    //  delete_source_from_s3 = null
    //}
  ]

  # EB app version
  enable_elastic_beanstalk_application_version      = true
  elastic_beanstalk_application_version_description = "test"

  elastic_beanstalk_application_version_bucket = "s3_bucket_id"
  elastic_beanstalk_application_version_key    = "aws_s3_bucket_object_id"

  # EB Env
  enable_elastic_beanstalk_environment              = true
  elastic_beanstalk_environment_name                = "eb-env"
  elastic_beanstalk_environment_description         = "Test eb ENV"
  elastic_beanstalk_environment_solution_stack_name = "Multicontainer Docker version 2.25.0"
  elastic_beanstalk_environment_tier                = "WebServer"

  elastic_beanstalk_environment_setting = [
    {
      namespace = "aws:autoscaling:asg"
      name      = "MaxSize"
      value     = "1"
    }
  ]

  # EB config template 
  enable_elastic_beanstalk_configuration_template              = true
  elastic_beanstalk_configuration_template_name                = "eb-config-template"
  elastic_beanstalk_configuration_template_description         = "test config template for EB"
  elastic_beanstalk_configuration_template_solution_stack_name = "Multicontainer Docker version 2.25.0"
  elastic_beanstalk_configuration_template_setting = [
    {
      namespace = "aws:autoscaling:asg"
      name      = "MaxSize"
      value     = "1"
    }
  ]

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
- `tags` - Add additional tags (`default = {}`)
- `enable_elastic_beanstalk_application` - Enable to create elastic_beanstalk_application (`default = False`)
- `elastic_beanstalk_application_name` - The name of the application, must be unique within your account (`default = ""`)
- `elastic_beanstalk_application_description` - (Optional) Short description of the application (`default = ""`)
- `elastic_beanstalk_application_appversion_lifecycle` - Application version lifecycle (appversion_lifecycle) supports the following settings. Only one of either max_count or max_age_in_days can be provided (`default = []`)
- `enable_elastic_beanstalk_application_version` - Enable creating beanstalk application version (`default = False`)
- `elastic_beanstalk_application_version_name` - A unique name for the this Application Version. (`default = ""`)
- `elastic_beanstalk_application_version_description` - (Optional) Short description of the Application Version. (`default = ""`)
- `elastic_beanstalk_application_version_application` - Name of the Beanstalk Application the version is associated with. (`default = ""`)
- `elastic_beanstalk_application_version_bucket` - (Required) S3 bucket that contains the Application Version source bundle. (`default = ""`)
- `elastic_beanstalk_application_version_key` - (Required) S3 object that is the Application Version source bundle. (`default = ""`)
- `elastic_beanstalk_application_version_force_delete` - (Optional) On delete, force an Application Version to be deleted when it may be in use by multiple Elastic Beanstalk Environments. (`default = False`)
- `enable_elastic_beanstalk_environment` - Enable to create elastic_beanstalk_environment (`default = False`)
- `elastic_beanstalk_environment_name` - A unique name for this Environment. This name is used in the application URL (`default = ""`)
- `elastic_beanstalk_environment_description` - (Optional) Short description of the Environment (`default = ""`)
- `elastic_beanstalk_environment_application` - A unique name for this Environment. This name is used in the application URL. If not set, will be used from elastic_beanstalk_application (`default = ""`)
- `elastic_beanstalk_environment_solution_stack_name` - (Optional) A solution stack to base your environment off of. Example stacks can be found in the Amazon API documentation (`default = 64bit Amazon Linux 2018.03 v2.11.7 running Multi-container Docker 18.06.1-ce (Generic)`)
- `elastic_beanstalk_environment_cname_prefix` - (Optional) Prefix to use for the fully qualified DNS name of the Environment. (`default = null`)
- `elastic_beanstalk_environment_tier` - (Optional) Elastic Beanstalk Environment tier. Valid values are Worker or WebServer. If tier is left blank WebServer will be used. (`default = WebServer`)
- `elastic_beanstalk_environment_setting` - (Optional) Option settings to configure the new Environment. These override specific values that are set as defaults. The format is detailed below in Option Settings. (`default = [{'namespace': 'aws:autoscaling:asg', 'name': 'MaxSize', 'value': '1'}]`)
- `elastic_beanstalk_environment_template_name` - (Optional) The name of the Elastic Beanstalk Configuration template to use in deployment (`default = null`)
- `elastic_beanstalk_environment_platform_arn` - (Optional) The ARN of the Elastic Beanstalk Platform to use in deployment (`default = null`)
- `elastic_beanstalk_environment_wait_for_ready_timeout` - (Default: 20m) The maximum duration that Terraform should wait for an Elastic Beanstalk Environment to be in a ready state before timing out. (`default = null`)
- `elastic_beanstalk_environment_poll_interval` - The time between polling the AWS API to check if changes have been applied. Use this to adjust the rate of API calls for any create or update action. Minimum 10s, maximum 180s. Omit this to use the default behavior, which is an exponential backoff (`default = null`)
- `elastic_beanstalk_environment_version_label` - (Optional) The name of the Elastic Beanstalk Application Version to use in deployment. (`default = null`)
- `enable_elastic_beanstalk_configuration_template` - Enable creating beanstalk configuration template (`default = False`)
- `elastic_beanstalk_configuration_template_name` - (Required) A unique name for this Template. (`default = ""`)
- `elastic_beanstalk_configuration_template_description` - (Optional) Short description of the Template (`default = ""`)
- `elastic_beanstalk_configuration_template_environment_id` - (Optional) The ID of the environment used with this configuration template (`default = ""`)
- `elastic_beanstalk_configuration_template_application` - name of the application to associate with this configuration template (`default = ""`)
- `elastic_beanstalk_configuration_template_solution_stack_name` - (Optional) A solution stack to base your Template off of. Example stacks can be found in the Amazon API documentation (`default = null`)
- `elastic_beanstalk_configuration_template_setting` - (Optional) Option settings to configure the new Environment. These override specific values that are set as defaults. (`default = []`)

## Module Output Variables
----------------------
- `elastic_beanstalk_application_id` - ID for elastic_beanstalk_application
- `elastic_beanstalk_application_name` - Name for elastic_beanstalk_application
- `elastic_beanstalk_application_arn` - Name for elastic_beanstalk_application
- `elastic_beanstalk_application_version_name` - The Application Version name.
- `elastic_beanstalk_application_version_arn` - The ARN assigned by AWS for this Elastic Beanstalk Application.
- `elastic_beanstalk_application_version_id` - The ID assigned by AWS for this Elastic Beanstalk Application.
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
- `elastic_beanstalk_environment_description` - Description of the Elastic Beanstalk Environment.
- `elastic_beanstalk_environment_tier` - The environment tier specified.
- `elastic_beanstalk_environment_endpoint_url` - The URL to the Load Balancer for this Environment
- `elastic_beanstalk_configuration_template_name` - Name for created config-template


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
