#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.12.12"
}

provider "aws" {
    region                  = "us-east-1"
    shared_credentials_file = pathexpand("~/.aws/credentials")
    profile                 = "default"
}

module "mq" {
    source                          = "../../modules/mq"
    name                            = "TEST-BROKER"
    region                          = "us-east-1"
    environment                     = "PROD"

    # MQ config
    enable_mq_configuration         = true
    mq_configuration_name           = ""
    mq_configuration_description    = ""

    engine_type                     = "ActiveMQ"
    engine_version                  = "5.15.8"
    mq_configuration_data           = file("data/data.xml.tpl")

    # MQ broker
    enable_mq_broker                = true
    broker_name                     = ""

    security_group_ids              = ["sg-aed75fe1"]
    subnet_ids                      = ["subnet-8851dea6"]

    logs                            = [
        {
            audit   = true
            general = true
        }
    ]

    maintenance_window_start_time   = [
        {
            day_of_week     = "MONDAY"
            time_of_day     = "02:00"
            time_zone       = "UTC"
        }
    ]

    user                            = [
        {
            console_access  = true
            groups          = ["mq_broker"]
            username        = "mq_broker"
            password        = "mq_broker666"
        },
    ]
}
