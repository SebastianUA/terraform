# Work with ELASTICACHE via terraform

A terraform module for making ELASTICACHE.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.5.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "default"
}

module "elasticache_single_redis" {
  source = "../../modules/elasticache"

  name        = "single"
  environment = "stage"

  # elasticache security group
  enable_elasticache_security_group               = true
  elasticache_security_group_name                 = ""
  elasticache_security_group_security_group_names = []

  # elasticache subnet group
  enable_elasticache_subnet_group     = true
  elasticache_subnet_group_name       = ""
  elasticache_subnet_group_subnet_ids = []

  # elasticache parameter group
  enable_elasticache_parameter_group = false
  elasticache_parameter_group_name   = "param-group"
  elasticache_parameter_group_parameter = [
    {
      name  = "activerehashing"
      value = "yes"
    }
  ]


  # The single cluster
  enable_elasticache_cluster          = true
  elasticache_cluster_num_cache_nodes = 1
  elasticache_cluster_node_type       = "cache.m3.medium"

  elasticache_replication_group_cluster_mode = []

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}


module "elasticache_single_memcached" {
  source = "../../modules/elasticache"

  name        = "single"
  environment = "stage"

  # elasticache security group
  enable_elasticache_security_group               = false
  elasticache_security_group_name                 = ""
  elasticache_security_group_security_group_names = []

  # elasticache subnet group
  enable_elasticache_subnet_group     = false
  elasticache_subnet_group_name       = ""
  elasticache_subnet_group_subnet_ids = []

  # elasticache parameter group
  enable_elasticache_parameter_group    = false
  elasticache_parameter_group_name      = "param-group"
  elasticache_parameter_group_parameter = []

  # The single cluster
  enable_elasticache_cluster          = true
  elasticache_cluster_num_cache_nodes = 1
  default_engine                      = "memcached"
  elasticache_cluster_engine          = "memcached"
  elasticache_cluster_port            = 11211
  elasticache_cluster_node_type       = "cache.m3.medium"

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
- `default_engine` - Name of the cache engine to be used for this cache cluster. Valid values for this parameter are memcached or redis (`default = redis`)
- `default_engine_version` - (Optional) Version number of the cache engine to be used. The values for default (`default = {'redis': '4.0.10', 'memcached': '1.4.33'}`)
- `default_ports` - Default elasticache ports (`default = {'redis': 6379, 'memcached': 11211}`)
- `default_parameter_group_family` - Set DB group family (`default = {'redis': 'redis4.0', 'memcached': 'memcached1.4'}`)
- `tags` - A list of tag blocks. (`default = {}`)
- `enable_elasticache_subnet_group` - Enable elasticache_subnet_group usage (`default = False`)
- `elasticache_subnet_group_name` - (Required) Name for the cache subnet group. Elasticache converts this name to lowercase. (`default = ""`)
- `elasticache_subnet_group_description` - (Optional) Description for the cache subnet group. Defaults to 'Managed by Terraform'. (`default = ""`)
- `elasticache_subnet_group_subnet_ids` - List of VPC Subnet IDs for the cache subnet group (`default = []`)
- `enable_elasticache_security_group` - Enable elasticache_security_group (`default = False`)
- `elasticache_security_group_name` - Name for the cache security group. This value is stored as a lowercase string. (`default = ""`)
- `elasticache_security_group_description` - (Optional) description for the cache security group. Defaults to 'Managed by Terraform'. (`default = ""`)
- `elasticache_security_group_security_group_names` - (Optional, EC2 Classic only) List of security group names to associate with this cache cluster (`default = []`)
- `enable_elasticache_parameter_group` - If true, will create elasticache parameter group (`default = True`)
- `elasticache_parameter_group_name` - The name of the ElastiCache parameter group. (`default = ""`)
- `elasticache_parameter_group_description` - (Optional) The description of the ElastiCache parameter group. Defaults to 'Managed by Terraform'. (`default = ""`)
- `elasticache_parameter_group_parameter` - List of parameters for custom elasticache parameter group (`default = []`)
- `elasticache_parameter_group_family` - Set parameter group family for elasticache (`default = ""`)
- `enable_elasticache_cluster` - Enable elasticache_cluster usage (`default = False`)
- `elasticache_cluster_name` - (Required) Group identifier. ElastiCache converts this name to lowercase (`default = ""`)
- `elasticache_cluster_replication_group_id` - The replication group to which this cache cluster belongs. (`default = null`)
- `elasticache_cluster_engine` - Name of the cache engine to be used for this cache cluster. Valid values for this parameter are memcached or redis (`default = redis`)
- `elasticache_cluster_engine_version` - (Optional) Version number of the cache engine to be used. See Describe Cache Engine Versions in the AWS Documentation center for supported versions (`default = null`)
- `elasticache_cluster_node_type` - The cluster node type. Ex: cache.t2.micro (`default = cache.t2.micro`)
- `elasticache_cluster_port` - (Optional) The port number on which each of the cache nodes will accept connections. For Memcache the default is 11211, and for Redis the default port is 6379. Cannot be provided with replication_group_id. (`default = null`)
- `elasticache_cluster_num_cache_nodes` - The number of cache nodes that the cache cluster has. Cannot create a Redis cluster with a NumCacheNodes parameter greater than 1. (`default = 1`)
- `elasticache_cluster_subnet_group_name` - (Optional, VPC only) Name of the subnet group to be used for the cache cluster. (`default = null`)
- `elasticache_cluster_security_group_names` - (Optional, EC2 Classic only) List of security group names to associate with this cache cluster (`default = []`)
- `elasticache_cluster_security_group_ids` - (Optional, VPC only) One or more VPC security groups associated with the cache cluster (`default = []`)
- `elasticache_cluster_parameter_group_name` - Name of the parameter group associated with this cache cluster. Ex: default.redis4.0, default.memcached1.4 etc (`default = null`)
- `elasticache_cluster_apply_immediately` - (Optional) Specifies whether any database modifications are applied immediately, or during the next maintenance window. Default is false. See Amazon ElastiCache Documentation for more information. (Available since v0.6.0) (`default = null`)
- `elasticache_cluster_maintenance_window` - Specifies the weekly time range for when maintenance on the cache cluster is performed. The format is ddd:hh24:mi-ddd:hh24:mi (24H Clock UTC). The minimum maintenance window is a 60 minute period. Example: sun:05:00-sun:09:00 (`default = null`)
- `elasticache_cluster_snapshot_window` - The daily time range (in UTC) during which ElastiCache will begin taking a daily snapshot of the cache cluster. Format: hh24:mi-hh24:mi. The minimum snapshot window is a 60 minute period. Example: 05:00-09:00 (`default = null`)
- `elasticache_cluster_snapshot_retention_limit` - The number of days for which ElastiCache will retain automatic cache cluster snapshots before deleting them. For example, if you set SnapshotRetentionLimit to 5, then a snapshot that was taken today will be retained for 5 days before being deleted. If the value of SnapshotRetentionLimit is set to zero (0), backups are turned off. Please note that setting a snapshot_retention_limit is not supported on cache.t1.micro or cache.t2.* cache nodes (`default = null`)
- `elasticache_cluster_snapshot_arns` - (Optional) A single-element string list containing an Amazon Resource Name (ARN) of a Redis RDB snapshot file stored in Amazon S3. Example: arn:aws:s3:::my_bucket/snapshot1.rdb (`default = null`)
- `elasticache_cluster_snapshot_name` - (Optional) The name of a snapshot from which to restore data into the new node group. Changing the snapshot_name forces a new resource. (`default = null`)
- `elasticache_cluster_notification_topic_arn` - An Amazon Resource Name (ARN) of an SNS topic that ElastiCache notifications get sent to. (`default = ""`)
- `elasticache_cluster_availability_zone` - The Availability Zone for the cache cluster. (`default = ""`)
- `elasticache_cluster_az_mode` - (Optional, Memcached only) Specifies whether the nodes in this Memcached node group are created in a single Availability Zone or created across multiple Availability Zones in the cluster's region. Valid values for this parameter are single-az or cross-az, default is single-az. If you want to choose cross-az, num_cache_nodes must be greater than 1 (`default = null`)
- `elasticache_cluster_preferred_availability_zones` - (Optional, Memcached only) A list of the Availability Zones in which cache nodes are created. If you are creating your cluster in an Amazon VPC you can only locate nodes in Availability Zones that are associated with the subnets in the selected subnet group. The number of Availability Zones listed must equal the value of num_cache_nodes. If you want all the nodes in the same Availability Zone, use availability_zone instead, or repeat the Availability Zone multiple times in the list. Default: System chosen Availability Zones. Detecting drift of existing node availability zone is not currently supported. Updating this argument by itself to migrate existing node availability zones is not currently supported and will show a perpetual difference. (`default = null`)
- `elasticache_cluster_final_snapshot_identifier` - (Optional, Redis only) Name of your final cluster snapshot. If omitted, no final snapshot will be made. (`default = null`)
- `elasticache_replication_group` - Enable elasticache_replication_group usage (`default = False`)
- `elasticache_replication_group_description` - Description for replication group (`default = ""`)
- `elasticache_replication_group_replication_group_id` - Set replication group_id for elasticache replication group (`default = ""`)
- `elasticache_replication_group_num_cache_clusters` - (Optional) Number of cache clusters (primary and replicas) this replication group will have. If Multi-AZ is enabled, the value of this parameter must be at least 2. Updates will occur before other modifications. Conflicts with num_node_groups, the deprecatednumber_cache_clusters, or the deprecated cluster_mode. Defaults to 1. (`default = null`)
- `elasticache_replication_group_availability_zones` - (Optional) A list of EC2 availability zones in which the replication group's cache clusters will be created. The order of the availability zones in the list is not important. (`default = []`)
- `elasticache_replication_group_number_cluster_replicas` - Number of cluster replicas which will create (`default = 0`)
- `elasticache_replication_group_automatic_failover_enabled` - Specifies whether a read-only replica will be automatically promoted to read/write primary if the existing primary fails. Defaults to false. (`default = False`)
- `elasticache_replication_group_auto_minor_version_upgrade` - Specifies whether a minor engine upgrades will be applied automatically to the underlying Cache Cluster instances during the maintenance window. Defaults to true. (`default = True`)
- `elasticache_replication_group_at_rest_encryption_enabled` - Whether to enable encryption at rest. (`default = False`)
- `elasticache_replication_group_transit_encryption_enabled` - Whether to enable encryption in transit. (`default = False`)
- `elasticache_replication_group_replicas_per_node_group` - Set number of replicas per node group. (`default = null`)
- `elasticache_replication_group_num_node_groups` - Set number of node groups (`default = null`)
- `elasticache_replication_group_node_type` - The cluster node type. Ex: cache.t2.micro (`default = cache.t2.micro`)
- `elasticache_replication_group_port` - Set port for elasticache replication group (`default = null`)
- `elasticache_replication_group_engine` - Name of the cache engine to be used for this cache cluster. Valid values for this parameter are memcached or redis (`default = redis`)
- `elasticache_replication_group_engine_version` - (Optional) Version number of the cache engine to be used. See Describe Cache Engine Versions in the AWS Documentation center for supported versions (`default = null`)
- `elasticache_replication_group_subnet_group_name` - (Optional, VPC only) Name of the subnet group to be used for the cache cluster. (`default = null`)
- `elasticache_replication_group_security_group_names` - (Optional, EC2 Classic only) List of security group names to associate with this cache cluster (`default = []`)
- `elasticache_replication_group_security_group_ids` - (Optional, VPC only) One or more VPC security groups associated with the cache cluster (`default = []`)
- `elasticache_replication_group_parameter_group_name` - Set parameter group name for elasticache replication group (`default = null`)
- `elasticache_replication_group_maintenance_window` - Specifies the weekly time range for when maintenance on the cache cluster is performed. The format is ddd:hh24:mi-ddd:hh24:mi (24H Clock UTC). The minimum maintenance window is a 60 minute period. Example: sun:05:00-sun:09:00 (`default = null`)
- `elasticache_replication_group_snapshot_window` - The daily time range (in UTC) during which ElastiCache will begin taking a daily snapshot of the cache cluster. Format: hh24:mi-hh24:mi. The minimum snapshot window is a 60 minute period. Example: 05:00-09:00 (`default = null`)
- `elasticache_replication_group_snapshot_retention_limit` - The number of days for which ElastiCache will retain automatic cache cluster snapshots before deleting them. For example, if you set SnapshotRetentionLimit to 5, then a snapshot that was taken today will be retained for 5 days before being deleted. If the value of SnapshotRetentionLimit is set to zero (0), backups are turned off. Please note that setting a snapshot_retention_limit is not supported on cache.t1.micro or cache.t2.* cache nodes (`default = null`)
- `elasticache_replication_group_apply_immediately` - (Optional) Specifies whether any database modifications are applied immediately, or during the next maintenance window. Default is false. See Amazon ElastiCache Documentation for more information. (Available since v0.6.0) (`default = null`)
- `elasticache_replication_group_snapshot_arns` - (Optional) A single-element string list containing an Amazon Resource Name (ARN) of a Redis RDB snapshot file stored in Amazon S3. Example: arn:aws:s3:::my_bucket/snapshot1.rdb (`default = null`)
- `elasticache_replication_group_snapshot_name` - (Optional) The name of a snapshot from which to restore data into the new node group. Changing the snapshot_name forces a new resource. (`default = null`)
- `elasticache_replication_group_auth_token` - The password used to access a password protected server. Can be specified only if transit_encryption_enabled = true. (`default = null`)
- `elasticache_replication_group_notification_topic_arn` - An Amazon Resource Name (ARN) of an SNS topic that ElastiCache notifications get sent to. (`default = null`)
- `elasticache_replication_group_cluster_mode` - (Optional) Create a native redis cluster. automatic_failover_enabled must be set to true. (`default = []`)
- `elasticache_replication_group_kms_key_id` - (Optional) The ARN of the key that you wish to use if encrypting at rest. If not supplied, uses service managed encryption. Can be specified only if at_rest_encryption_enabled = true. (`default = null`)
- `elasticache_replication_group_timeouts` - Set timeouts for elasticache replication group (`default = {}`)
- `elasticache_global_replication_group` - Enable elasticache global replication group usage (`default = False`)
- `elasticache_global_replication_group_global_replication_group_id_suffix` - (Required) The suffix name of a Global Datastore. If global_replication_group_id_suffix is changed, creates a new resource. (`default = null`)
- `elasticache_global_replication_group_primary_replication_group_id` - The ID of the primary cluster that accepts writes and will replicate updates to the secondary cluster. If primary_replication_group_id is changed, creates a new resource. (`default = null`)
- `elasticache_global_replication_group_global_replication_group_description` - (Optional) A user-created description for the global replication group. (`default = null`)
- `elasticache_user` - Enable elasticache user usage (`default = False`)
- `elasticache_user_access_string` - (Required) Access permissions string used for this user. See Specifying Permissions Using an Access String for more details. (`default = null`)
- `elasticache_user_engine` - (Required) The current supported value is REDIS. (`default = null`)
- `elasticache_user_user_id` - (Required) The ID of the user. (`default = null`)
- `elasticache_user_user_name` - (Required) The username of the user. (`default = null`)
- `elasticache_user_passwords` - (Optional) Passwords used for this user. You can create up to two passwords for each user. (`default = null`)
- `elasticache_user_no_password_required` - (Optional) Indicates a password is not required for this user. (`default = null`)
- `elasticache_user_group` - Enable user group usage (`default = False`)
- `elasticache_user_group_engine` - (Required) The current supported value is REDIS. (`default = null`)
- `elasticache_user_group_user_group_id` - The ID of the user group. (`default = ""`)
- `elasticache_user_group_user_ids` - (Optional) The list of user IDs that belong to the user group. (`default = null`)

## Module Output Variables
----------------------
- `elasticache_sg_id` - Get ID of elasticache sg
- `elasticache_subnet_group_id` - Get subnet group ID of elasticache
- `elasticache_parameter_group_name` - Get name of elasticache parameter group
- `elasticache_parameter_group_id` - The ElastiCache parameter group name.
- `elasticache_parameter_group_arn` - The AWS ARN associated with the parameter group.
- `elasticache_cluster_id` - Get elasticache cluster id
- `elasticache_replication_group_id` - Get elasticache replication group id
- `elasticache_global_replication_group_id` - The ID of the ElastiCache Global Replication Group.
- `elasticache_global_replication_group_arn` - The ARN of the ElastiCache Global Replication Group.
- `elasticache_global_replication_group_engine_version_actual` - The full version number of the cache engine running on the members of this global replication group.
- `elasticache_global_replication_group_at_rest_encryption_enabled` - A flag that indicate whether the encryption at rest is enabled.
- `elasticache_global_replication_group_auth_token_enabled` - A flag that indicate whether AuthToken (password) is enabled.
- `elasticache_global_replication_group_cache_node_type` - The instance class used. See AWS documentation for information on supported node types and guidance on selecting node types.
- `elasticache_global_replication_group_cluster_enabled` - Indicates whether the Global Datastore is cluster enabled.
- `elasticache_global_replication_group_engine` - The name of the cache engine to be used for the clusters in this global replication group.
- `elasticache_global_replication_group_global_replication_group_id` - The full ID of the global replication group.
- `elasticache_global_replication_group_transit_encryption_enabled` - A flag that indicates whether the encryption in transit is enabled.
- `elasticache_user_arn` - The ARN of the created ElastiCache User.
- `elasticache_user_group_id` - The user group identifier.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
