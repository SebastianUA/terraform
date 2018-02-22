#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST-MQ"
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

variable "engine_type" {
    description = "The type of broker engine. Currently, Amazon MQ supports only ActiveMQ."
    default     = "ActiveMQ"
}

variable "engine_version" {
    description = "The version of the broker engine. Currently, Amazon MQ supports only 5.15.0"
    default     = "5.15.0"
}

variable "host_instance_type" {
    description = "The broker's instance type. e.g. mq.t2.micro or mq.m4.large"
    default     = "mq.t2.micro"
}

variable "security_group_ids" {
    description = "The list of security group IDs assigned to the broker."
    default     = []
}

variable "subnet_ids" {
    description = "The list of subnet IDs in which to launch the broker. A SINGLE_INSTANCE deployment requires one subnet. An ACTIVE_STANDBY_MULTI_AZ deployment requires two subnets."
    default     = []
}

variable "apply_immediately" {
    description = "Specifies whether any broker modifications are applied immediately, or during the next maintenance window. Default is false."
    default     = "false"
}

variable "auto_minor_version_upgrade" {
    description = "Enables automatic upgrades to new minor versions for brokers, as Apache releases the versions."
    default     = "false"
}

variable "deployment_mode" {
    description = "The deployment mode of the broker. Supported: SINGLE_INSTANCE and ACTIVE_STANDBY_MULTI_AZ. Defaults to SINGLE_INSTANCE."
    default     = "SINGLE_INSTANCE"
}

variable "publicly_accessible" {
    description = "Whether to enable connections from applications outside of the VPC that hosts the broker's subnets."
    default     = "false"
}

variable "mq_broker_username" {
    description = "The username of the user."
    default     = "mq_broker"
}

variable "mq_broker_password" {
    description = "The password of the user. It must be 12 to 250 characters long, at least 4 unique characters, and must not contain commas."
    default     = "mq_broker666"
}

variable "mq_broker_groups" {
    description = "The list of groups (20 maximum) to which the ActiveMQ user belongs."
    type        = "list"
    default     = ["mq_broker"]
}

variable "mq_broker_console_access" {
    description = "Whether to enable access to the the ActiveMQ Web Console for the user."
    default     = "true"
}

variable "day_of_week" {
    description = "The day of the week. e.g. MONDAY, TUESDAY, or WEDNESDAY"
    default     = "MONDAY"
}

variable "time_of_day" {
    description = "The time, in 24-hour format. e.g. 02:00"
    default     = "02:00"
}

variable "time_zone" {
    description = "The time zone, UTC by default, in either the Country/City format, or the UTC offset format. e.g. CET"
    default     = "UTC"
}
