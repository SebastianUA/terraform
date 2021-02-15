#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = ">= 0.13.5"
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

  tags = map("Env", "stage", "Orchestration", "Terraform")

}
