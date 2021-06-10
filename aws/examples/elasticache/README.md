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
}

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
  profile                 = "default"
}

module "elasticache_single_redis" {
  source      = "../../modules/elasticache"
  name        = "single"
  environment = "stage"

  enable_elasticache_security_group = false
  elasticache_security_group_name   = ""
  security_group_names              = []
  enable_elasticache_subnet_group   = false
  elasticache_subnet_group_name     = ""
  subnet_ids                        = []

  #
  enable_elasticache_parameter_group = false
  parameter = [
    {
      name  = "activerehashing"
      value = "yes"
    },
  ]
  # Or, use already created parameter_group
  #parameter_group_name                    = {
  #        memcached   = "default.memcached1.4",
  #        redis       = "default.redis4.0"
  #    }
  engine = "redis"

  # The single cluster
  enable_elasticache_cluster = true
  num_cache_nodes            = 1
  node_type                  = "cache.m3.medium"

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}

module "elasticache_single_memcached" {
  source      = "../../modules/elasticache"
  name        = "single"
  environment = "stage"

  enable_elasticache_security_group = false
  elasticache_security_group_name   = ""
  security_group_names              = []
  enable_elasticache_subnet_group   = false
  elasticache_subnet_group_name     = ""
  subnet_ids                        = []

  #
  enable_elasticache_parameter_group = false
  parameter = [
    {
      name  = "disable_flush_all"
      value = 0
    },
    {
      name  = "idle_timeout"
      value = 0
    },
  ]
  engine = "memcached"

  # The single cluster
  enable_elasticache_cluster = true
  num_cache_nodes            = 1
  node_type                  = "cache.m3.medium"

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
- `tags` - A list of tag blocks. (`default = {}`)
- `enable_elasticache_subnet_group` - Enable elasticache_subnet_group usage (`default = False`)
- `elasticache_subnet_group_name` - (Required) Name for the cache subnet group. Elasticache converts this name to lowercase. (`default = ""`)
- `elasticache_subnet_group_description` - (Optional) Description for the cache subnet group. Defaults to 'Managed by Terraform'. (`default = ""`)
- `subnet_ids` - List of VPC Subnet IDs for the cache subnet group (`default = []`)
- `enable_elasticache_security_group` - Enable elasticache_security_group (`default = False`)
- `elasticache_security_group_name` - Name for the cache security group. This value is stored as a lowercase string. (`default = ""`)
- `elasticache_security_group_description` - (Optional) description for the cache security group. Defaults to 'Managed by Terraform'. (`default = ""`)
- `enable_elasticache_parameter_group` - If true, will create elasticache parameter group (`default = True`)
- `elasticache_parameter_group_name` - The name of the ElastiCache parameter group. (`default = ""`)
- `elasticache_parameter_group_description` - (Optional) The description of the ElastiCache parameter group. Defaults to 'Managed by Terraform'. (`default = ""`)
- `parameter` - List of parameters for custom elasticache parameter group (`default = []`)
- `elasticache_parameter_group_family` - Set DB group family (`default = {'redis': 'redis4.0', 'memcached': 'memcached1.4'}`)
- `enable_elasticache_cluster` - Enable elasticache_cluster usage (`default = False`)
- `elasticache_cluster_name` - (Required) Group identifier. ElastiCache converts this name to lowercase (`default = ""`)
- `replication_group_id` - The replication group to which this cache cluster belongs. (`default = null`)
- `number_cache_clusters` - (Required for Cluster Mode Disabled) The number of cache clusters (primary and replicas) this replication group will have. If Multi-AZ is enabled, the value of this parameter must be at least 2. Updates will occur before other modifications. (`default = null`)
- `engine` - Name of the cache engine to be used for this cache cluster. Valid values for this parameter are memcached or redis (`default = redis`)
- `engine_version` - (Optional) Version number of the cache engine to be used. See Describe Cache Engine Versions in the AWS Documentation center for supported versions (`default = ""`)
- `engine_version_default` - (Optional) Version number of the cache engine to be used. The values for default (`default = {'redis': '4.0.10', 'memcached': '1.4.33'}`)
- `node_type` - The cluster node type. Ex: cache.t2.micro (`default = cache.t2.micro`)
- `elasticache_cluster_port` - (Optional) The port number on which each of the cache nodes will accept connections. For Memcache the default is 11211, and for Redis the default port is 6379. Cannot be provided with replication_group_id. (`default = null`)
- `default_ports` - Default elasticache ports (`default = {'redis': 6379, 'memcached': 11211}`)
- `num_cache_nodes` - The number of cache nodes that the cache cluster has.  Cannot create a Redis cluster with a NumCacheNodes parameter greater than 1. (`default = 1`)
- `subnet_group_name` - (Optional, VPC only) Name of the subnet group to be used for the cache cluster. (`default = ""`)
- `security_group_names` - (Optional, EC2 Classic only) List of security group names to associate with this cache cluster (`default = []`)
- `security_group_ids` - (Optional, VPC only) One or more VPC security groups associated with the cache cluster (`default = []`)
- `parameter_group_name` - Name of the parameter group associated with this cache cluster. Ex: default.redis4.0, default.memcached1.4 etc (`default = {'redis': '', 'memcached': ''}`)
- `apply_immediately` - (Optional) Specifies whether any database modifications are applied immediately, or during the next maintenance window. Default is false. See Amazon ElastiCache Documentation for more information. (Available since v0.6.0) (`default = False`)
- `maintenance_window` - Specifies the weekly time range for when maintenance on the cache cluster is performed. The format is ddd:hh24:mi-ddd:hh24:mi (24H Clock UTC). The minimum maintenance window is a 60 minute period. Example: sun:05:00-sun:09:00 (`default = sun:05:00-sun:09:00`)
- `snapshot_window` - The daily time range (in UTC) during which ElastiCache will begin taking a daily snapshot of the cache cluster. Format: hh24:mi-hh24:mi. The minimum snapshot window is a 60 minute period. Example: 05:00-09:00 (`default = null`)
- `snapshot_retention_limit` - The number of days for which ElastiCache will retain automatic cache cluster snapshots before deleting them. For example, if you set SnapshotRetentionLimit to 5, then a snapshot that was taken today will be retained for 5 days before being deleted. If the value of SnapshotRetentionLimit is set to zero (0), backups are turned off. Please note that setting a snapshot_retention_limit is not supported on cache.t1.micro or cache.t2.* cache nodes (`default = null`)
- `snapshot_arns` - (Optional) A single-element string list containing an Amazon Resource Name (ARN) of a Redis RDB snapshot file stored in Amazon S3. Example: arn:aws:s3:::my_bucket/snapshot1.rdb (`default = null`)
- `snapshot_name` - (Optional) The name of a snapshot from which to restore data into the new node group. Changing the snapshot_name forces a new resource. (`default = null`)
- `notification_topic_arn` - An Amazon Resource Name (ARN) of an SNS topic that ElastiCache notifications get sent to. (`default = ""`)
- `availability_zone` - The Availability Zone for the cache cluster. (`default = ""`)
- `az_mode` - (Optional, Memcached only) Specifies whether the nodes in this Memcached node group are created in a single Availability Zone or created across multiple Availability Zones in the cluster's region. Valid values for this parameter are single-az or cross-az, default is single-az. If you want to choose cross-az, num_cache_nodes must be greater than 1 (`default = null`)
- `preferred_availability_zones` - (Optional, Memcached only) A list of the Availability Zones in which cache nodes are created. If you are creating your cluster in an Amazon VPC you can only locate nodes in Availability Zones that are associated with the subnets in the selected subnet group. The number of Availability Zones listed must equal the value of num_cache_nodes. If you want all the nodes in the same Availability Zone, use availability_zone instead, or repeat the Availability Zone multiple times in the list. Default: System chosen Availability Zones. Detecting drift of existing node availability zone is not currently supported. Updating this argument by itself to migrate existing node availability zones is not currently supported and will show a perpetual difference. (`default = null`)
- `elasticache_replication_group` - Enable elasticache_replication_group usage (`default = False`)
- `replication_group_description` - Description for replication_group (`default = ""`)
- `availability_zones` - (Optional) A list of EC2 availability zones in which the replication group's cache clusters will be created. The order of the availability zones in the list is not important. (`default = []`)
- `number_cluster_replicas` - Number of cluster replicas which will create (`default = 0`)
- `automatic_failover_enabled` - Specifies whether a read-only replica will be automatically promoted to read/write primary if the existing primary fails. Defaults to false. (`default = False`)
- `auto_minor_version_upgrade` - Specifies whether a minor engine upgrades will be applied automatically to the underlying Cache Cluster instances during the maintenance window. Defaults to true. (`default = True`)
- `at_rest_encryption_enabled` - Whether to enable encryption at rest. (`default = False`)
- `transit_encryption_enabled` - Whether to enable encryption in transit. (`default = False`)
- `auth_token` - The password used to access a password protected server. Can be specified only if transit_encryption_enabled = true. (`default = null`)
- `cluster_mode` - (Optional) Create a native redis cluster. automatic_failover_enabled must be set to true. (`default = []`)
- `kms_key_id` - (Optional) The ARN of the key that you wish to use if encrypting at rest. If not supplied, uses service managed encryption. Can be specified only if at_rest_encryption_enabled = true. (`default = null`)
- `elasticache_replication_group_timeouts` - Set timeouts for elasticache replication group (`default = []`)

## Module Output Variables
----------------------
- `elasticache_sg_id` - Get ID of elasticache sg
- `elasticache_subnet_group_id` - Get subnet group ID of elasticache
- `elasticache_parameter_group_name` - Get name of elasticache parameter group
- `elasticache_cluster_id` - Get elasticache cluster id
- `elasticache_replication_group_id` - Get elasticache replication group id


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
