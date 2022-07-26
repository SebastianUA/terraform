# Work with MQ via terraform

A terraform module for making MQ.


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

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `mq_brokers` - versions by mq type (`default = {'ActiveMQ': '5.15.0', 'RabbitMQ': '3.8.22'}`)
- `tags` - A list of tag blocks. (`default = {}`)
- `enable_mq_configuration` - Enabele MQ configuration (`default = False`)
- `mq_configuration_name` - The name of the configuration (`default = ""`)
- `mq_configuration_description` - (Optional) The description of the configuration. (`default = ""`)
- `mq_configuration_engine_type` - (Required) Type of broker engine. Valid values are ActiveMQ and RabbitMQ. (`default = ActiveMQ`)
- `mq_configuration_engine_version` - The version of the broker engine. Currently, Amazon MQ supports only 5.15.0 (`default = 5.15.8`)
- `mq_configuration_data` - Set data for MQ configuration (`default = ""`)
- `enable_mq_broker` - Enable MQ broker usage (`default = False`)
- `broker_name` - The name of the broker. (`default = ""`)
- `mq_broker_engine_type` - Set MQ broker engine type (`default = ActiveMQ`)
- `mq_broker_engine_version` - Set MQ broker engine version (`default = ""`)
- `mq_broker_host_instance_type` - The broker's instance type. e.g. mq.t2.micro or mq.m4.large (`default = mq.t2.micro`)
- `mq_broker_security_group_ids` - The list of security group IDs assigned to the broker. (`default = []`)
- `mq_broker_subnet_ids` - The list of subnet IDs in which to launch the broker. A SINGLE_INSTANCE deployment requires one subnet. An ACTIVE_STANDBY_MULTI_AZ deployment requires two subnets. (`default = []`)
- `mq_broker_apply_immediately` - Specifies whether any broker modifications are applied immediately, or during the next maintenance window. Default is false. (`default = False`)
- `mq_broker_auto_minor_version_upgrade` - Enables automatic upgrades to new minor versions for brokers, as Apache releases the versions. (`default = False`)
- `mq_broker_deployment_mode` - The deployment mode of the broker. Supported: SINGLE_INSTANCE and ACTIVE_STANDBY_MULTI_AZ. Defaults to SINGLE_INSTANCE. (`default = SINGLE_INSTANCE`)
- `mq_broker_publicly_accessible` - Whether to enable connections from applications outside of the VPC that hosts the broker's subnets. (`default = False`)
- `mq_broker_configuration` - Configuration of the broker. (`default = {}`)
- `mq_broker_encryption_options` - Configuration block containing encryption options (`default = {}`)
- `mq_broker_maintenance_window_start_time` - Maintenance window start time (`default = {}`)
- `mq_broker_logs` - (Optional) Logging configuration of the broker. (`default = {}`)
- `mq_broker_users` - The list of all ActiveMQ usernames for the specified broker. (`default = []`)

## Module Output Variables
----------------------
- `mq_configuration_id` - The unique ID that Amazon MQ generates for the configuration.
- `mq_configuration_arn` - The ARN of the configuration.
- `mq_configuration_latest_revision` - The latest revision of the configuration.
- `mq_broker_id` - The unique ID that Amazon MQ generates for the broker.
- `mq_broker_arn` - The ARN of the broker.
- `mq_broker_instances` - A list of information about allocated brokers (both active & standby).


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
