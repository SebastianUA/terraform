# Work with DMS2 via terraform

A terraform module for making DMS2.


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
}

# See sub-folder.... 
```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default = {}`)
- `enable_dms_certificate` - Enable dms certificate usage (`default = False`)
- `dms_certificates` - Set list of DMS certificates (`default = []`)
- `enable_dms_endpoint` - Enable dms endpoint usage (`default = False`)
- `dms_endpoints` - Set list of dms endpoints (`default = []`)
- `enable_dms_replication_subnet_group` - Enable dms replication subnet group usage (`default = False`)
- `dms_replication_subnet_group_replication_subnet_group_description` - The description for the subnet group. (`default = ""`)
- `dms_replication_subnet_group_replication_subnet_group_id` - The name for the replication subnet group. This value is stored as a lowercase string. (`default = ""`)
- `dms_replication_subnet_group_subnet_ids` - (Required) A list of the EC2 subnet IDs for the subnet group. (`default = null`)
- `enable_dms_replication_instance` - Enable dms replication instance usage (`default = False`)
- `dms_replication_instance_replication_instance_class` - (Required) The compute and memory capacity of the replication instance as specified by the replication instance class. Can be one of dms.t2.micro | dms.t2.small | dms.t2.medium | dms.t2.large | dms.c4.large | dms.c4.xlarge | dms.c4.2xlarge | dms.c4.4xlarge (`default = dms.t2.micro`)
- `dms_replication_instance_replication_instance_id` - (Required) The replication instance identifier. This parameter is stored as a lowercase string. (`default = ""`)
- `dms_replication_instance_replication_subnet_group_id` - (Required) The replication instance identifier. This parameter is stored as a lowercase string. (`default = ""`)
- `dms_replication_instance_allocated_storage` - (Optional, Default: 50, Min: 5, Max: 6144) The amount of storage (in gigabytes) to be initially allocated for the replication instance. (`default = null`)
- `dms_replication_instance_apply_immediately` - (Optional, Default: false) Indicates whether the changes should be applied immediately or during the next maintenance window. Only used when updating an existing resource. (`default = null`)
- `dms_replication_instance_auto_minor_version_upgrade` - (Optional, Default: false) Indicates that minor engine upgrades will be applied automatically to the replication instance during the maintenance window. (`default = null`)
- `dms_replication_instance_availability_zone` - (Optional) The EC2 Availability Zone that the replication instance will be created in. (`default = null`)
- `dms_replication_instance_engine_version` - (Optional) The engine version number of the replication instance. (`default = null`)
- `dms_replication_instance_kms_key_arn` - (Optional) The Amazon Resource Name (ARN) for the KMS key that will be used to encrypt the connection parameters. If you do not specify a value for kms_key_arn, then AWS DMS will use your default encryption key. AWS KMS creates the default encryption key for your AWS account. Your AWS account has a different default encryption key for each AWS region. (`default = null`)
- `dms_replication_instance_multi_az` - (Optional) Specifies if the replication instance is a multi-az deployment. You cannot set the availability_zone parameter if the multi_az parameter is set to true. (`default = null`)
- `dms_replication_instance_preferred_maintenance_window` - (Optional) The weekly time range during which system maintenance can occur, in Universal Coordinated Time (UTC). (`default = null`)
- `dms_replication_instance_publicly_accessible` - (Optional, Default: false) Specifies the accessibility options for the replication instance. A value of true represents an instance with a public IP address. A value of false represents an instance with a private IP address. (`default = null`)
- `dms_replication_instance_vpc_security_group_ids` - (Optional) A list of VPC security group IDs to be used with the replication instance. The VPC security groups must work with the VPC containing the replication instance. (`default = null`)
- `dms_replication_instance_allow_major_version_upgrade` - (Optional, Default: false) Indicates that major version upgrades are allowed. (`default = null`)
- `dms_replication_instance_timeouts` - Set timeouts for dms replication instance (`default = {}`)
- `enable_dms_replication_task` - Enable dms replication task usage (`default = False`)
- `dms_replication_tasks` - Set list of dms replication tasks (`default = []`)
- `enable_dms_event_subscription` - Enable dms event subscription usage (`default = False`)
- `dms_event_subscriptions` - Set list of dms event subscription (`default = []`)
- `dms_event_subscription_timeouts` - Set timeouts for dms event subscription (`default = {}`)

## Module Output Variables
----------------------
- `dms_certificates` - A map of maps containing the certificates created and their full output of attributes and values
- `dms_endpoints` - A map of maps containing the endpoints created and their full output of attributes and values
- `dms_replication_subnet_group_id` - The Amazon Resource Name (ID) for the replication subnet group.
- `dms_replication_subnet_group_tags_all` - A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
- `dms_replication_subnet_group_vpc_id` - The ID of the VPC the subnet group is in.
- `dms_replication_instance_id` - The Amazon Resource Name (ID) for the replication instance.
- `dms_replication_instance_replication_instance_arn` - The Amazon Resource Name (ARN) of the replication instance.
- `dms_replication_instance_replication_instance_private_ips` - A list of the private IP addresses of the replication instance.
- `dms_replication_instance_replication_instance_public_ips` - A list of the public IP addresses of the replication instance.
- `dms_replication_instance_tags_all` - A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block
- `dms_replication_tasks` - The Amazon Resource Name (ID) for the replication tasks.
- `dms_event_subscriptions` - A map of maps containing the event subscriptions created and their full output of attributes and values


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
