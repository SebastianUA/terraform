# Work with AWS MQ Broker via terraform

A terraform module for making MQ Broker.

## Usage
--------

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
```

Module Input Variables
----------------------

- `name` - Name to be used on all resources as prefix (`default     = "TEST-MQ"`).
- `region` - The region where to deploy this code (e.g. us-east-1). (`default     = "us-east-1"`). 
- `environment` - Environment for service (`  default     = "STAGE"`).
- `orchestration` - Type of orchestration (`  default     = "Terraform"`).
- `createdby` - Created by (`  default     = "Vitaliy Natarov"`).
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`  default     = {}`).
- `enable_mq_configuration` - Enabele MQ configuration (`default       = false`).
- `mq_configuration_name` - The name of the configuration (`default       = ""`).
- `mq_configuration_description` - (Optional) The description of the configuration. (`default       = ""`).
- `engine_type` - The type of broker engine. Currently, Amazon MQ supports only ActiveMQ. (`  default     = "ActiveMQ"`).
- `engine_version` - The version of the broker engine. Currently, Amazon MQ supports only 5.15.0 (`  default     = "5.15.8"`).
- `mq_configuration_data` - description (`default       = ""`).
- `enable_mq_broker` - Enable MQ broker usage (`default       = false`).
- `broker_name` - The name of the broker. (`default       = ""`).
- `host_instance_type` - The broker's instance type. e.g. mq.t2.micro or mq.m4.large (`  default     = "mq.t2.micro"`).
- `security_group_ids` - The list of security group IDs assigned to the broker. (`default     = []`).
- `subnet_ids` - The list of subnet IDs in which to launch the broker. A SINGLE_INSTANCE deployment requires one subnet. An ACTIVE_STANDBY_MULTI_AZ deployment requires two subnets. (`default     = []`).
- `apply_immediately` - Specifies whether any broker modifications are applied immediately, or during the next maintenance window. Default is false. (`  default     = false`).
- `auto_minor_version_upgrade` - Enables automatic upgrades to new minor versions for brokers, as Apache releases the versions. (`  default     = false`).
- `deployment_mode` - The deployment mode of the broker. Supported: SINGLE_INSTANCE and ACTIVE_STANDBY_MULTI_AZ. Defaults to SINGLE_INSTANCE. (`  default     = "SINGLE_INSTANCE"`).
- `publicly_accessible` - Whether to enable connections from applications outside of the VPC that hosts the broker's subnets. (`default     = false`).
- `configuration` - Configuration of the broker. (`default       = []`).
- `encryption_options` - Configuration block containing encryption options (`default       = []`).
- `maintenance_window_start_time` - Maintenance window start time (`default       = []`).
- `logs` - (Optional) Logging configuration of the broker. (`default       = []`).
- `user` - The list of all ActiveMQ usernames for the specified broker. (`default       = []`).


Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See LICENSE for full details.
