# Work with AWS elastic beanstalk via terraform

A terraform module for making elastic beanstalk.

## Usage
--------

Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = ">= 0.11.11"
}

provider "aws" {
    region                  = "us-west-2"
    shared_credentials_file = "${pathexpand("~/.aws/credentials")}"
    profile                 = "default"
}

module "s3" {
    source                                  = "../../modules/s3"
    name                                    = "TEST-bucket"
    environment                             = "PROD"
    region                                  = "us-west-2"

    enable_s3_bucket                        = true
    s3_acl                                  = "private"
    cors_rule                               = []

    enable_versioning                       = false
    enable_lifecycle_rule                   = false

    # Add files to bucket
    enable_s3_bucket_object                 = true
    # if you wanna to use created bucket to uploading the file, please set up - bucket_name variable to it. The enable_s3_bucket variable should be turn off
    # bucket_name                            = "bucket_name_here"
    #s3_bucket_object_key                    = "artifacts/eb.zip"
    s3_bucket_object_source                 = ["additional_files/eb.zip", "additional_files/eb_rollback.zip"]
    type_of_file                            = "zip"
}

module "elasticbeanstalk" {
    source                                  = "../../modules/elasticbeanstalk"
    name                                    = "TESTmeNow"
    region                                  = "us-west-2"
    environment                             = "PROD"

    #appversion_lifecycle_service_role       = "${module.aim.role_arn}"
    enable_elastic_beanstalk_application    = "true"

    enable_elastic_beanstalk_environment    = true
    cname_prefix                            = ""
    tier                                    = "WebServer"
    version_label                           = "${module.elasticbeanstalk.elastic_beanstalk_application_version_name}"

    setting                                 = [
    {
	    namespace = "aws:ec2:vpc"
	    name = "VPCId"
	    value = "vpc-0d0d22629db6d471d"
    },
    {
        namespace = "aws:ec2:vpc"
        name = "AssociatePublicIpAddress"
        value = "true"
    },
    {
        namespace = "aws:ec2:vpc"
        name = "ELBSubnets"
        value = "subnet-0e2b323b731655057"
    },
    {
        namespace = "aws:ec2:vpc"
        name = "Subnets"
        value = "subnet-0ffa47878036f1641"
    },
    {
        namespace = "aws:autoscaling:launchconfiguration"
        name = "InstanceType"
        value = "t2.micro"
    },
    {
        namespace = "aws:autoscaling:launchconfiguration"
        name = "ImageId"
        value = "ami-044ac18f3a75c4357"
    },
    {
        namespace = "aws:autoscaling:launchconfiguration"
        name = "SecurityGroups"
        value = "sg-07b62c0d0ea37056d"
    },
    {
        namespace = "aws:autoscaling:launchconfiguration"
        name = "IamInstanceProfile"
        value = "aws-elasticbeanstalk-ec2-role"
    },
    {
        namespace = "aws:autoscaling:launchconfiguration"
        name = "EC2KeyName"
        value = "test-beanstalk"
    },
    {
        namespace = "aws:autoscaling:launchconfiguration"
        name = "RootVolumeType"
        value = "gp2"
    },
    {
        namespace = "aws:autoscaling:launchconfiguration"
        name = "RootVolumeSize"
        value = "8"
    },
    {
        namespace = "aws:autoscaling:launchconfiguration"
        name = "RootVolumeIOPS"
        value = "100"
    },
    {
        namespace = "aws:autoscaling:launchconfiguration"
        name = "SSHSourceRestriction"
        value = "tcp, 22, 22, 0.0.0.0/0"
    },
    {
        namespace = "aws:elasticbeanstalk:command"
        name = "Timeout"
        value = "1200"
    },
    {
        namespace = "aws:elasticbeanstalk:command"
        name = "DeploymentPolicy"
        value = "AllAtOnce"
    },
    {
        namespace = "aws:elasticbeanstalk:command"
        name = "BatchSizeType"
        value = "Percentage"
    },
    {
        namespace = "aws:elasticbeanstalk:command"
        name = "BatchSize"
        value = "100"
    },
    {
        namespace = "aws:elasticbeanstalk:command"
        name = "IgnoreHealthCheck"
        value = "false"
    },
    {
        namespace = "aws:elasticbeanstalk:environment"
        name = "EnvironmentType"
        value = "SingleInstance"
    },
    {
        namespace = "aws:elasticbeanstalk:environment"
        name = "LoadBalancerType"
        value = "classic"
    },
    {
        namespace = "aws:elasticbeanstalk:environment"
        name = "ServiceRole"
        value = "aws-elasticbeanstalk-service-role"
    },
    {
        namespace = "aws:autoscaling:updatepolicy:rollingupdate"
        name = "RollingUpdateType"
        value = "time"
    },
    {
        namespace = "aws:autoscaling:updatepolicy:rollingupdate"
        name = "RollingUpdateEnabled"
        value = "false"
    },
    {
        namespace = "aws:autoscaling:updatepolicy:rollingupdate"
        name = "MinInstancesInService"
        value = "0"
    },
    {
        namespace = "aws:autoscaling:updatepolicy:rollingupdate"
        name = "MaxBatchSize"
        value = "1"
    },
    {
        namespace = "aws:autoscaling:updatepolicy:rollingupdate"
        name = "Timeout"
        value = "PT30M"
    },
    {
        namespace = "aws:elasticbeanstalk:healthreporting:system"
        name = "SystemType"
        value = "enhanced"
    },
    {
        namespace = "aws:elasticbeanstalk:healthreporting:system"
        name = "HealthCheckSuccessThreshold"
        value = "Ok"
    },
    {
        namespace = "aws:elasticbeanstalk:cloudwatch:logs"
        name = "StreamLogs"
        value = "false"
    },
    {
        namespace = "aws:elasticbeanstalk:cloudwatch:logs"
        name = "DeleteOnTerminate"
        value = "false"
    },
    {
        namespace = "aws:elasticbeanstalk:cloudwatch:logs"
        name = "RetentionInDays"
        value = "7"
    },
    {
        namespace = "aws:elasticbeanstalk:cloudwatch:logs:health"
        name = "HealthStreamingEnabled"
        value = "false"
    },
    {
        namespace = "aws:elasticbeanstalk:cloudwatch:logs:health"
        name = "DeleteOnTerminate"
        value = "false"
    },
    {
        namespace = "aws:elasticbeanstalk:cloudwatch:logs:health"
        name = "RetentionInDays"
        value = "7"
    }
    ]

    enable_elastic_beanstalk_application_version    = true
    beanstalk_application_name                      = ""
    deploy_or_rollback                              = "rollback" # deploy
    bucket                                          = "${module.s3.s3_bucket_default_id}"
    #keys                                            = ["${module.s3.s3_bucket_object_ids}"]
    key                                             = "${module.elasticbeanstalk.elastic_beanstalk_application_version_deploy_or_rollback == "deploy" ? "${element(module.s3.s3_bucket_object_ids, 0)}" : "${element(module.s3.s3_bucket_object_ids, 1)}"}"
    #key                                             = "${module.s3.s3_bucket_object_id}"
    force_delete                                    = false

    #
    enable_elastic_beanstalk_configuration_template = true
}

#module "route53" {
#    source                              = "../../modules/route53"
#    name                                = "TEST"
#    region                              = "us-west-2"
#    environment                         = "PROD"
#
#    create_primary_public_route53_zone          = "true"
#    domain_name_for_primary_public_route53_zone = "example.local"
#
#    route53_record_names     = ["Test-domain.local", "domain2.local"]
#    #route53_record_type     = "A"
#    #route53_record_ttl      = "60"
#    #route53_record_records  = ["192.168.0.114"]
#
#    #parent_zone_id          = "Z254KLT7VYA1UX"
#
#    records                 = ["${module.elasticbeanstalk.elastic_beanstalk_environment_cname}"]
#    target_dns_name         = "${module.elb.elb_dns_name}"
#    target_zone_id          = "${module.elb.elb_zone_id}"
#
#    evaluate_target_health  = "true"
#
#    #Health_checks
#    #create_http_route53_health_check    = "true"
#    #fqdn_for_http_route53_health_check       = "linux-notes.org"
#
#    #create_https_route53_health_check   = "true"
#    #fqdn_for_https_route53_health_check = "linux-notes.org"
#}

```

Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default     = "TEST"`).
- `region` - The region where to deploy this code (e.g. us-east-1) - (`default     = "us-east-1"`).
- `environment` - Environment for service (`default     = "STAGE"`).
- `orchestration` - "Type of orchestration (`default     = "Terraform"`).
- `createdby` - Created by (`default     = "Vitaliy Natarov"`).
- `enable_elastic_beanstalk_application` - Enable to create elastic_beanstalk_application (`default     = false`).
- `appversion_lifecycle` - Settings for appversion_lifecycle (`default     = [
    {
        service_role          = "arn:aws:iam::167127734783:role/aws-elasticbeanstalk-service-role"
        max_count             = 128
        delete_source_from_s3 = true
    }
    ]`).
- `enable_elastic_beanstalk_environment` - Enable to create elastic_beanstalk_environment (`default     = false`).
- `application_name` - A unique name for this Environment. This name is used in the application URL. If not set, will be used from elastic_beanstalk_application (`default     = ""`).
- `solution_stack_name` - (Optional) A solution stack to base your environment off of. Example stacks can be found in the Amazon API documentation (`default     = "64bit Amazon Linux 2018.03 v2.11.6 running Multi-container Docker 18.06.1-ce (Generic)"`).
- `cname_prefix` - (Optional) Prefix to use for the fully qualified DNS name of the Environment (`default     = ""`).
- `tier` - (Optional) Elastic Beanstalk Environment tier. Valid values are Worker or WebServer. If tier is left blank WebServer will be used (`default     = "WebServer"`).
- `setting` - (Optional) Option settings to configure the new Environment. These override specific values that are set as defaults. The format is detailed below in Option Settings (`default     = [
    {
        namespace = "aws:autoscaling:asg"
        #resource = "AWSEBAutoScalingGroup"
        name = "MaxSize"
        value = "1"
    }
  ]`).
- `template_name` - (Optional) The name of the Elastic Beanstalk Configuration template to use in deployment (`default     = ""`).
- `wait_for_ready_timeout` - (Default: 20m) The maximum duration that Terraform should wait for an Elastic Beanstalk Environment to be in a ready state before timing out (`default     = "20m"`).
- `poll_interval` - The time between polling the AWS API to check if changes have been applied. Use this to adjust the rate of API calls for any create or update action. Minimum 10s, maximum 180s. Omit this to use the default behavior, which is an exponential backoff (`default     = "10s"`).
- `version_label` - (Optional) The name of the Elastic Beanstalk Application Version to use in deployment (`default     = ""`).
- `enable_elastic_beanstalk_application_version` - Enable creating beanstalk application version (`default     = false`).
- `beanstalk_application_name` - (Required) Name of the Beanstalk Application the version is associated with (`default     = ""`).
- `bucket` - (Required) S3 bucket that contains the Application Version source bundle (`default     = ""`).
- `key` - (Required) S3 object that is the Application Version source bundle (`default     = ""`).
- `force_delete` - (Optional) On delete, force an Application Version to be deleted when it may be in use by multiple Elastic Beanstalk Environments (`default     = false`).
- `enable_elastic_beanstalk_configuration_template` - Enable creating beanstalk configuration template (`default     = false`).
- `configuration_template_name` - (Required) A unique name for this Template (`default     = ""`).
- `environment_id` - (Optional) The ID of the environment used with this configuration template (` default     = ""`).


Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See LICENSE for full details.

