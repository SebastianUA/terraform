# Work with DMS via terraform

A terraform module for making DMS.


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

module "source_dms_endpoint" {
  source      = "../../modules/dms"
  name        = "TEST"
  environment = "stage"

  # enable dms certificate
  enable_dms_certificate             = false
  dms_certificate_certificate_id     = "test-dms-certificate-tf"
  dms_certificate_certificate_pem    = "..."
  dms_certificate_certificate_wallet = null

  # enable dms endpoint
  enable_dms_endpoint                      = true
  dms_endpoint_certificate_arn             = "arn:aws:acm:us-east-1:123456789012:certificate/12345678-1234-1234-1234-123456789012"
  dms_endpoint_database_name               = "test"
  dms_endpoint_endpoint_id                 = "test-dms-endpoint-tf"
  dms_endpoint_endpoint_type               = "source"
  dms_endpoint_engine_name                 = "aurora"
  dms_endpoint_extra_connection_attributes = ""
  dms_endpoint_kms_key_arn                 = "arn:aws:kms:us-east-1:123456789012:key/12345678-1234-1234-1234-123456789012"
  dms_endpoint_password                    = "test"
  dms_endpoint_port                        = 3306
  dms_endpoint_server_name                 = "test"
  dms_endpoint_ssl_mode                    = "none"

  # enable dms replication subnet group
  enable_dms_replication_subnet_group                               = true
  dms_replication_subnet_group_name                                 = ""
  dms_replication_subnet_group_replication_subnet_group_description = ""
  dms_replication_subnet_group_subnet_ids                           = ["sbt-434hjk"]

  # enable dms replication instance
  enable_dms_replication_instance                     = true
  dms_replication_instance_replication_instance_class = "dms.t2.micro"
  dms_replication_instance_replication_instance_id    = ""

  dms_replication_instance_allocated_storage            = 20
  dms_replication_instance_apply_immediately            = true
  dms_replication_instance_auto_minor_version_upgrade   = true
  dms_replication_instance_availability_zone            = "us-east-1c"
  dms_replication_instance_engine_version               = "3.1.4"
  dms_replication_instance_kms_key_arn                  = "arn:aws:kms:us-east-1:123456789012:key/12345678-1234-1234-1234-123456789012"
  dms_replication_instance_multi_az                     = false
  dms_replication_instance_preferred_maintenance_window = "sun:10:30-sun:14:30"
  dms_replication_instance_publicly_accessible          = true
  dms_replication_instance_vpc_security_group_ids       = ["sg-12345678"]


  tags = tomap({ "env" = "stage", "CreatedBy" = "Vitaliy Natarov" })
}

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default = {}`)
- `enable_dms_certificate` - Enable dms certificate usage (`default = False`)
- `dms_certificate_name` - Set name for dms certificate (`default = ""`)
- `dms_certificate_certificate_id` - (Required) The certificate identifier. (`default = null`)
- `dms_certificate_certificate_pem` - (Optional) The contents of the .pem X.509 certificate file for the certificate. Either certificate_pem or certificate_wallet must be set. (`default = null`)
- `dms_certificate_certificate_wallet` -  (Optional) The contents of the Oracle Wallet certificate for use with SSL, provided as a base64-encoded String. Either certificate_pem or certificate_wallet must be set. (`default = null`)
- `enable_dms_endpoint` - Enable dms endpoint usage (`default = False`)
- `dms_endpoint_endpoint_type` - (Required) The type of endpoint. Can be one of source | target. (`default = null`)
- `dms_endpoint_engine_name` - (Required) The type of engine for the endpoint. Can be one of aurora | aurora-postgresql| azuredb | db2 | docdb | dynamodb | elasticsearch | kafka | kinesis | mariadb | mongodb | mysql | oracle | postgres | redshift | s3 | sqlserver | sybase. (`default = null`)
- `dms_endpoint_endpoint_id` - (Required) The database endpoint identifier. (`default = null`)
- `dms_endpoint_certificate_arn` - (Optional, Default: empty string) The Amazon Resource Name (ARN) for the certificate. (`default = null`)
- `dms_endpoint_database_name` - (Optional) The name of the endpoint database. (`default = null`)
- `dms_endpoint_extra_connection_attributes` - (Optional) Additional attributes associated with the connection. For available attributes see Using Extra Connection Attributes with AWS Database Migration Service. (`default = null`)
- `dms_endpoint_kms_key_arn` - (Required when engine_name is mongodb, optional otherwise) The Amazon Resource Name (ARN) for the KMS key that will be used to encrypt the connection parameters. If you do not specify a value for kms_key_arn, then AWS DMS will use your default encryption key. AWS KMS creates the default encryption key for your AWS account. Your AWS account has a different default encryption key for each AWS region. (`default = null`)
- `dms_endpoint_password` - (Optional) The password to be used to login to the endpoint database. (`default = null`)
- `dms_endpoint_port` - (Optional) The port used by the endpoint database. (`default = null`)
- `dms_endpoint_username` - (Optional) The user name to be used to login to the endpoint database. (`default = null`)
- `dms_endpoint_server_name` - (Optional) The host name of the server. (`default = null`)
- `dms_endpoint_ssl_mode` - (Optional, Default: none) The SSL mode to use for the connection. Can be one of none | require | verify-ca | verify-full (`default = null`)
- `dms_endpoint_service_access_role` - (Optional) The Amazon Resource Name (ARN) used by the service access IAM role for dynamodb endpoints. (`default = null`)
- `dms_endpoint_elasticsearch_settings` - (Optional) Configuration block with Elasticsearch settings. (`default = {}`)
- `dms_endpoint_kafka_settings` - (Optional) Configuration block with Kafka settings. (`default = {}`)
- `dms_endpoint_kinesis_settings` - (Optional) Configuration block with Kinesis settings. (`default = {}`)
- `dms_endpoint_mongodb_settings` - (Optional) Configuration block with MongoDB settings. (`default = {}`)
- `dms_endpoint_s3_settings` - (Optional) Configuration block with S3 settings. (`default = {}`)
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
- `dms_replication_task_migration_type` - (Required) The migration type. Can be one of full-load | cdc | full-load-and-cdc. (`default = null`)
- `dms_replication_task_replication_instance_arn` - (Required) The Amazon Resource Name (ARN) of the replication instance. (`default = ""`)
- `dms_replication_task_replication_task_id` - (Required) The replication task identifier. (`default = null`)
- `dms_replication_task_source_endpoint_arn` - The Amazon Resource Name (ARN) string that uniquely identifies the source endpoint. (`default = ""`)
- `dms_replication_task_target_endpoint_arn` - (Required) The Amazon Resource Name (ARN) string that uniquely identifies the target endpoint. (`default = null`)
- `dms_replication_task_table_mappings` - (Required) An escaped JSON string that contains the table mappings. For information on table mapping see Using Table Mapping with an AWS Database Migration Service Task to Select and Filter Data (`default = null`)
- `dms_replication_task_cdc_start_time` - (Optional) The Unix timestamp integer for the start of the Change Data Capture (CDC) operation. (`default = null`)
- `dms_replication_task_replication_task_settings` - (Optional) An escaped JSON string that contains the task settings. For a complete list of task settings, see Task Settings for AWS Database Migration Service Tasks. (`default = null`)
- `enable_dms_event_subscription` - Enable dms event subscription usage (`default = False`)
- `dms_event_subscription_name` - Name of event subscription. (`default = ""`)
- `dms_event_subscription_source_ids` - (Required) Ids of sources to listen to. (`default = []`)
- `dms_event_subscription_sns_topic_arn` - (Required) SNS topic arn to send events on. (`default = null`)
- `dms_event_subscription_enabled` - (Optional, Default: true) Whether the event subscription should be enabled. (`default = null`)
- `dms_event_subscription_event_categories` - (Optional) List of event categories to listen for, see DescribeEventCategories for a canonical list. (`default = null`)
- `dms_event_subscription_source_type` - (Optional, Default: all events) Type of source for events. Valid values: replication-instance or replication-task (`default = null`)
- `dms_event_subscription_timeouts` - Set timeouts for dms event subscription (`default = {}`)

## Module Output Variables
----------------------
- `dms_certificate_id` - The Amazon Resource Name (ID) for the certificate.
- `dms_certificate_certificate_arn` - The Amazon Resource Name (ARN) for the certificate.
- `dms_certificate_tags_all` - A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
- `dms_endpoint_id` - The Amazon Resource Name (ID) for the endpoint.
- `dms_endpoint_endpoint_arn` - The Amazon Resource Name (ARN) for the endpoint.
- `dms_endpoint_tags_all` - A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
- `dms_replication_subnet_group_id` - The Amazon Resource Name (ID) for the replication subnet group.
- `dms_replication_subnet_group_tags_all` - A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
- `dms_replication_subnet_group_vpc_id` - The ID of the VPC the subnet group is in.
- `dms_replication_instance_id` - The Amazon Resource Name (ID) for the replication instance.
- `dms_replication_instance_replication_instance_arn` - The Amazon Resource Name (ARN) of the replication instance.
- `dms_replication_instance_replication_instance_private_ips` - A list of the private IP addresses of the replication instance.
- `dms_replication_instance_replication_instance_public_ips` - A list of the public IP addresses of the replication instance.
- `dms_replication_instance_tags_all` - A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block
- `dms_replication_task_id` - The Amazon Resource Name (ID) for the replication task.
- `dms_replication_task_replication_task_arn` - The Amazon Resource Name (ARN) for the replication task.
- `dms_replication_task_tags_all` - A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
- `dms_event_subscription_id` - The Amazon Resource Name (ID) for the event subscription.
- `dms_event_subscription_arn` - Amazon Resource Name (ARN) of the DMS Event Subscription.
- `dms_event_subscription_tags_all` - A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
