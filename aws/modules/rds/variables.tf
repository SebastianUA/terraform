#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST-RDS"
}

variable "region" {
  description = "The region where to deploy this code (e.g. us-east-1)."
  default     = "us-east-1"
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

#-----------------------------------------------------------
# AWS RDS Cluster
#-----------------------------------------------------------
variable "enable_rds_cluster" {
  description = "If true, then rds cluster will create"
  default     = false
}

variable "rds_cluster_master_username" {
  description = "(Required unless a snapshot_identifier or global_cluster_identifier is provided) Username for the master DB user. Please refer to the RDS Naming Constraints. This argument does not support in-place updates and cannot be changed during a restore from snapshot."
  default     = "root"
}

variable "rds_cluster_master_password" {
  description = "(Required unless a snapshot_identifier or global_cluster_identifier is provided) Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file. Please refer to the RDS Naming Constraints"
  sensitive   = true
  default     = "ROot666roOT"
  validation {
    condition     = length(var.rds_cluster_master_password) >= 9
    error_message = "The master password must be more than 9 characters!"
  }
}

variable "rds_cluster_cluster_identifier" {
  description = "(Optional, Forces new resources) The cluster identifier. If omitted, Terraform will assign a random, unique identifier."
  default     = ""
}

variable "rds_cluster_cluster_identifier_prefix" {
  description = "(Optional, Forces new resource) Creates a unique cluster identifier beginning with the specified prefix. Conflicts with cluster_identifier."
  default     = ""
}

variable "rds_cluster_global_cluster_identifier" {
  description = "(Optional) The global cluster identifier specified on aws_rds_global_cluster."
  default     = ""
}

variable "rds_cluster_engine" {
  description = "The name of the database engine to be used for this DB cluster. Valid values: `aurora`, `aurora-mysql`, `aurora-postgresql`"
  default     = "aurora"
}

variable "rds_cluster_engine_version" {
  description = "The engine version to use."
  default     = null
}

variable "rds_cluster_backup_retention_period" {
  description = "The backup retention period (in days)"
  default     = 0
}

variable "rds_cluster_backup_window" {
  description = "The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance_window."
  default     = "09:00-09:30"
}

variable "rds_cluster_skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted. If true is specified, no DBSnapshot is created. If false is specified, a DB snapshot is created before the DB instance is deleted, using the value from final_snapshot_identifier. Default is false."
  default     = false
}

variable "rds_cluster_snapshot_identifier" {
  description = "(Optional) Specifies whether or not to create this cluster from a snapshot. You can use either the name or ARN when specifying a DB cluster snapshot, or the ARN when specifying a DB snapshot."
  default     = ""
}

variable "rds_cluster_final_snapshot_identifier" {
  description = "The name of your final DB snapshot when this DB instance is deleted. If omitted, no final snapshot will be made."
  default     = ""
}

variable "rds_cluster_vpc_security_group_ids" {
  description = "List of VPC security groups to associate."
  default     = []
}

variable "rds_cluster_storage_encrypted" {
  description = "Specifies whether the DB instance is encrypted. The default is false if not specified."
  default     = false
}

variable "rds_cluster_apply_immediately" {
  description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window. Default is false"
  default     = false
}

variable "rds_cluster_availability_zones" {
  description = "Set availability zones for AWS RDS"
  default     = []
}

variable "availability_zones" {
  description = "Availability zones for AWS RDS"
  default = {
    us-east-1      = "us-east-1b,us-east-1a"
    us-east-2      = "us-east-2a,eu-east-2b,eu-east-2c"
    us-west-1      = "us-west-1a,us-west-1c"
    us-west-2      = "us-west-2a,us-west-2b,us-west-2c"
    ca-central-1   = "ca-central-1a,ca-central-1b"
    eu-west-1      = "eu-west-1a,eu-west-1b,eu-west-1c"
    eu-west-2      = "eu-west-2a,eu-west-2b"
    eu-central-1   = "eu-central-1a,eu-central-1b,eu-central-1c"
    ap-south-1     = "ap-south-1a,ap-south-1b"
    sa-east-1      = "sa-east-1a,sa-east-1c"
    ap-northeast-1 = "ap-northeast-1a,ap-northeast-1c"
    ap-southeast-1 = "ap-southeast-1a,ap-southeast-1b"
    ap-southeast-2 = "ap-southeast-2a,ap-southeast-2b,ap-southeast-2c"
    ap-northeast-1 = "ap-northeast-1a,ap-northeast-1c"
    ap-northeast-2 = "ap-northeast-2a,ap-northeast-2c"
  }
}

variable "rds_cluster_database_name" {
  description = "(Optional) Name for an automatically created database on cluster creation. There are different naming restrictions per database engine: RDS Naming Constraints"
  default     = "db_name_test"
}

variable "rds_cluster_backtrack_window" {
  description = "(Optional) The target backtrack window, in seconds. Only available for aurora engine currently. To disable backtracking, set this value to 0. Defaults to 0. Must be between 0 and 259200 (72 hours)"
  default     = 0
}

variable "rds_cluster_replication_source_identifier" {
  description = "(Optional) ARN of a source DB cluster or DB instance if this DB cluster is to be created as a Read Replica."
  default     = null
}

variable "rds_cluster_port" {
  description = "(Optional) The port on which the DB accepts connections"
  default     = null
}

variable "rds_cluster_kms_key_id" {
  description = "(Optional) The ARN for the KMS encryption key. When specifying kms_key_id, storage_encrypted needs to be set to true."
  default     = null
}

variable "rds_cluster_iam_roles" {
  description = "(Optional) A List of ARNs for the IAM roles to associate to the RDS Cluster."
  default     = []
}

variable "rds_cluster_iam_database_authentication_enabled" {
  description = "Specifies whether or mappings of AWS Identity and Access Management (IAM) accounts to database accounts is enabled."
  default     = null
}

variable "rds_cluster_engine_mode" {
  description = "(Optional) The database engine mode. Valid values: global, multimaster, parallelquery, provisioned, serverless. Defaults to: provisioned. See the RDS User Guide for limitations when using serverless."
  default     = "provisioned"
}

variable "rds_cluster_source_region" {
  description = "(Optional) The source region for an encrypted replica DB cluster."
  default     = ""
}

variable "rds_cluster_db_subnet_group_name" {
  description = "(Optional) A DB subnet group to associate with this DB instance. NOTE: This must match the db_subnet_group_name specified on every aws_rds_cluster_instance in the cluster."
  default     = ""
}

variable "rds_cluster_db_cluster_parameter_group_name" {
  description = "(Optional) A cluster parameter group to associate with the cluster."
  default     = ""
}

variable "rds_cluster_preferred_maintenance_window" {
  description = "(Optional) The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00'."
  default     = null
}

variable "rds_cluster_enabled_cloudwatch_logs_exports" {
  description = "(Optional) List of log types to export to cloudwatch. If omitted, no logs will be exported. The following log types are supported: audit, error, general, slowquery, postgresql (PostgreSQL)."
  default     = []
}

variable "rds_cluster_scaling_configuration" {
  description = "(Optional) Nested attribute with scaling properties. Only valid when engine_mode is set to serverless."
  default     = []
}

variable "rds_cluster_enable_http_endpoint" {
  description = "(Optional) Enable HTTP endpoint (data API). Only valid when engine_mode is set to serverless."
  default     = null
}

variable "rds_cluster_s3_import" {
  description = "RDS Aurora Serverless does not support loading data from S3, so its not possible to directly use engine_mode set to serverless with s3_import"
  default     = []
}

variable "rds_cluster_deletion_protection" {
  description = "(Optional) If the DB instance should have deletion protection enabled. The database can't be deleted when this value is set to true. The default is false."
  default     = false
}

variable "rds_cluster_copy_tags_to_snapshot" {
  description = "(Optional, boolean) Copy all Cluster tags to snapshots. Default is false."
  default     = false
}

variable "rds_cluster_timeouts" {
  description = "Set timeouts for rds cluster"
  default     = []
}

#-----------------------------------------------------------
# AWS RDS cluster instance
#-----------------------------------------------------------
variable "enable_rds_cluster_instance" {
  description = "Enable RDS cluster instance usage"
  default     = false
}

variable "number_rds_cluster_instances" {
  description = "Set number of instaneces for RDS cluster"
  default     = 1
}

variable "rds_cluster_instance_identifier" {
  description = "(Optional, Forces new resource) The identifier for the RDS instance, if omitted, Terraform will assign a random, unique identifier."
  default     = ""
}

variable "rds_cluster_instance_identifier_prefix" {
  description = "(Optional, Forces new resource) Creates a unique identifier beginning with the specified prefix. Conflicts with rds_cluster_instance_identifier."
  default     = ""
}

variable "rds_cluster_instance_cluster_identifier" {
  description = "The identifier of the aws_rds_cluster in which to launch this instance."
  default     = ""
}

variable "rds_cluster_instance_instance_class" {
  description = "The instance type of the RDS instance."
  default     = "db.t2.small"
}

variable "rds_cluster_instance_engine" {
  description = "The instance engine name"
  default     = "aurora"
}

variable "rds_cluster_instance_engine_version" {
  description = "The engine version for rds cluster instance."
  default     = null

}

variable "rds_cluster_instance_publicly_accessible" {
  description = "(Optional) Bool to control if instance is publicly accessible. Default false. See the documentation on Creating DB Instances for more details on controlling this property."
  default     = false
}

variable "rds_cluster_instance_db_subnet_group_name" {
  description = "A DB subnet group to associate with this DB instance. NOTE: This must match the db_subnet_group_name of the attached aws_rds_cluster."
  default     = ""
}

variable "rds_cluster_instance_db_parameter_group_name" {
  description = "(Optional) The name of the DB parameter group to associate with this instance."
  default     = null
}

variable "rds_cluster_instance_monitoring_role_arn" {
  description = "(Optional) The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs. You can find more information on the AWS Documentation what IAM permissions are needed to allow Enhanced Monitoring for RDS Instances."
  default     = ""
}

variable "rds_cluster_instance_monitoring_interval" {
  description = "To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60."
  default     = 0
}

variable "rds_cluster_instance_promotion_tier" {
  description = "(Optional) Default 0. Failover Priority setting on instance level. The reader who has lower tier has higher priority to get promoted to writer."
  default     = 0
}

variable "rds_cluster_instance_availability_zone" {
  description = "(Optional, Computed) The EC2 Availability Zone that the DB instance is created in. See docs about the details."
  default     = null
}

variable "rds_cluster_instance_preferred_backup_window" {
  description = "(Optional) The daily time range during which automated backups are created if automated backups are enabled. Eg: '04:00-09:00'"
  default     = null
}

variable "rds_cluster_instance_preferred_maintenance_window" {
  description = "(Optional) The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00'."
  default     = null
}

variable "rds_cluster_instance_apply_immediately" {
  description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window. Default is false"
  default     = false
}

variable "rds_cluster_instance_auto_minor_version_upgrade" {
  description = "Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window. Defaults to true."
  default     = false
}

variable "rds_cluster_instance_performance_insights_enabled" {
  description = "(Optional) Specifies whether Performance Insights is enabled or not."
  default     = null
}

variable "rds_cluster_instance_performance_insights_kms_key_id" {
  description = "(Optional) The ARN for the KMS key to encrypt Performance Insights data. When specifying performance_insights_kms_key_id, performance_insights_enabled needs to be set to true."
  default     = null
}

variable "rds_cluster_instance_copy_tags_to_snapshot" {
  description = "On delete, copy all Instance tags to the final snapshot (if final_snapshot_identifier is specified). Default is false."
  default     = false
}

variable "rds_cluster_instance_ca_cert_identifier" {
  description = "(Optional) The identifier of the CA certificate for the DB instance."
  default     = ""
}

variable "rds_cluster_instance_timeouts" {
  description = "Set timeouts for rds_cluster_instance"
  default     = []
}

#---------------------------------------------------
# AWS RDS global cluster
#---------------------------------------------------
variable "enable_rds_global_cluster" {
  description = "Enable RDS global cluster usage"
  default     = false
}

variable "rds_global_cluster_global_cluster_identifier" {
  description = "The global cluster identifier."
  default     = ""
}

variable "rds_global_cluster_deletion_protection" {
  description = "(Optional) If the Global Cluster should have deletion protection enabled. The database can't be deleted when this value is set to true. The default is false."
  default     = false
}

variable "rds_global_cluster_database_name" {
  description = "(Optional, Forces new resources) Name for an automatically created database on cluster creation."
  default     = null
}

variable "rds_global_cluster_engine" {
  description = "(Optional, Forces new resources) Name of the database engine to be used for this DB cluster. Valid values: aurora, aurora-mysql, aurora-postgresql. Defaults to aurora."
  default     = "aurora"
}

variable "rds_global_cluster_engine_version" {
  description = "(Optional, Forces new resources) Engine version of the Aurora global database. NOTE: When the engine is set to aurora-mysql, an engine version compatible with global database is required. The earliest available version is 5.7.mysql_aurora.2.06.0."
  default     = "5.7.mysql_aurora.2.06.0"
}

variable "rds_global_cluster_storage_encrypted" {
  description = "(Optional, Forces new resources) Specifies whether the DB cluster is encrypted. The default is false."
  default     = false
}

#---------------------------------------------------
# AWS RDS cluster endpoint
#---------------------------------------------------
variable "enable_rds_cluster_endpoint" {
  description = "Enable RDS global endpoint usage"
  default     = false
}

variable "rds_cluster_endpoint_cluster_identifier" {
  description = "The cluster identifier."
  default     = ""
}

variable "rds_cluster_endpoint_cluster_endpoint_identifier" {
  description = "(Required, Forces new resources) The identifier to use for the new endpoint. This parameter is stored as a lowercase string."
  default     = "reader"
}

variable "rds_cluster_endpoint_custom_endpoint_type" {
  description = "(Required) The type of the endpoint. One of: READER , ANY ."
  default     = "READER"
}

variable "rds_cluster_endpoint_excluded_members" {
  description = "(Optional) List of DB instance identifiers that aren't part of the custom endpoint group. All other eligible instances are reachable through the custom endpoint. Only relevant if the list of static members is empty. Conflicts with static_members"
  default     = null
}

variable "rds_cluster_endpoint_static_members" {
  description = "(Optional) List of DB instance identifiers that are part of the custom endpoint group. Conflicts with excluded_members."
  default     = null
}

#---------------------------------------------------
# AWS RDS cluster parameter group
#---------------------------------------------------
variable "enable_rds_cluster_parameter_group" {
  description = "Enable RDS cluster parameter group usage"
  default     = false
}

variable "rds_cluster_parameter_group_name" {
  description = "(Optional, Forces new resource) The name of the DB cluster parameter group. If omitted, Terraform will assign a random, unique name."
  default     = ""
}

variable "rds_cluster_parameter_group_name_prefix" {
  description = "(Optional, Forces new resource) Creates a unique name beginning with the specified prefix. Conflicts with rds_cluster_parameter_group_name"
  default     = ""
}

variable "rds_cluster_parameter_group_family" {
  description = "The family of the DB cluster parameter group."
  default     = ""
}

variable "rds_cluster_parameter_group_description" {
  description = "(Optional) The description of the DB cluster parameter group. Defaults to 'Managed by Terraform'."
  default     = "Managed by Terraform"
}

variable "rds_cluster_parameter_group_parameters" {
  description = "(Optional) A list of DB parameters to apply. Note that parameters may differ from a family to an other. Full list of all parameters can be discovered via aws rds describe-db-cluster-parameters after initial creation of the group."
  default     = []
}

#-----------------------------------------------------------
# AWS DB instance
#-----------------------------------------------------------
variable "enable_db_instance" {
  description = "Enable DB instance usage"
  default     = false
}

variable "number_of_instances" {
  description = "Set number of instances"
  default     = 1
}

variable "db_instance_engine" {
  description = "(Required unless a snapshot_identifier or replicate_source_db is provided) The database engine to use. For supported values, see the Engine parameter in API action CreateDBInstance. Note that for Amazon Aurora instances the engine must match the DB cluster's engine'. For information on the difference between the available Aurora MySQL engines see Comparison between Aurora MySQL 1 and Aurora MySQL 2 in the Amazon RDS User Guide."
  default     = "mysql"
}

variable "db_instance_engine_version" {
  description = "(Optional) The engine version to use. If auto_minor_version_upgrade is enabled, you can provide a prefix of the version such as 5.7 (for 5.7.10) and this attribute will ignore differences in the patch version automatically (e.g. 5.7.17). For supported values, see the EngineVersion parameter in API action CreateDBInstance. Note that for Amazon Aurora instances the engine version must match the DB cluster's engine version'."
  default     = null
}

variable "db_instance_instance_class" {
  description = "(Required) The instance type of the RDS instance."
  default     = "db.t2.small"
}

variable "db_instance_vpc_security_group_ids" {
  description = "(Optional) List of VPC security groups to associate."
  default     = null
}

variable "db_instance_identifier" {
  description = "The name of the RDS instance, if omitted, Terraform will assign a random, unique identifier."
  default     = ""
}

variable "db_instance_identifier_prefix" {
  description = "Creates a unique identifier beginning with the specified prefix. Conflicts with identifer."
  default     = ""
}

variable "db_instance_allocated_storage" {
  description = " (Required unless a snapshot_identifier or replicate_source_db is provided) The allocated storage in gibibytes. If max_allocated_storage is configured, this argument represents the initial storage allocation and differences from the configuration will be ignored automatically when Storage Autoscaling occurs. The allocated storage in gigabytes."
  default     = 20
}

variable "db_instance_storage_type" {
  description = "One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD). The default is 'io1' if iops is specified, 'standard' if not. Note that this behaviour is different from the AWS web console, where the default is 'gp2'."
  default     = null
}

variable "db_instance_iops" {
  description = "The amount of provisioned IOPS. Setting this implies a storage_type of 'io1', default is 0 if rds storage type is not io1"
  default     = null
}

variable "db_instance_db_name" {
  description = "The name of the database to create when the DB instance is created. If this parameter is not specified, no database is created in the DB instance. Note that this does not apply for Oracle or SQL Server engines."
  default     = "db_name_test"
}

variable "db_instance_db_username" {
  description = "Username for the master DB user."
  default     = "root"
}

variable "db_instance_db_password" {
  description = "Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file."
  sensitive   = true
  default     = "ROot666roOT"
  validation {
    condition     = length(var.db_instance_db_password) >= 9
    error_message = "The master password must be more than 9 characters!"
  }
}

variable "db_instance_db_port" {
  description = "(Optional) The port on which the DB accepts connections."
  default     = null
}

variable "default_ports" {
  description = "Default database ports"
  default = {
    aurora            = 3306
    aurora-mysql      = 3306
    aurora-postgresql = 5432
    mariadb           = 3306
    mysql             = 3306
    oracle-se2        = 1521
    oracle-se1        = 1521
    oracle-se         = 1521
    postgres          = 5432
    sqlserver-ee      = 1433
    sqlserver-se      = 1433
    sqlserver-ex      = 1433
    sqlserver-web     = 1433
  }
}

variable "db_group_family" {
  description = "Set DB group family"
  default = {
    aurora            = "aurora5.6"
    aurora-mysql      = "aurora-mysql5.7"
    aurora-postgresql = "aurora-postgres9.6"
    mariadb           = "mariadb"
    mysql             = "mysql5.7"
    oracle-ee         = "oracle-ee-12.1"
    oracle-se2        = "oracle-se2-12.1"
    oracle-se1        = "oracle-se1-12.1"
    oracle-se         = "oracle-ee-12.1"
    postgres          = "postgres9.6"
    sqlserver-ee      = ""
    sqlserver-se      = ""
    sqlserver-ex      = ""
    sqlserver-web     = ""
  }
}

variable "db_instance_character_set_name" {
  description = "The character set name to use for DB encoding in Oracle instances. This can't be changed. For ex: utf8"
  default     = ""
}

variable "db_instance_parameter_group_name" {
  description = "Name of the DB parameter group to associate. For ex: default.mysql5.6"
  default     = ""
}

variable "db_instance_maintenance_window" {
  description = "The daily time range (in UTC) during which maintenance window are enabled. Must not overlap with backup_window. For ex: SUN 12:30AM-01:30AM ET"
  default     = "sun:04:30-sun:05:30"
}

variable "db_instance_replicate_source_db" {
  description = "Specifies that this resource is a Replicate database, and to use this value as the source database. This correlates to the identifier of another Amazon RDS Database to replicate."
  default     = null
}

variable "db_instance_publicly_accessible" {
  description = "(Optional) Bool to control if instance is publicly accessible. Default is false."
  default     = false
}

variable "db_instance_multi_az" {
  description = "If the RDS instance is multi AZ enabled."
  default     = false
}

variable "db_instance_availability_zone" {
  description = "(Optional) The AZ for the RDS instance."
  default     = null
}

variable "db_instance_ca_cert_identifier" {
  description = "(Optional) The identifier of the CA certificate for the DB instance."
  default     = null
}

variable "db_instance_storage_encrypted" {
  description = "(Optional) Specifies whether the DB instance is encrypted. Note that if you are creating a cross-region read replica this field is ignored and you should instead declare kms_key_id with a valid ARN. The default is false if not specified."
  default     = false
}

variable "db_instance_kms_key_id" {
  description = "(Optional) The ARN for the KMS encryption key. If creating an encrypted replica, set this to the destination KMS ARN."
  default     = null
}

variable "db_instance_backup_retention_period" {
  description = "(Optional) The days to retain backups for. Must be between 0 and 35. Must be greater than 0 if the database is used as a source for a Read Replica. See Read Replica."
  default     = null
}

variable "db_instance_backup_window" {
  description = "(Optional) The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance_window."
  default     = null
}

variable "db_instance_copy_tags_to_snapshot" {
  description = "(Optional, boolean) Copy all Instance tags to snapshots. Default is false."
  default     = false
}

variable "db_instance_skip_final_snapshot" {
  description = "(Optional) Determines whether a final DB snapshot is created before the DB instance is deleted. If true is specified, no DBSnapshot is created. If false is specified, a DB snapshot is created before the DB instance is deleted, using the value from final_snapshot_identifier. Default is false."
  default     = false
}

variable "db_instance_snapshot_identifier" {
  description = "(Optional) Specifies whether or not to create this database from a snapshot. This correlates to the snapshot ID you'd find in the RDS console, e.g: rds:production-2015-06-26-06-05."
  default     = null
}

variable "db_instance_final_snapshot_identifier" {
  description = "(Optional) The name of your final DB snapshot when this DB instance is deleted. Must be provided if skip_final_snapshot is set to false."
  default     = null
}

variable "db_instance_apply_immediately" {
  description = "(Optional) Specifies whether any database modifications are applied immediately, or during the next maintenance window. Default is false. See Amazon RDS Documentation for more information."
  default     = false
}

variable "db_instance_deletion_protection" {
  description = "(Optional) If the DB instance should have deletion protection enabled. The database can't be deleted when this value is set to true. The default is false."
  default     = false
}

variable "db_instance_auto_minor_version_upgrade" {
  description = "(Optional) Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window. Defaults to true."
  default     = true
}

variable "db_instance_allow_major_version_upgrade" {
  description = "Indicates that major version upgrades are allowed. Changing this parameter does not result in an outage and the change is asynchronously applied as soon as possible."
  default     = true
}

variable "db_instance_domain" {
  description = "(Optional) The ID of the Directory Service Active Directory domain to create the instance in."
  default     = null
}

variable "db_instance_db_subnet_group_name" {
  description = "(Optional) Name of DB subnet group. DB instance will be created in the VPC associated with the DB subnet group. If unspecified, will be created in the default VPC, or in EC2 Classic, if available. When working with read replicas, it should be specified only if the source database specifies an instance in another AWS Region. See DBSubnetGroupName in API action CreateDBInstanceReadReplica for additional read replica contraints."
  default     = ""
}

variable "db_instance_domain_iam_role_name" {
  description = "(Optional, but required if domain is provided) The name of the IAM role to be used when making API calls to the Directory Service."
  default     = null
}

variable "db_instance_iam_database_authentication_enabled" {
  description = "(Optional) Specifies whether or mappings of AWS Identity and Access Management (IAM) accounts to database accounts is enabled."
  default     = null
}

variable "db_instance_license_model" {
  description = "(Optional, but required for some DB engines, i.e. Oracle SE1) License model information for this DB instance."
  default     = null
}

variable "db_instance_monitoring_interval" {
  description = "(Optional) The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60."
  default     = 0
}

variable "db_instance_monitoring_role_arn" {
  description = "(Optional) The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs. You can find more information on the AWS Documentation what IAM permissions are needed to allow Enhanced Monitoring for RDS Instances."
  default     = null
}

variable "db_instance_enabled_cloudwatch_logs_exports" {
  description = "Optional) List of log types to enable for exporting to CloudWatch logs. If omitted, no logs will be exported. Valid values (depending on engine): agent (MSSQL), alert, audit, error, general, listener, slowquery, trace, postgresql (PostgreSQL), upgrade (PostgreSQL)."
  default     = null
}

variable "db_instance_max_allocated_storage" {
  description = "(Optional) When configured, the upper limit to which Amazon RDS can automatically scale the storage of the DB instance. Configuring this will automatically ignore differences to allocated_storage. Must be greater than or equal to allocated_storage or 0 to disable Storage Autoscaling."
  default     = null
}

variable "db_instance_option_group_name" {
  description = "(Optional) Name of the DB option group to associate."
  default     = ""
}

variable "db_instance_timezone" {
  description = "(Optional) Time zone of the DB instance. timezone is currently only supported by Microsoft SQL Server. The timezone can only be set on creation. See MSSQL User Guide for more information."
  default     = null
}

variable "db_instance_performance_insights_enabled" {
  description = "(Optional) Specifies whether Performance Insights are enabled. Defaults to false."
  default     = false
}

variable "db_instance_performance_insights_kms_key_id" {
  description = "(Optional) The ARN for the KMS key to encrypt Performance Insights data. When specifying performance_insights_kms_key_id, performance_insights_enabled needs to be set to true. Once KMS key is set, it can never be changed."
  default     = null
}

variable "db_instance_performance_insights_retention_period" {
  description = "(Optional) The amount of time in days to retain Performance Insights data. Either 7 (7 days) or 731 (2 years). When specifying performance_insights_retention_period, performance_insights_enabled needs to be set to true. Defaults to '7'."
  default     = 7
}

variable "db_instance_s3_import" {
  description = "Set s3 import settings"
  default     = []
}

variable "db_instance_timeouts" {
  description = "Set timeouts for db instance"
  default     = {}
}

#-----------------------------------------------------------
# AWS DB subnet group
#-----------------------------------------------------------
variable "enable_db_subnet_group" {
  description = "Enable DB subnet group usage"
  default     = false
}

variable "db_subnet_group_name" {
  description = "Name of DB subnet group. DB instance will be created in the VPC associated with the DB subnet group. If unspecified, will be created in the default VPC, or in EC2 Classic, if available."
  default     = ""
}

variable "db_subnet_group_name_prefix" {
  description = "(Optional, Forces new resource) Creates a unique name beginning with the specified prefix. Conflicts with db_subnet_group_name"
  default     = null
}

variable "db_subnet_group_description" {
  description = "(Optional) The description of the DB subnet group. Defaults to 'Managed by Terraform'."
  default     = "Managed by Terraform"
}

variable "db_subnet_group_subnet_ids" {
  description = "subnet IDs"
  default     = []
}

#---------------------------------------------------
# Create AWS DB parameter group
#---------------------------------------------------
variable "enable_db_parameter_group" {
  description = "Enabe DB parameter group usage"
  default     = false
}

variable "db_parameter_group_name" {
  description = "(Optional) The name of the DB parameter group to associate with this instance."
  default     = ""
}

variable "db_parameter_group_name_prefix" {
  description = "(Optional, Forces new resource) Creates a unique name beginning with the specified prefix. Conflicts with db_parameter_group_name"
  default     = ""
}

variable "db_parameter_group_description" {
  description = "(Optional) The description of the DB parameter group. Defaults to 'Managed by Terraform'."
  default     = "Managed by Terraform"
}

variable "db_parameter_group_family" {
  description = "The family of the DB parameter group."
  default     = ""
}

variable "db_parameter_group_parameters" {
  description = "(Optional) A list of DB parameters to apply. Note that parameters may differ from a family to an other. Full list of all parameters can be discovered via aws rds describe-db-parameters after initial creation of the group."
  default     = []
}

#---------------------------------------------------
# AWS DB cluster snapshot
#---------------------------------------------------
variable "enable_db_cluster_snapshot" {
  description = "Enable DB cluster snapshot usage"
  default     = false
}

variable "db_cluster_snapshot_db_cluster_identifier" {
  description = "The DB Cluster Identifier from which to take the snapshot."
  default     = ""
}

variable "db_cluster_snapshot_identifier" {
  description = "(Required) The Identifier for the snapshot."
  default     = ""
}

variable "db_cluster_snapshot_timeouts" {
  description = "Set timeouts for db cluster snapshot"
  default     = {}
}

#---------------------------------------------------
# AWS DB event subscription
#---------------------------------------------------
variable "enable_db_event_subscription" {
  description = "Enable DB event subscription usage"
  default     = false
}

variable "db_event_subscription_name" {
  description = "The name of the DB event subscription. By default generated by Terraform."
  default     = ""
}

variable "db_event_subscription_name_prefix" {
  description = "(Optional) The name of the DB event subscription. Conflicts with db_event_subscription_name"
  default     = ""
}

variable "db_event_subscription_sns_topic" {
  description = "(Required) The SNS topic to send events to."
  default     = ""
}

variable "db_event_subscription_source_type" {
  description = "(Optional) The type of source that will be generating the events. Valid options are db-instance, db-security-group, db-parameter-group, db-snapshot, db-cluster or db-cluster-snapshot. If not set, all sources will be subscribed to."
  default     = ""
}

variable "db_event_subscription_source_ids" {
  description = "(Optional) A list of identifiers of the event sources for which events will be returned. If not specified, then all sources are included in the response. If specified, a source_type must also be specified."
  default     = []
}

variable "db_event_subscription_enabled" {
  description = "(Optional) A boolean flag to enable/disable the subscription. Defaults to true."
  default     = true
}

variable "db_event_subscription_event_categories" {
  description = " (Optional) A list of event categories for a SourceType that you want to subscribe to. See http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_Events.html or run aws rds describe-event-categories."
  default = [
    "availability",
    "deletion",
    "failover",
    "failure",
    "low storage",
    "maintenance",
    "notification",
    "read replica",
    "recovery",
    "restoration",
  ]
}

variable "db_event_subscription_timeouts" {
  description = "Set timeouts for db event subscription"
  default     = {}
}

#---------------------------------------------------
# AWS DB snapshot
#---------------------------------------------------
variable "enable_db_snapshot" {
  description = "Enable DB snapshot usage"
  default     = false
}

variable "db_snapshot_db_instance_identifier" {
  description = "The DB Instance Identifier from which to take the snapshot."
  default     = ""
}

variable "db_snapshot_db_snapshot_identifier" {
  description = "(Required) The Identifier for the snapshot."
  default     = ""
}

#---------------------------------------------------
# AWS DB security group
#---------------------------------------------------
variable "enable_db_security_group" {
  description = "Enable DB SG usage"
  default     = false
}

variable "db_security_group_name" {
  description = "The name of the DB security group."
  default     = ""
}

variable "db_security_group_description" {
  description = "(Optional) The description of the DB security group. Defaults to 'Managed by Terraform'."
  default     = "Managed by Terraform"
}

variable "db_security_group_ingress" {
  description = "(Required) A list of ingress rules."
  default     = []
}

#---------------------------------------------------
# AWS DB instance role association
#---------------------------------------------------
variable "enable_db_instance_role_association" {
  description = "Enable DB instance role association usage"
  default     = false
}

variable "db_instance_role_association_db_instance_identifier" {
  description = "DB Instance Identifier to associate with the IAM Role."
  default     = ""
}

variable "db_instance_role_association_feature_name" {
  description = "(Required) Name of the feature for association. This can be found in the AWS documentation relevant to the integration or a full list is available in the SupportedFeatureNames list returned by AWS CLI rds describe-db-engine-versions."
  default     = "S3_INTEGRATION"
}

variable "db_instance_role_association_role_arn" {
  description = "(Required) Amazon Resource Name (ARN) of the IAM Role to associate with the DB Instance."
  default     = ""
}

#---------------------------------------------------
# AWS DB option group
#---------------------------------------------------
variable "enable_db_option_group" {
  description = "Enable DB option group usage"
  default     = false
}

variable "db_option_group_name" {
  description = "(Optional, Forces new resource) The name of the option group. If omitted, Terraform will assign a random, unique name. Must be lowercase, to match as it is stored in AWS."
  default     = ""
}

variable "db_option_group_name_prefix" {
  description = "Set prefix name for db option group"
  default     = ""
}

variable "db_option_group_option_group_description" {
  description = "(Optional) The description of the option group. Defaults to 'Managed by Terraform'."
  default     = "Managed by Terraform"
}

variable "db_option_group_engine_name" {
  description = "(Required) Specifies the name of the engine that this option group should be associated with. For ex: sqlserver-ee"
  default     = ""
}

variable "db_option_group_major_engine_version" {
  description = "(Required) Specifies the major version of the engine that this option group should be associated with. For ex: 11.00"
  default     = ""
}

variable "db_option_group_timeouts" {
  description = "Set timeouts for db option group"
  default     = {}
}

variable "db_option_group_options" {
  description = "(Optional) A list of Options to apply."
  default     = []
}
