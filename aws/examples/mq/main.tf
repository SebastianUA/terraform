#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 1.0"
}

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
  profile                 = "default"
}

module "mq" {
  source      = "../../modules/mq"
  name        = "TEST-BROKER"
  environment = "stage"

  # MQ config
  enable_mq_configuration      = true
  mq_configuration_name        = ""
  mq_configuration_description = ""

  mq_configuration_engine_type    = "ActiveMQ"
  mq_configuration_engine_version = "5.15.8"
  mq_configuration_data           = file("data/data.xml.tpl")

  # MQ broker
  enable_mq_broker = true
  broker_name      = ""

  mq_broker_security_group_ids = ["sg-aed75fe1"]
  mq_broker_subnet_ids         = ["subnet-8851dea6"]

  mq_broker_logs = {
    audit   = true
    general = true
  }

  mq_broker_maintenance_window_start_time = {
    day_of_week = "MONDAY"
    time_of_day = "02:00"
    time_zone   = "UTC"
  }

  mq_broker_users = [
    {
      console_access = true
      groups         = ["mq_broker"]
      username       = "mq_broker"
      password       = "mq_broker666"
    },
    {
      console_access = true
      groups         = ["mr_broker"]
      username       = "mr_broker"
      password       = "mr_broker666"
    }
  ]

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}
