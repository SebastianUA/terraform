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
  required_version = "> 0.9.0"
}
provider "aws" {
    region                  = "us-east-1"
    shared_credentials_file = "${pathexpand("~/.aws/credentials")}"
    profile                 = "default"
}
module "vpc" {
    source                              = "../../modules/vpc"
    name                                = "TEST-VPC"
    environment                         = "PROD"
    # VPC
    instance_tenancy                    = "default"
    enable_dns_support                  = "true"
    enable_dns_hostnames                = "true"
    assign_generated_ipv6_cidr_block    = "false"
    enable_classiclink                  = "false"

    vpc_cidr                            = "172.31.0.0/16"
    private_subnet_cidrs                = ["172.31.64.0/20"]
    public_subnet_cidrs                 = ["172.31.80.0/20", "172.31.0.0/20"]
    availability_zones                  = ["us-east-1a", "us-east-1b"]
    allowed_ports                       = ["8080", "3306", "80", "443", "5672"]

    #Internet-GateWay
    enable_internet_gateway             = "true"
    #NAT
    enable_nat_gateway                  = "false"
    single_nat_gateway                  = "true"
    #VPN
    enable_vpn_gateway                  = "false"
    #DHCP
    enable_dhcp_options                 = "false"
    # EIP
    enable_eip                          = "false"
}
module "mq" {
    source                          = "../../modules/mq"
    name                            = "TEST-MQ"
    region                          = "us-east-1"
    environment                     = "PROD"

    security_group_ids     = ["${module.vpc.security_group_id}", "${module.vpc.default_security_group_id}"]
    subnet_ids             = ["${module.vpc.vpc-privatesubnet-ids}"]
}
```

Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = "TEST-MQ"`).
- `region` - The region where to deploy this code (e.g. us-east-1) (`default = "us-east-1"`).
- `environment` - Environment for service (`default = "STAGE"`).
- `orchestration` - Type of orchestration (`default = "Terraform"`).
- `engine_type` - The type of broker engine. Currently, Amazon MQ supports only ActiveMQ (`default     = "ActiveMQ"`).
- `engine_version` - The version of the broker engine. Currently, Amazon MQ supports only 5.15.0 (`default     = "5.15.0"`).
- `host_instance_type` - The broker's instance type. e.g. mq.t2.micro or mq.m4.large (`default     = "mq.t2.micro"`).
- `security_group_ids` - The list of security group IDs assigned to the broker (`default     = []`).
- `subnet_ids` - The list of subnet IDs in which to launch the broker. A SINGLE_INSTANCE deployment requires one subnet. An ACTIVE_STANDBY_MULTI_AZ deployment requires two subnets (`default     = []`).
- `apply_immediately` - Specifies whether any broker modifications are applied immediately, or during the next maintenance window. Default is fals (`default     = "false"`).
- `auto_minor_version_upgrade` - Enables automatic upgrades to new minor versions for brokers, as Apache releases the versions (`default     = "false"`).
- `deployment_mode` - The deployment mode of the broker. Supported: SINGLE_INSTANCE and ACTIVE_STANDBY_MULTI_AZ. Defaults to SINGLE_INSTANCE (`default     = "SINGLE_INSTANCE"`).
- `publicly_accessible` - Whether to enable connections from applications outside of the VPC that hosts the broker's subnet (`default     = "false"`).
- `mq_broker_username` - The username of the user (`default     = "mq_broker"`).
- `mq_broker_password` - The password of the user. It must be 12 to 250 characters long, at least 4 unique characters, and must not contain comma (`default     = "mq_broker666"`). 
- `mq_broker_groups` - The list of groups (20 maximum) to which the ActiveMQ user belongs (`default     = ["mq_broker"]`).
- `mq_broker_console_access` - Whether to enable access to the the ActiveMQ Web Console for the user (`default     = "true"`).
- `day_of_week` - The day of the week. e.g. MONDAY, TUESDAY, or WEDNESDA (`default     = "MONDAY"`).
- `time_of_day` - The time, in 24-hour format. e.g. 02:00 (`default     = "02:00"`).
- `time_zone` - The time zone, UTC by default, in either the Country/City format, or the UTC offset format. e.g. CE (`default     = "UTC"`).

Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See LICENSE for full details.
