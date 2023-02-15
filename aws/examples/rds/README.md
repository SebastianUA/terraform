# Work with RDS via terraform

A terraform module for making RDS.


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


module "rds_cluster" {
  source = "../../modules/rds"

  name        = "Test"
  region      = "us-east-1"
  environment = "stage"

  enable_rds_cluster_parameter_group = false
  rds_cluster_parameter_group_name   = "rds-cluster-parameter-group-name"
  rds_cluster_parameter_group_parameters = [
    {
      name  = "character_set_server"
      value = "utf8"
    },
    {
      name  = "character_set_client"
      value = "utf8"
    }
  ]

  enable_db_subnet_group     = true
  db_subnet_group_name       = "db_parameter_group_name"
  db_subnet_group_subnet_ids = ["subnet-01e1e21d1f1c0b1fa", "subnet-09d00c1d07ea7b939", "subnet-0503fc0754cf9460e"]

  ## For rds cluster
  enable_rds_cluster             = true
  rds_cluster_cluster_identifier = "rds-mysql"
  rds_cluster_engine             = "aurora"
  rds_cluster_engine_version     = null #"5.7.12"

  rds_cluster_engine_mode = "provisioned"

  enable_rds_cluster_instance         = true
  number_rds_cluster_instances        = 1
  rds_cluster_instance_engine         = "aurora"
  rds_cluster_instance_engine_version = null #"5.7.12" 
  rds_cluster_instance_instance_class = "db.t2.small"


  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

}

# RDS cluster (DB instance - Oracle)
module "db_instance-rds-oracle" {
  source      = "../../modules/rds"
  name        = "rds-oracle"
  environment = "stage"
  region      = "us-east-1"

  # Enable subnet usage
  enable_db_subnet_group     = true
  db_subnet_group_name       = "test-db-instance-rds-oracle-db-subnet-group"
  db_subnet_group_subnet_ids = ["sub-fs432fd", "sub-432dfcxr"]

  # Enable db parameter group
  enable_db_parameter_group     = false
  db_parameter_group_name       = "test-db-instance-rds-oracle-db-param-group"
  db_parameter_group_parameters = []
  db_parameter_group_family     = ""

  # Enable db option group
  enable_db_option_group               = false
  db_option_group_name                 = "test-db-instance-rds-oracle-db-group-name"
  db_option_group_engine_name          = "oracle-ee"
  db_option_group_major_engine_version = "12.1"
  db_option_group_options              = []

  db_instance_multi_az          = false
  db_instance_availability_zone = null

  db_instance_allocated_storage     = 50
  db_instance_max_allocated_storage = null
  db_instance_storage_type          = null #"gp2"
  db_instance_iops                  = null

  db_instance_storage_encrypted = false
  db_instance_kms_key_id        = null


  # Enable db instance
  enable_db_instance     = true
  number_of_instances    = 1
  db_instance_identifier = "test-db-instance-rds-oracle"
  db_instance_engine     = "oracle-se2"
  #db_instance_engine_version                = "12.1"
  db_instance_license_model                = "license-included"
  db_instance_instance_class               = "db.t3.small"
  db_instance_vpc_security_group_ids       = []
  db_instance_performance_insights_enabled = true
  db_instance_skip_final_snapshot          = true


  db_instance_db_name     = "testdb"
  db_instance_db_username = "root"
  db_instance_db_password = "ImPassWorD2020"



  # Enable db instance role association
  enable_db_instance_role_association       = false
  db_instance_role_association_feature_name = ""
  db_instance_role_association_role_arn     = ""

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST-RDS`)
- `region` - The region where to deploy this code (e.g. us-east-1). (`default = us-east-1`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default = {}`)
- `enable_rds_cluster` - If true, then rds cluster will create (`default = False`)
- `rds_cluster_master_username` - (Required unless a snapshot_identifier or global_cluster_identifier is provided) Username for the master DB user. Please refer to the RDS Naming Constraints. This argument does not support in-place updates and cannot be changed during a restore from snapshot. (`default = root`)
- `rds_cluster_master_password` - (Required unless a snapshot_identifier or global_cluster_identifier is provided) Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file. Please refer to the RDS Naming Constraints (`default = ROot666roOT`)
- `rds_cluster_cluster_identifier` - (Optional, Forces new resources) The cluster identifier. If omitted, Terraform will assign a random, unique identifier. (`default = ""`)
- `rds_cluster_cluster_identifier_prefix` - (Optional, Forces new resource) Creates a unique cluster identifier beginning with the specified prefix. Conflicts with cluster_identifier. (`default = ""`)
- `rds_cluster_global_cluster_identifier` - (Optional) The global cluster identifier specified on aws_rds_global_cluster. (`default = ""`)
- `rds_cluster_engine` - The name of the database engine to be used for this DB cluster. Valid values: `aurora`, `aurora-mysql`, `aurora-postgresql` (`default = aurora`)
- `rds_cluster_engine_version` - The engine version to use. (`default = null`)
- `rds_cluster_backup_retention_period` - The backup retention period (in days) (`default = 0`)
- `rds_cluster_backup_window` - The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance_window. (`default = 09:00-09:30`)
- `rds_cluster_skip_final_snapshot` - Determines whether a final DB snapshot is created before the DB instance is deleted. If true is specified, no DBSnapshot is created. If false is specified, a DB snapshot is created before the DB instance is deleted, using the value from final_snapshot_identifier. Default is false. (`default = False`)
- `rds_cluster_snapshot_identifier` - (Optional) Specifies whether or not to create this cluster from a snapshot. You can use either the name or ARN when specifying a DB cluster snapshot, or the ARN when specifying a DB snapshot. (`default = ""`)
- `rds_cluster_final_snapshot_identifier` - The name of your final DB snapshot when this DB instance is deleted. If omitted, no final snapshot will be made. (`default = ""`)
- `rds_cluster_vpc_security_group_ids` - List of VPC security groups to associate. (`default = []`)
- `rds_cluster_storage_encrypted` - Specifies whether the DB instance is encrypted. The default is false if not specified. (`default = False`)
- `rds_cluster_apply_immediately` - Specifies whether any database modifications are applied immediately, or during the next maintenance window. Default is false (`default = False`)
- `rds_cluster_availability_zones` - Set availability zones for AWS RDS (`default = []`)
- `availability_zones` - Availability zones for AWS RDS (`default = {'us-east-1': 'us-east-1b,us-east-1a', 'us-east-2': 'us-east-2a,eu-east-2b,eu-east-2c', 'us-west-1': 'us-west-1a,us-west-1c', 'us-west-2': 'us-west-2a,us-west-2b,us-west-2c', 'ca-central-1': 'ca-central-1a,ca-central-1b', 'eu-west-1': 'eu-west-1a,eu-west-1b,eu-west-1c', 'eu-west-2': 'eu-west-2a,eu-west-2b', 'eu-central-1': 'eu-central-1a,eu-central-1b,eu-central-1c', 'ap-south-1': 'ap-south-1a,ap-south-1b', 'sa-east-1': 'sa-east-1a,sa-east-1c', 'ap-northeast-1': 'ap-northeast-1a,ap-northeast-1c', 'ap-southeast-1': 'ap-southeast-1a,ap-southeast-1b', 'ap-southeast-2': 'ap-southeast-2a,ap-southeast-2b,ap-southeast-2c', 'ap-northeast-2': 'ap-northeast-2a,ap-northeast-2c'}`)
- `rds_cluster_database_name` - (Optional) Name for an automatically created database on cluster creation. There are different naming restrictions per database engine: RDS Naming Constraints (`default = db_name_test`)
- `rds_cluster_backtrack_window` - (Optional) The target backtrack window, in seconds. Only available for aurora engine currently. To disable backtracking, set this value to 0. Defaults to 0. Must be between 0 and 259200 (72 hours) (`default = 0`)
- `rds_cluster_replication_source_identifier` - (Optional) ARN of a source DB cluster or DB instance if this DB cluster is to be created as a Read Replica. (`default = null`)
- `rds_cluster_port` - (Optional) The port on which the DB accepts connections (`default = null`)
- `rds_cluster_kms_key_id` - (Optional) The ARN for the KMS encryption key. When specifying kms_key_id, storage_encrypted needs to be set to true. (`default = null`)
- `rds_cluster_iam_roles` - (Optional) A List of ARNs for the IAM roles to associate to the RDS Cluster. (`default = []`)
- `rds_cluster_iam_database_authentication_enabled` - Specifies whether or mappings of AWS Identity and Access Management (IAM) accounts to database accounts is enabled. (`default = null`)
- `rds_cluster_engine_mode` - (Optional) The database engine mode. Valid values: global, multimaster, parallelquery, provisioned, serverless. Defaults to: provisioned. See the RDS User Guide for limitations when using serverless. (`default = provisioned`)
- `rds_cluster_source_region` - (Optional) The source region for an encrypted replica DB cluster. (`default = ""`)
- `rds_cluster_db_subnet_group_name` - (Optional) A DB subnet group to associate with this DB instance. NOTE: This must match the db_subnet_group_name specified on every aws_rds_cluster_instance in the cluster. (`default = ""`)
- `rds_cluster_db_cluster_parameter_group_name` - (Optional) A cluster parameter group to associate with the cluster. (`default = ""`)
- `rds_cluster_preferred_maintenance_window` - (Optional) The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00'. (`default = null`)
- `rds_cluster_enabled_cloudwatch_logs_exports` - (Optional) List of log types to export to cloudwatch. If omitted, no logs will be exported. The following log types are supported: audit, error, general, slowquery, postgresql (PostgreSQL). (`default = []`)
- `rds_cluster_scaling_configuration` - (Optional) Nested attribute with scaling properties. Only valid when engine_mode is set to serverless. (`default = []`)
- `rds_cluster_enable_http_endpoint` - (Optional) Enable HTTP endpoint (data API). Only valid when engine_mode is set to serverless. (`default = null`)
- `rds_cluster_s3_import` - RDS Aurora Serverless does not support loading data from S3, so its not possible to directly use engine_mode set to serverless with s3_import (`default = []`)
- `rds_cluster_deletion_protection` - (Optional) If the DB instance should have deletion protection enabled. The database can't be deleted when this value is set to true. The default is false. (`default = False`)
- `rds_cluster_copy_tags_to_snapshot` - (Optional, boolean) Copy all Cluster tags to snapshots. Default is false. (`default = False`)
- `rds_cluster_timeouts` - Set timeouts for rds cluster (`default = []`)
- `enable_rds_cluster_instance` - Enable RDS cluster instance usage (`default = False`)
- `number_rds_cluster_instances` - Set number of instaneces for RDS cluster (`default = 1`)
- `rds_cluster_instance_identifier` - (Optional, Forces new resource) The identifier for the RDS instance, if omitted, Terraform will assign a random, unique identifier. (`default = ""`)
- `rds_cluster_instance_identifier_prefix` - (Optional, Forces new resource) Creates a unique identifier beginning with the specified prefix. Conflicts with rds_cluster_instance_identifier. (`default = ""`)
- `rds_cluster_instance_cluster_identifier` - The identifier of the aws_rds_cluster in which to launch this instance. (`default = ""`)
- `rds_cluster_instance_instance_class` - The instance type of the RDS instance. (`default = db.t2.small`)
- `rds_cluster_instance_engine` - The instance engine name (`default = aurora`)
- `rds_cluster_instance_engine_version` - The engine version for rds cluster instance. (`default = null`)
- `rds_cluster_instance_publicly_accessible` - (Optional) Bool to control if instance is publicly accessible. Default false. See the documentation on Creating DB Instances for more details on controlling this property. (`default = False`)
- `rds_cluster_instance_db_subnet_group_name` - A DB subnet group to associate with this DB instance. NOTE: This must match the db_subnet_group_name of the attached aws_rds_cluster. (`default = ""`)
- `rds_cluster_instance_db_parameter_group_name` - (Optional) The name of the DB parameter group to associate with this instance. (`default = null`)
- `rds_cluster_instance_monitoring_role_arn` - (Optional) The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs. You can find more information on the AWS Documentation what IAM permissions are needed to allow Enhanced Monitoring for RDS Instances. (`default = ""`)
- `rds_cluster_instance_monitoring_interval` - To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60. (`default = 0`)
- `rds_cluster_instance_promotion_tier` - (Optional) Default 0. Failover Priority setting on instance level. The reader who has lower tier has higher priority to get promoted to writer. (`default = 0`)
- `rds_cluster_instance_availability_zone` - (Optional, Computed) The EC2 Availability Zone that the DB instance is created in. See docs about the details. (`default = null`)
- `rds_cluster_instance_preferred_backup_window` - (Optional) The daily time range during which automated backups are created if automated backups are enabled. Eg: '04:00-09:00' (`default = null`)
- `rds_cluster_instance_preferred_maintenance_window` - (Optional) The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00'. (`default = null`)
- `rds_cluster_instance_apply_immediately` - Specifies whether any database modifications are applied immediately, or during the next maintenance window. Default is false (`default = False`)
- `rds_cluster_instance_auto_minor_version_upgrade` - Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window. Defaults to true. (`default = False`)
- `rds_cluster_instance_performance_insights_enabled` - (Optional) Specifies whether Performance Insights is enabled or not. (`default = null`)
- `rds_cluster_instance_performance_insights_kms_key_id` - (Optional) The ARN for the KMS key to encrypt Performance Insights data. When specifying performance_insights_kms_key_id, performance_insights_enabled needs to be set to true. (`default = null`)
- `rds_cluster_instance_copy_tags_to_snapshot` - On delete, copy all Instance tags to the final snapshot (if final_snapshot_identifier is specified). Default is false. (`default = False`)
- `rds_cluster_instance_ca_cert_identifier` - (Optional) The identifier of the CA certificate for the DB instance. (`default = ""`)
- `rds_cluster_instance_timeouts` - Set timeouts for rds_cluster_instance (`default = []`)
- `enable_rds_global_cluster` - Enable RDS global cluster usage (`default = False`)
- `rds_global_cluster_global_cluster_identifier` - The global cluster identifier. (`default = ""`)
- `rds_global_cluster_deletion_protection` - (Optional) If the Global Cluster should have deletion protection enabled. The database can't be deleted when this value is set to true. The default is false. (`default = False`)
- `rds_global_cluster_database_name` - (Optional, Forces new resources) Name for an automatically created database on cluster creation. (`default = null`)
- `rds_global_cluster_engine` - (Optional, Forces new resources) Name of the database engine to be used for this DB cluster. Valid values: aurora, aurora-mysql, aurora-postgresql. Defaults to aurora. (`default = aurora`)
- `rds_global_cluster_engine_version` - (Optional, Forces new resources) Engine version of the Aurora global database. NOTE: When the engine is set to aurora-mysql, an engine version compatible with global database is required. The earliest available version is 5.7.mysql_aurora.2.06.0. (`default = 5.7.mysql_aurora.2.06.0`)
- `rds_global_cluster_storage_encrypted` - (Optional, Forces new resources) Specifies whether the DB cluster is encrypted. The default is false. (`default = False`)
- `enable_rds_cluster_endpoint` - Enable RDS global endpoint usage (`default = False`)
- `rds_cluster_endpoint_cluster_identifier` - The cluster identifier. (`default = ""`)
- `rds_cluster_endpoint_cluster_endpoint_identifier` - (Required, Forces new resources) The identifier to use for the new endpoint. This parameter is stored as a lowercase string. (`default = reader`)
- `rds_cluster_endpoint_custom_endpoint_type` - (Required) The type of the endpoint. One of: READER , ANY . (`default = READER`)
- `rds_cluster_endpoint_excluded_members` - (Optional) List of DB instance identifiers that aren't part of the custom endpoint group. All other eligible instances are reachable through the custom endpoint. Only relevant if the list of static members is empty. Conflicts with static_members (`default = null`)
- `rds_cluster_endpoint_static_members` - (Optional) List of DB instance identifiers that are part of the custom endpoint group. Conflicts with excluded_members. (`default = null`)
- `enable_rds_cluster_parameter_group` - Enable RDS cluster parameter group usage (`default = False`)
- `rds_cluster_parameter_group_name` - (Optional, Forces new resource) The name of the DB cluster parameter group. If omitted, Terraform will assign a random, unique name. (`default = ""`)
- `rds_cluster_parameter_group_name_prefix` - (Optional, Forces new resource) Creates a unique name beginning with the specified prefix. Conflicts with rds_cluster_parameter_group_name (`default = ""`)
- `rds_cluster_parameter_group_family` - The family of the DB cluster parameter group. (`default = ""`)
- `rds_cluster_parameter_group_description` - (Optional) The description of the DB cluster parameter group. Defaults to 'Managed by Terraform'. (`default = Managed by Terraform`)
- `rds_cluster_parameter_group_parameters` - (Optional) A list of DB parameters to apply. Note that parameters may differ from a family to an other. Full list of all parameters can be discovered via aws rds describe-db-cluster-parameters after initial creation of the group. (`default = []`)
- `enable_db_instance` - Enable DB instance usage (`default = False`)
- `number_of_instances` - Set number of instances (`default = 1`)
- `db_instance_engine` - (Required unless a snapshot_identifier or replicate_source_db is provided) The database engine to use. For supported values, see the Engine parameter in API action CreateDBInstance. Note that for Amazon Aurora instances the engine must match the DB cluster's engine'. For information on the difference between the available Aurora MySQL engines see Comparison between Aurora MySQL 1 and Aurora MySQL 2 in the Amazon RDS User Guide. (`default = mysql`)
- `db_instance_engine_version` - (Optional) The engine version to use. If auto_minor_version_upgrade is enabled, you can provide a prefix of the version such as 5.7 (for 5.7.10) and this attribute will ignore differences in the patch version automatically (e.g. 5.7.17). For supported values, see the EngineVersion parameter in API action CreateDBInstance. Note that for Amazon Aurora instances the engine version must match the DB cluster's engine version'. (`default = null`)
- `db_instance_instance_class` - (Required) The instance type of the RDS instance. (`default = db.t2.small`)
- `db_instance_vpc_security_group_ids` - (Optional) List of VPC security groups to associate. (`default = null`)
- `db_instance_identifier` - The name of the RDS instance, if omitted, Terraform will assign a random, unique identifier. (`default = ""`)
- `db_instance_identifier_prefix` - Creates a unique identifier beginning with the specified prefix. Conflicts with identifer. (`default = ""`)
- `db_instance_allocated_storage` -  (Required unless a snapshot_identifier or replicate_source_db is provided) The allocated storage in gibibytes. If max_allocated_storage is configured, this argument represents the initial storage allocation and differences from the configuration will be ignored automatically when Storage Autoscaling occurs. The allocated storage in gigabytes. (`default = 20`)
- `db_instance_storage_type` - One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD). The default is 'io1' if iops is specified, 'standard' if not. Note that this behaviour is different from the AWS web console, where the default is 'gp2'. (`default = null`)
- `db_instance_iops` - The amount of provisioned IOPS. Setting this implies a storage_type of 'io1', default is 0 if rds storage type is not io1 (`default = null`)
- `db_instance_db_name` - The name of the database to create when the DB instance is created. If this parameter is not specified, no database is created in the DB instance. Note that this does not apply for Oracle or SQL Server engines. (`default = db_name_test`)
- `db_instance_db_username` - Username for the master DB user. (`default = root`)
- `db_instance_db_password` - Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file. (`default = ROot666roOT`)
- `db_instance_db_port` - (Optional) The port on which the DB accepts connections. (`default = null`)
- `default_ports` - Default database ports (`default = {'aurora': 3306, 'aurora-mysql': 3306, 'aurora-postgresql': 5432, 'mariadb': 3306, 'mysql': 3306, 'oracle-se2': 1521, 'oracle-se1': 1521, 'oracle-se': 1521, 'postgres': 5432, 'sqlserver-ee': 1433, 'sqlserver-se': 1433, 'sqlserver-ex': 1433, 'sqlserver-web': 1433}`)
- `db_group_family` - Set DB group family (`default = {'aurora': 'aurora5.6', 'aurora-mysql': 'aurora-mysql5.7', 'aurora-postgresql': 'aurora-postgres9.6', 'mariadb': 'mariadb', 'mysql': 'mysql5.7', 'oracle-ee': 'oracle-ee-12.1', 'oracle-se2': 'oracle-se2-12.1', 'oracle-se1': 'oracle-se1-12.1', 'oracle-se': 'oracle-ee-12.1', 'postgres': 'postgres9.6', 'sqlserver-ee': '', 'sqlserver-se': '', 'sqlserver-ex': '', 'sqlserver-web': ''}`)
- `db_instance_character_set_name` - The character set name to use for DB encoding in Oracle instances. This can't be changed. For ex: utf8 (`default = ""`)
- `db_instance_parameter_group_name` - Name of the DB parameter group to associate. For ex: default.mysql5.6 (`default = ""`)
- `db_instance_maintenance_window` - The daily time range (in UTC) during which maintenance window are enabled. Must not overlap with backup_window. For ex: SUN 12:30AM-01:30AM ET (`default = sun:04:30-sun:05:30`)
- `db_instance_replicate_source_db` - Specifies that this resource is a Replicate database, and to use this value as the source database. This correlates to the identifier of another Amazon RDS Database to replicate. (`default = null`)
- `db_instance_publicly_accessible` - (Optional) Bool to control if instance is publicly accessible. Default is false. (`default = False`)
- `db_instance_multi_az` - If the RDS instance is multi AZ enabled. (`default = False`)
- `db_instance_availability_zone` - (Optional) The AZ for the RDS instance. (`default = null`)
- `db_instance_ca_cert_identifier` - (Optional) The identifier of the CA certificate for the DB instance. (`default = null`)
- `db_instance_storage_encrypted` - (Optional) Specifies whether the DB instance is encrypted. Note that if you are creating a cross-region read replica this field is ignored and you should instead declare kms_key_id with a valid ARN. The default is false if not specified. (`default = False`)
- `db_instance_kms_key_id` - (Optional) The ARN for the KMS encryption key. If creating an encrypted replica, set this to the destination KMS ARN. (`default = null`)
- `db_instance_backup_retention_period` - (Optional) The days to retain backups for. Must be between 0 and 35. Must be greater than 0 if the database is used as a source for a Read Replica. See Read Replica. (`default = null`)
- `db_instance_backup_window` - (Optional) The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance_window. (`default = null`)
- `db_instance_copy_tags_to_snapshot` - (Optional, boolean) Copy all Instance tags to snapshots. Default is false. (`default = False`)
- `db_instance_skip_final_snapshot` - (Optional) Determines whether a final DB snapshot is created before the DB instance is deleted. If true is specified, no DBSnapshot is created. If false is specified, a DB snapshot is created before the DB instance is deleted, using the value from final_snapshot_identifier. Default is false. (`default = False`)
- `db_instance_snapshot_identifier` - (Optional) Specifies whether or not to create this database from a snapshot. This correlates to the snapshot ID you'd find in the RDS console, e.g: rds:production-2015-06-26-06-05. (`default = null`)
- `db_instance_final_snapshot_identifier` - (Optional) The name of your final DB snapshot when this DB instance is deleted. Must be provided if skip_final_snapshot is set to false. (`default = null`)
- `db_instance_apply_immediately` - (Optional) Specifies whether any database modifications are applied immediately, or during the next maintenance window. Default is false. See Amazon RDS Documentation for more information. (`default = False`)
- `db_instance_deletion_protection` - (Optional) If the DB instance should have deletion protection enabled. The database can't be deleted when this value is set to true. The default is false. (`default = False`)
- `db_instance_auto_minor_version_upgrade` - (Optional) Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window. Defaults to true. (`default = True`)
- `db_instance_allow_major_version_upgrade` - Indicates that major version upgrades are allowed. Changing this parameter does not result in an outage and the change is asynchronously applied as soon as possible. (`default = True`)
- `db_instance_domain` - (Optional) The ID of the Directory Service Active Directory domain to create the instance in. (`default = null`)
- `db_instance_db_subnet_group_name` - (Optional) Name of DB subnet group. DB instance will be created in the VPC associated with the DB subnet group. If unspecified, will be created in the default VPC, or in EC2 Classic, if available. When working with read replicas, it should be specified only if the source database specifies an instance in another AWS Region. See DBSubnetGroupName in API action CreateDBInstanceReadReplica for additional read replica contraints. (`default = ""`)
- `db_instance_domain_iam_role_name` - (Optional, but required if domain is provided) The name of the IAM role to be used when making API calls to the Directory Service. (`default = null`)
- `db_instance_iam_database_authentication_enabled` - (Optional) Specifies whether or mappings of AWS Identity and Access Management (IAM) accounts to database accounts is enabled. (`default = null`)
- `db_instance_license_model` - (Optional, but required for some DB engines, i.e. Oracle SE1) License model information for this DB instance. (`default = null`)
- `db_instance_monitoring_interval` - (Optional) The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60. (`default = 0`)
- `db_instance_monitoring_role_arn` - (Optional) The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs. You can find more information on the AWS Documentation what IAM permissions are needed to allow Enhanced Monitoring for RDS Instances. (`default = null`)
- `db_instance_enabled_cloudwatch_logs_exports` - Optional) List of log types to enable for exporting to CloudWatch logs. If omitted, no logs will be exported. Valid values (depending on engine): agent (MSSQL), alert, audit, error, general, listener, slowquery, trace, postgresql (PostgreSQL), upgrade (PostgreSQL). (`default = null`)
- `db_instance_max_allocated_storage` - (Optional) When configured, the upper limit to which Amazon RDS can automatically scale the storage of the DB instance. Configuring this will automatically ignore differences to allocated_storage. Must be greater than or equal to allocated_storage or 0 to disable Storage Autoscaling. (`default = null`)
- `db_instance_option_group_name` - (Optional) Name of the DB option group to associate. (`default = ""`)
- `db_instance_timezone` - (Optional) Time zone of the DB instance. timezone is currently only supported by Microsoft SQL Server. The timezone can only be set on creation. See MSSQL User Guide for more information. (`default = null`)
- `db_instance_performance_insights_enabled` - (Optional) Specifies whether Performance Insights are enabled. Defaults to false. (`default = False`)
- `db_instance_performance_insights_kms_key_id` - (Optional) The ARN for the KMS key to encrypt Performance Insights data. When specifying performance_insights_kms_key_id, performance_insights_enabled needs to be set to true. Once KMS key is set, it can never be changed. (`default = null`)
- `db_instance_performance_insights_retention_period` - (Optional) The amount of time in days to retain Performance Insights data. Either 7 (7 days) or 731 (2 years). When specifying performance_insights_retention_period, performance_insights_enabled needs to be set to true. Defaults to '7'. (`default = 7`)
- `db_instance_s3_import` - Set s3 import settings (`default = []`)
- `db_instance_timeouts` - Set timeouts for db instance (`default = {}`)
- `enable_db_subnet_group` - Enable DB subnet group usage (`default = False`)
- `db_subnet_group_name` - Name of DB subnet group. DB instance will be created in the VPC associated with the DB subnet group. If unspecified, will be created in the default VPC, or in EC2 Classic, if available. (`default = ""`)
- `db_subnet_group_name_prefix` - (Optional, Forces new resource) Creates a unique name beginning with the specified prefix. Conflicts with db_subnet_group_name (`default = null`)
- `db_subnet_group_description` - (Optional) The description of the DB subnet group. Defaults to 'Managed by Terraform'. (`default = Managed by Terraform`)
- `db_subnet_group_subnet_ids` - subnet IDs (`default = []`)
- `enable_db_parameter_group` - Enabe DB parameter group usage (`default = False`)
- `db_parameter_group_name` - (Optional) The name of the DB parameter group to associate with this instance. (`default = ""`)
- `db_parameter_group_name_prefix` - (Optional, Forces new resource) Creates a unique name beginning with the specified prefix. Conflicts with db_parameter_group_name (`default = ""`)
- `db_parameter_group_description` - (Optional) The description of the DB parameter group. Defaults to 'Managed by Terraform'. (`default = Managed by Terraform`)
- `db_parameter_group_family` - The family of the DB parameter group. (`default = ""`)
- `db_parameter_group_parameters` - (Optional) A list of DB parameters to apply. Note that parameters may differ from a family to an other. Full list of all parameters can be discovered via aws rds describe-db-parameters after initial creation of the group. (`default = []`)
- `enable_db_cluster_snapshot` - Enable DB cluster snapshot usage (`default = False`)
- `db_cluster_snapshot_db_cluster_identifier` - The DB Cluster Identifier from which to take the snapshot. (`default = ""`)
- `db_cluster_snapshot_identifier` - (Required) The Identifier for the snapshot. (`default = ""`)
- `db_cluster_snapshot_timeouts` - Set timeouts for db cluster snapshot (`default = {}`)
- `enable_db_event_subscription` - Enable DB event subscription usage (`default = False`)
- `db_event_subscription_name` - The name of the DB event subscription. By default generated by Terraform. (`default = ""`)
- `db_event_subscription_name_prefix` - (Optional) The name of the DB event subscription. Conflicts with db_event_subscription_name (`default = ""`)
- `db_event_subscription_sns_topic` - (Required) The SNS topic to send events to. (`default = ""`)
- `db_event_subscription_source_type` - (Optional) The type of source that will be generating the events. Valid options are db-instance, db-security-group, db-parameter-group, db-snapshot, db-cluster or db-cluster-snapshot. If not set, all sources will be subscribed to. (`default = ""`)
- `db_event_subscription_source_ids` - (Optional) A list of identifiers of the event sources for which events will be returned. If not specified, then all sources are included in the response. If specified, a source_type must also be specified. (`default = []`)
- `db_event_subscription_enabled` - (Optional) A boolean flag to enable/disable the subscription. Defaults to true. (`default = True`)
- `db_event_subscription_event_categories` -  (Optional) A list of event categories for a SourceType that you want to subscribe to. See http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_Events.html or run aws rds describe-event-categories. (`default = ['availability', 'deletion', 'failover', 'failure', 'low storage', 'maintenance', 'notification', 'read replica', 'recovery', 'restoration']`)
- `db_event_subscription_timeouts` - Set timeouts for db event subscription (`default = {}`)
- `enable_db_snapshot` - Enable DB snapshot usage (`default = False`)
- `db_snapshot_db_instance_identifier` - The DB Instance Identifier from which to take the snapshot. (`default = ""`)
- `db_snapshot_db_snapshot_identifier` - (Required) The Identifier for the snapshot. (`default = ""`)
- `enable_db_security_group` - Enable DB SG usage (`default = False`)
- `db_security_group_name` - The name of the DB security group. (`default = ""`)
- `db_security_group_description` - (Optional) The description of the DB security group. Defaults to 'Managed by Terraform'. (`default = Managed by Terraform`)
- `db_security_group_ingress` - (Required) A list of ingress rules. (`default = []`)
- `enable_db_instance_role_association` - Enable DB instance role association usage (`default = False`)
- `db_instance_role_association_db_instance_identifier` - DB Instance Identifier to associate with the IAM Role. (`default = ""`)
- `db_instance_role_association_feature_name` - (Required) Name of the feature for association. This can be found in the AWS documentation relevant to the integration or a full list is available in the SupportedFeatureNames list returned by AWS CLI rds describe-db-engine-versions. (`default = S3_INTEGRATION`)
- `db_instance_role_association_role_arn` - (Required) Amazon Resource Name (ARN) of the IAM Role to associate with the DB Instance. (`default = ""`)
- `enable_db_option_group` - Enable DB option group usage (`default = False`)
- `db_option_group_name` - (Optional, Forces new resource) The name of the option group. If omitted, Terraform will assign a random, unique name. Must be lowercase, to match as it is stored in AWS. (`default = ""`)
- `db_option_group_name_prefix` - Set prefix name for db option group (`default = ""`)
- `db_option_group_option_group_description` - (Optional) The description of the option group. Defaults to 'Managed by Terraform'. (`default = Managed by Terraform`)
- `db_option_group_engine_name` - (Required) Specifies the name of the engine that this option group should be associated with. For ex: sqlserver-ee (`default = ""`)
- `db_option_group_major_engine_version` - (Required) Specifies the major version of the engine that this option group should be associated with. For ex: 11.00 (`default = ""`)
- `db_option_group_timeouts` - Set timeouts for db option group (`default = {}`)
- `db_option_group_options` - (Optional) A list of Options to apply. (`default = []`)

## Module Output Variables
----------------------
- `rds_cluster_reader_endpoint` - A read-only endpoint for the Aurora cluster, automatically load-balanced across replicas
- `rds_cluster_endpoint` - The DNS address of the RDS instance
- `rds_cluster_arn` - Amazon Resource Name (ARN) of cluster
- `rds_cluster_id` - The RDS Cluster Identifier
- `rds_global_cluster_arn` - RDS Global Cluster Amazon Resource Name (ARN)
- `rds_global_cluster_global_cluster_resource_id` - AWS Region-unique, immutable identifier for the global database cluster. This identifier is found in AWS CloudTrail log entries whenever the AWS KMS key for the DB cluster is accessed
- `rds_global_cluster_id` - RDS Global Cluster identifier
- `rds_cluster_endpoint_arn` - Amazon Resource Name (ARN) of cluster
- `rds_cluster_endpoint_id` - The RDS Cluster Endpoint Identifier
- `rds_cluster_endpoint_endpoint` - A custom endpoint for the Aurora cluster
- `rds_cluster_parameter_group_arn` - The ARN of the db cluster parameter group.
- `rds_cluster_parameter_group_id` - The db cluster parameter group name.
- `db_instance_id` - ""
- `db_instance_arn` - ""
- `db_instance_addresses` - ""
- `db_instance_hosted_zone_id` - Get DB instance hosted zone ID
- `db_instance_endpoint` - Get DB instance hosted zone ID
- `aws_db_subnet_group_id` - Get DB subnet group ID
- `db_parameter_group_id` - Get DB parameter group ID
- `db_cluster_snapshot_id` - Get DB cluster snapshot ID
- `db_event_subscription_id` - The name of the RDS event notification subscription
- `db_event_subscription_arn` - The Amazon Resource Name of the RDS event notification subscription
- `db_event_subscription_customer_aws_id` - The AWS customer account associated with the RDS event notification subscription
- `db_snapshot_id` - Get DB snapshot ID
- `db_security_group_id` - The db security group ID.
- `db_security_group_arn` - The arn of the DB security group.
- `db_instance_role_association_id` - ""
- `db_option_group_id` - The db option group name.
- `db_option_group_arn` - The ARN of the db option group.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
