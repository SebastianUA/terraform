#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST"
}

variable "environment" {
  description = "Environment for service"
  default     = "STAGE"
}

variable "tags" {
  description = "A list of tag blocks. Each element should have keys named key, value, etc."
  type        = map(string)
  default     = {}
}

#---------------------------------------------------
# AWS dms certificate
#---------------------------------------------------
variable "enable_dms_certificate" {
  description = "Enable dms certificate usage"
  default     = false
}

variable "dms_certificate_name" {
  description = "Set name for dms certificate"
  default     = ""
}

variable "dms_certificate_certificate_id" {
  description = "(Required) The certificate identifier."
  default     = null
}

variable "dms_certificate_certificate_pem" {
  description = "(Optional) The contents of the .pem X.509 certificate file for the certificate. Either certificate_pem or certificate_wallet must be set."
  default     = null
}

variable "dms_certificate_certificate_wallet" {
  description = " (Optional) The contents of the Oracle Wallet certificate for use with SSL, provided as a base64-encoded String. Either certificate_pem or certificate_wallet must be set."
  default     = null
}

#---------------------------------------------------
# AWS dms endpoint
#---------------------------------------------------
variable "enable_dms_endpoint" {
  description = "Enable dms endpoint usage"
  default     = false
}

variable "dms_endpoint_endpoint_type" {
  description = "(Required) The type of endpoint. Can be one of source | target."
  default     = null
}

variable "dms_endpoint_engine_name" {
  description = "(Required) The type of engine for the endpoint. Can be one of aurora | aurora-postgresql| azuredb | db2 | docdb | dynamodb | elasticsearch | kafka | kinesis | mariadb | mongodb | mysql | oracle | postgres | redshift | s3 | sqlserver | sybase."
  default     = null
}

variable "dms_endpoint_endpoint_id" {
  description = "(Required) The database endpoint identifier."
  default     = null
}

variable "dms_endpoint_certificate_arn" {
  description = "(Optional, Default: empty string) The Amazon Resource Name (ARN) for the certificate."
  default     = null
}

variable "dms_endpoint_database_name" {
  description = "(Optional) The name of the endpoint database."
  default     = null
}

variable "dms_endpoint_extra_connection_attributes" {
  description = "(Optional) Additional attributes associated with the connection. For available attributes see Using Extra Connection Attributes with AWS Database Migration Service."
  default     = null
}

variable "dms_endpoint_kms_key_arn" {
  description = "(Required when engine_name is mongodb, optional otherwise) The Amazon Resource Name (ARN) for the KMS key that will be used to encrypt the connection parameters. If you do not specify a value for kms_key_arn, then AWS DMS will use your default encryption key. AWS KMS creates the default encryption key for your AWS account. Your AWS account has a different default encryption key for each AWS region."
  default     = null
}

variable "dms_endpoint_password" {
  description = "(Optional) The password to be used to login to the endpoint database."
  default     = null
}

variable "dms_endpoint_port" {
  description = "(Optional) The port used by the endpoint database."
  default     = null
}

variable "dms_endpoint_username" {
  description = "(Optional) The user name to be used to login to the endpoint database."
  default     = null
}

variable "dms_endpoint_server_name" {
  description = "(Optional) The host name of the server."
  default     = null
}

variable "dms_endpoint_ssl_mode" {
  description = "(Optional, Default: none) The SSL mode to use for the connection. Can be one of none | require | verify-ca | verify-full"
  default     = null
}

variable "dms_endpoint_service_access_role" {
  description = "(Optional) The Amazon Resource Name (ARN) used by the service access IAM role for dynamodb endpoints."
  default     = null
}

variable "dms_endpoint_elasticsearch_settings" {
  description = "(Optional) Configuration block with Elasticsearch settings."
  default     = {}
}

variable "dms_endpoint_kafka_settings" {
  description = "(Optional) Configuration block with Kafka settings."
  default     = {}
}

variable "dms_endpoint_kinesis_settings" {
  description = "(Optional) Configuration block with Kinesis settings."
  default     = {}
}

variable "dms_endpoint_mongodb_settings" {
  description = "(Optional) Configuration block with MongoDB settings."
  default     = {}
}

variable "dms_endpoint_s3_settings" {
  description = "(Optional) Configuration block with S3 settings."
  default     = {}
}

#---------------------------------------------------
# AWS dms replication subnet group
#---------------------------------------------------
variable "enable_dms_replication_subnet_group" {
  description = "Enable dms replication subnet group usage"
  default     = false
}

variable "dms_replication_subnet_group_replication_subnet_group_description" {
  description = "The description for the subnet group."
  default     = ""
}

variable "dms_replication_subnet_group_replication_subnet_group_id" {
  description = "The name for the replication subnet group. This value is stored as a lowercase string."
  default     = ""
}

variable "dms_replication_subnet_group_subnet_ids" {
  description = "(Required) A list of the EC2 subnet IDs for the subnet group."
  default     = null
}

#---------------------------------------------------
# AWS dms replication instance
#---------------------------------------------------
variable "enable_dms_replication_instance" {
  description = "Enable dms replication instance usage"
  default     = false
}

variable "dms_replication_instance_replication_instance_class" {
  description = "(Required) The compute and memory capacity of the replication instance as specified by the replication instance class. Can be one of dms.t2.micro | dms.t2.small | dms.t2.medium | dms.t2.large | dms.c4.large | dms.c4.xlarge | dms.c4.2xlarge | dms.c4.4xlarge"
  default     = "dms.t2.micro"
}

variable "dms_replication_instance_replication_instance_id" {
  description = "(Required) The replication instance identifier. This parameter is stored as a lowercase string."
  default     = ""
}

variable "dms_replication_instance_replication_subnet_group_id" {
  description = "(Required) The replication instance identifier. This parameter is stored as a lowercase string."
  default     = ""
}

variable "dms_replication_instance_allocated_storage" {
  description = "(Optional, Default: 50, Min: 5, Max: 6144) The amount of storage (in gigabytes) to be initially allocated for the replication instance."
  default     = null
}

variable "dms_replication_instance_apply_immediately" {
  description = "(Optional, Default: false) Indicates whether the changes should be applied immediately or during the next maintenance window. Only used when updating an existing resource."
  default     = null
}

variable "dms_replication_instance_auto_minor_version_upgrade" {
  description = "(Optional, Default: false) Indicates that minor engine upgrades will be applied automatically to the replication instance during the maintenance window."
  default     = null
}

variable "dms_replication_instance_availability_zone" {
  description = "(Optional) The EC2 Availability Zone that the replication instance will be created in."
  default     = null
}

variable "dms_replication_instance_engine_version" {
  description = "(Optional) The engine version number of the replication instance."
  default     = null
}

variable "dms_replication_instance_kms_key_arn" {
  description = "(Optional) The Amazon Resource Name (ARN) for the KMS key that will be used to encrypt the connection parameters. If you do not specify a value for kms_key_arn, then AWS DMS will use your default encryption key. AWS KMS creates the default encryption key for your AWS account. Your AWS account has a different default encryption key for each AWS region."
  default     = null
}

variable "dms_replication_instance_multi_az" {
  description = "(Optional) Specifies if the replication instance is a multi-az deployment. You cannot set the availability_zone parameter if the multi_az parameter is set to true."
  default     = null
}

variable "dms_replication_instance_preferred_maintenance_window" {
  description = "(Optional) The weekly time range during which system maintenance can occur, in Universal Coordinated Time (UTC)."
  default     = null
}

variable "dms_replication_instance_publicly_accessible" {
  description = "(Optional, Default: false) Specifies the accessibility options for the replication instance. A value of true represents an instance with a public IP address. A value of false represents an instance with a private IP address."
  default     = null
}

variable "dms_replication_instance_vpc_security_group_ids" {
  description = "(Optional) A list of VPC security group IDs to be used with the replication instance. The VPC security groups must work with the VPC containing the replication instance."
  default     = null
}

variable "dms_replication_instance_allow_major_version_upgrade" {
  description = "(Optional, Default: false) Indicates that major version upgrades are allowed."
  default     = null
}

variable "dms_replication_instance_timeouts" {
  description = "Set timeouts for dms replication instance"
  default     = {}
}

#---------------------------------------------------
# AWS dms replication task
#---------------------------------------------------
variable "enable_dms_replication_task" {
  description = "Enable dms replication task usage"
  default     = false
}

variable "dms_replication_task_migration_type" {
  description = "(Required) The migration type. Can be one of full-load | cdc | full-load-and-cdc."
  default     = null
}

variable "dms_replication_task_replication_instance_arn" {
  description = "(Required) The Amazon Resource Name (ARN) of the replication instance."
  default     = ""
}

variable "dms_replication_task_replication_task_id" {
  description = "(Required) The replication task identifier."
  default     = null
}

variable "dms_replication_task_source_endpoint_arn" {
  description = "The Amazon Resource Name (ARN) string that uniquely identifies the source endpoint."
  default     = ""
}

variable "dms_replication_task_target_endpoint_arn" {
  description = "(Required) The Amazon Resource Name (ARN) string that uniquely identifies the target endpoint."
  default     = null
}

variable "dms_replication_task_table_mappings" {
  description = "(Required) An escaped JSON string that contains the table mappings. For information on table mapping see Using Table Mapping with an AWS Database Migration Service Task to Select and Filter Data"
  default     = null
}

variable "dms_replication_task_cdc_start_time" {
  description = "(Optional) The Unix timestamp integer for the start of the Change Data Capture (CDC) operation."
  default     = null
}

variable "dms_replication_task_replication_task_settings" {
  description = "(Optional) An escaped JSON string that contains the task settings. For a complete list of task settings, see Task Settings for AWS Database Migration Service Tasks."
  default     = null
}

#---------------------------------------------------
# AWS dms event subscription
#---------------------------------------------------
variable "enable_dms_event_subscription" {
  description = "Enable dms event subscription usage"
  default     = false
}

variable "dms_event_subscription_name" {
  description = "Name of event subscription."
  default     = ""
}

variable "dms_event_subscription_source_ids" {
  description = "(Required) Ids of sources to listen to."
  default     = []
}

variable "dms_event_subscription_sns_topic_arn" {
  description = "(Required) SNS topic arn to send events on."
  default     = null
}

variable "dms_event_subscription_enabled" {
  description = "(Optional, Default: true) Whether the event subscription should be enabled."
  default     = null
}

variable "dms_event_subscription_event_categories" {
  description = "(Optional) List of event categories to listen for, see DescribeEventCategories for a canonical list."
  default     = null
}

variable "dms_event_subscription_source_type" {
  description = "(Optional, Default: all events) Type of source for events. Valid values: replication-instance or replication-task"
  default     = null
}

variable "dms_event_subscription_timeouts" {
  description = "Set timeouts for dms event subscription"
  default     = {}
}