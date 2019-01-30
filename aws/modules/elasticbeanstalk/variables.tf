#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST"
}

variable "region" {
  description = "The region where to deploy this code (e.g. us-east-1)."
  default     = "us-east-1"
} 

variable "environment" {
    description = "Environment for service"
    default     = "STAGE"
}

variable "orchestration" {
    description = "Type of orchestration"
    default     = "Terraform"
}

variable "createdby" {
    description = "Created by"
    default     = "Vitaliy Natarov"
}

#-----------------------------------------------------------
# EB APP
#-----------------------------------------------------------
variable "enable_elastic_beanstalk_application" {
   description = "Enable to create elastic_beanstalk_application"
   default     = "false"
}

variable "appversion_lifecycle" {
    description = "Settings for appversion_lifecycle variable "
    type        = "list"
    default     = [
    {
        service_role          = "arn:aws:iam::167127734783:role/aws-elasticbeanstalk-service-role"
        max_count             = 128
        delete_source_from_s3 = true
    }
    ]
}

#variable "appversion_lifecycle_service_role" {
#    description = "(Required) The ARN of an IAM service role under which the application version is deleted. Elastic Beanstalk must have permission to assume this role."
#    default     = ""
#}
#
#variable "appversion_lifecycle_max_count" {
#    description = "(Optional) The maximum number of application versions to retain."
#    default     = "128"
#}
#
#variable "appversion_lifecycle_max_age_in_days" {
#    description = "(Optional) The number of days to retain an application version."
#    default     = 0
#}
#
#variable "appversion_lifecycle_delete_source_from_s3" {
#    description = "(Optional) Set to true to delete a version's source bundle from S3 when the application version is deleted."
#    default     = true
#}


#-----------------------------------------------------------
# EB ENV
#-----------------------------------------------------------
variable "enable_elastic_beanstalk_environment" { 
    description = "Enable to create elastic_beanstalk_environment"
    default     = false
}

variable "application_name" {
    description = "A unique name for this Environment. This name is used in the application URL. If not set, will be used from elastic_beanstalk_application"
    default     = ""
}

variable "solution_stack_name" {
    description = "(Optional) A solution stack to base your environment off of. Example stacks can be found in the Amazon API documentation"
    default     = "64bit Amazon Linux 2018.03 v2.11.7 running Multi-container Docker 18.06.1-ce (Generic)"
}

variable "cname_prefix" {
    description = "(Optional) Prefix to use for the fully qualified DNS name of the Environment."
    default     = ""
}

variable "tier" {   
    description = "(Optional) Elastic Beanstalk Environment tier. Valid values are Worker or WebServer. If tier is left blank WebServer will be used."
    default     = "WebServer"
}

variable "setting" {
    description = "(Optional) Option settings to configure the new Environment. These override specific values that are set as defaults. The format is detailed below in Option Settings."
    type        = "list"
    default     = [
    {
        namespace = "aws:autoscaling:asg"
        #resource = "AWSEBAutoScalingGroup"
        name = "MaxSize"
        value = "1"
    }
  ]
}

#variable "all_settings" {
#    description = "All setting for EB environment"
#    type        = "list"
#    default     = []
#}

variable "template_name" {
    description = "(Optional) The name of the Elastic Beanstalk Configuration template to use in deployment"
    default     = ""
}

#variable "platform_arn" {
#    description = "(Optional) The ARN of the Elastic Beanstalk Platform to use in deployment"
#    default     = ""
#}

variable "wait_for_ready_timeout" {
    description = "(Default: 20m) The maximum duration that Terraform should wait for an Elastic Beanstalk Environment to be in a ready state before timing out."
    default     = "20m"
}

variable "poll_interval" {
    description = "The time between polling the AWS API to check if changes have been applied. Use this to adjust the rate of API calls for any create or update action. Minimum 10s, maximum 180s. Omit this to use the default behavior, which is an exponential backoff"
    default     = "10s"
}

variable "version_label" {
    description = "(Optional) The name of the Elastic Beanstalk Application Version to use in deployment."
    default     = ""
}

#-----------------------------------------------------------
# EB application version
#-----------------------------------------------------------
variable "enable_elastic_beanstalk_application_version" {
    description = "Enable creating beanstalk application version"
    default     = false
}

variable "beanstalk_application_name" {
    description = "(Required) Name of the Beanstalk Application the version is associated with."
    default     = ""
}

variable "bucket" {
    description = "(Required) S3 bucket that contains the Application Version source bundle."
    default     = ""
}

variable "key" {    
    description = "(Required) S3 object that is the Application Version source bundle."
    default     = ""
}

variable "keys" {
    description = ""
    type        = "list"
    default     = []
}
 
variable "force_delete" {
    description = "(Optional) On delete, force an Application Version to be deleted when it may be in use by multiple Elastic Beanstalk Environments."
    default     = false
}


variable "deploy_or_rollback" {
    description = "Set 'deploy' to deploy AWS EB stack or 'rollback' to use s3_bucket_object as rollback"
    default     = "deploy"
}
#-----------------------------------------------------------
# EB configuration template
#-----------------------------------------------------------
variable "enable_elastic_beanstalk_configuration_template" {
    description = "Enable creating beanstalk configuration template"
    default     = false
}

variable "configuration_template_name" {
    description = "(Required) A unique name for this Template."
    default     = ""
}

variable "environment_id" {
    description = "(Optional) The ID of the environment used with this configuration template"
    default     = ""
}
