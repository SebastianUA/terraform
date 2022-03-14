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

variable "default_engine" {
  description = "Name of the cache engine to be used for this cache cluster. Valid values for this parameter are memcached or redis"
  default     = "redis"
}

variable "default_engine_version" {
  description = "(Optional) Version number of the cache engine to be used. The values for default"
  default = {
    redis     = "4.0.10"
    memcached = "1.4.33"
  }
}

variable "default_ports" {
  description = "Default elasticache ports"
  default = {
    redis     = 6379
    memcached = 11211
  }
}

variable "default_parameter_group_family" {
  description = "Set DB group family"
  default = {
    redis     = "redis4.0"
    memcached = "memcached1.4"
  }
}

variable "tags" {
  description = "A list of tag blocks."
  type        = map(string)
  default     = {}
}

#-----------------------------------------------------------
# AWS elasticache subnet group
#-----------------------------------------------------------
variable "enable_elasticache_subnet_group" {
  description = "Enable elasticache_subnet_group usage"
  default     = false
}

variable "elasticache_subnet_group_name" {
  description = "(Required) Name for the cache subnet group. Elasticache converts this name to lowercase."
  default     = ""
}

variable "elasticache_subnet_group_description" {
  description = "(Optional) Description for the cache subnet group. Defaults to 'Managed by Terraform'."
  default     = ""
}

variable "elasticache_subnet_group_subnet_ids" {
  description = "List of VPC Subnet IDs for the cache subnet group"
  default     = []
}

#-----------------------------------------------------------
# AWS elasticache security group
#-----------------------------------------------------------
variable "enable_elasticache_security_group" {
  description = "Enable elasticache_security_group"
  default     = false
}

variable "elasticache_security_group_name" {
  description = "Name for the cache security group. This value is stored as a lowercase string."
  default     = ""
}

variable "elasticache_security_group_description" {
  description = "(Optional) description for the cache security group. Defaults to 'Managed by Terraform'."
  default     = ""
}

variable "elasticache_security_group_security_group_names" {
  description = "(Optional, EC2 Classic only) List of security group names to associate with this cache cluster"
  default     = []
}

#-----------------------------------------------------------
# AWS elasticache parameter group
#-----------------------------------------------------------
variable "enable_elasticache_parameter_group" {
  description = "If true, will create elasticache parameter group"
  default     = true
}

variable "elasticache_parameter_group_name" {
  description = "The name of the ElastiCache parameter group."
  default     = ""
}

variable "elasticache_parameter_group_description" {
  description = "(Optional) The description of the ElastiCache parameter group. Defaults to 'Managed by Terraform'."
  default     = ""
}

variable "elasticache_parameter_group_parameter" {
  description = "List of parameters for custom elasticache parameter group"
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "elasticache_parameter_group_family" {
  description = "Set parameter group family for elasticache"
  default     = ""
}

#---------------------------------------------------
# AWS elasticache cluster
#---------------------------------------------------
variable "enable_elasticache_cluster" {
  description = "Enable elasticache_cluster usage"
  default     = false
}

variable "elasticache_cluster_name" {
  description = "(Required) Group identifier. ElastiCache converts this name to lowercase"
  default     = ""
}

variable "elasticache_cluster_replication_group_id" {
  description = "The replication group to which this cache cluster belongs."
  default     = null
}

variable "elasticache_cluster_engine" {
  description = "Name of the cache engine to be used for this cache cluster. Valid values for this parameter are memcached or redis"
  default     = "redis"
}

variable "elasticache_cluster_engine_version" {
  description = "(Optional) Version number of the cache engine to be used. See Describe Cache Engine Versions in the AWS Documentation center for supported versions"
  default     = null
}

variable "elasticache_cluster_node_type" {
  description = "The cluster node type. Ex: cache.t2.micro"
  default     = "cache.t2.micro"
}

variable "elasticache_cluster_port" {
  description = "(Optional) The port number on which each of the cache nodes will accept connections. For Memcache the default is 11211, and for Redis the default port is 6379. Cannot be provided with replication_group_id."
  default     = null
}

variable "elasticache_cluster_num_cache_nodes" {
  description = "The number of cache nodes that the cache cluster has. Cannot create a Redis cluster with a NumCacheNodes parameter greater than 1."
  default     = 1
}

variable "elasticache_cluster_subnet_group_name" {
  description = "(Optional, VPC only) Name of the subnet group to be used for the cache cluster."
  default     = null
}

variable "elasticache_cluster_security_group_names" {
  description = "(Optional, EC2 Classic only) List of security group names to associate with this cache cluster"
  default     = []
}

variable "elasticache_cluster_security_group_ids" {
  description = "(Optional, VPC only) One or more VPC security groups associated with the cache cluster"
  default     = []
}

variable "elasticache_cluster_parameter_group_name" {
  description = "Name of the parameter group associated with this cache cluster. Ex: default.redis4.0, default.memcached1.4 etc"
  default     = null
}

variable "elasticache_cluster_apply_immediately" {
  description = "(Optional) Specifies whether any database modifications are applied immediately, or during the next maintenance window. Default is false. See Amazon ElastiCache Documentation for more information. (Available since v0.6.0)"
  default     = null
}

variable "elasticache_cluster_maintenance_window" {
  description = "Specifies the weekly time range for when maintenance on the cache cluster is performed. The format is ddd:hh24:mi-ddd:hh24:mi (24H Clock UTC). The minimum maintenance window is a 60 minute period. Example: sun:05:00-sun:09:00"
  default     = null
}

variable "elasticache_cluster_snapshot_window" {
  description = "The daily time range (in UTC) during which ElastiCache will begin taking a daily snapshot of the cache cluster. Format: hh24:mi-hh24:mi. The minimum snapshot window is a 60 minute period. Example: 05:00-09:00"
  default     = null
}

variable "elasticache_cluster_snapshot_retention_limit" {
  description = "The number of days for which ElastiCache will retain automatic cache cluster snapshots before deleting them. For example, if you set SnapshotRetentionLimit to 5, then a snapshot that was taken today will be retained for 5 days before being deleted. If the value of SnapshotRetentionLimit is set to zero (0), backups are turned off. Please note that setting a snapshot_retention_limit is not supported on cache.t1.micro or cache.t2.* cache nodes"
  default     = null
}

variable "elasticache_cluster_snapshot_arns" {
  description = "(Optional) A single-element string list containing an Amazon Resource Name (ARN) of a Redis RDB snapshot file stored in Amazon S3. Example: arn:aws:s3:::my_bucket/snapshot1.rdb"
  default     = null
}

variable "elasticache_cluster_snapshot_name" {
  description = "(Optional) The name of a snapshot from which to restore data into the new node group. Changing the snapshot_name forces a new resource."
  default     = null
}

variable "elasticache_cluster_notification_topic_arn" {
  description = "An Amazon Resource Name (ARN) of an SNS topic that ElastiCache notifications get sent to."
  default     = ""
}

variable "elasticache_cluster_availability_zone" {
  description = "The Availability Zone for the cache cluster."
  default     = ""
}

variable "elasticache_cluster_az_mode" {
  description = "(Optional, Memcached only) Specifies whether the nodes in this Memcached node group are created in a single Availability Zone or created across multiple Availability Zones in the cluster's region. Valid values for this parameter are single-az or cross-az, default is single-az. If you want to choose cross-az, num_cache_nodes must be greater than 1"
  default     = null
}

variable "elasticache_cluster_preferred_availability_zones" {
  description = "(Optional, Memcached only) A list of the Availability Zones in which cache nodes are created. If you are creating your cluster in an Amazon VPC you can only locate nodes in Availability Zones that are associated with the subnets in the selected subnet group. The number of Availability Zones listed must equal the value of num_cache_nodes. If you want all the nodes in the same Availability Zone, use availability_zone instead, or repeat the Availability Zone multiple times in the list. Default: System chosen Availability Zones. Detecting drift of existing node availability zone is not currently supported. Updating this argument by itself to migrate existing node availability zones is not currently supported and will show a perpetual difference."
  default     = null
}

variable "elasticache_cluster_final_snapshot_identifier" {
  description = "(Optional, Redis only) Name of your final cluster snapshot. If omitted, no final snapshot will be made."
  default     = null
}

#---------------------------------------------------
# AWS elasticache replication group
#---------------------------------------------------
variable "elasticache_replication_group" {
  description = "Enable elasticache_replication_group usage"
  default     = false
}

variable "elasticache_replication_group_description" {
  description = "Description for replication group"
  default     = ""
}

variable "elasticache_replication_group_replication_group_id" {
  description = "Set replication group_id for elasticache replication group"
  default     = ""
}

variable "elasticache_replication_group_num_cache_clusters" {
  description = "(Optional) Number of cache clusters (primary and replicas) this replication group will have. If Multi-AZ is enabled, the value of this parameter must be at least 2. Updates will occur before other modifications. Conflicts with num_node_groups, the deprecatednumber_cache_clusters, or the deprecated cluster_mode. Defaults to 1."
  default     = null
}

variable "elasticache_replication_group_availability_zones" {
  description = "(Optional) A list of EC2 availability zones in which the replication group's cache clusters will be created. The order of the availability zones in the list is not important."
  default     = []
}

variable "elasticache_replication_group_number_cluster_replicas" {
  description = "Number of cluster replicas which will create"
  default     = 0
}

variable "elasticache_replication_group_automatic_failover_enabled" {
  description = "Specifies whether a read-only replica will be automatically promoted to read/write primary if the existing primary fails. Defaults to false."
  default     = false
}

variable "elasticache_replication_group_auto_minor_version_upgrade" {
  description = "Specifies whether a minor engine upgrades will be applied automatically to the underlying Cache Cluster instances during the maintenance window. Defaults to true."
  default     = true
}

variable "elasticache_replication_group_at_rest_encryption_enabled" {
  description = "Whether to enable encryption at rest."
  default     = false
}

variable "elasticache_replication_group_transit_encryption_enabled" {
  description = "Whether to enable encryption in transit."
  default     = false
}

variable "elasticache_replication_group_replicas_per_node_group" {
  description = "Set number of replicas per node group."
  default     = null
}

variable "elasticache_replication_group_num_node_groups" {
  description = "Set number of node groups"
  default     = null
}

#---------------------------------------------------
# elasticache replication group
#---------------------------------------------------
variable "elasticache_replication_group_node_type" {
  description = "The cluster node type. Ex: cache.t2.micro"
  default     = "cache.t2.micro"
}

variable "elasticache_replication_group_port" {
  description = "Set port for elasticache replication group"
  default     = null
}

variable "elasticache_replication_group_engine" {
  description = "Name of the cache engine to be used for this cache cluster. Valid values for this parameter are memcached or redis"
  default     = "redis"
}

variable "elasticache_replication_group_engine_version" {
  description = "(Optional) Version number of the cache engine to be used. See Describe Cache Engine Versions in the AWS Documentation center for supported versions"
  default     = null
}

variable "elasticache_replication_group_subnet_group_name" {
  description = "(Optional, VPC only) Name of the subnet group to be used for the cache cluster."
  default     = null
}

variable "elasticache_replication_group_security_group_names" {
  description = "(Optional, EC2 Classic only) List of security group names to associate with this cache cluster"
  default     = []
}

variable "elasticache_replication_group_security_group_ids" {
  description = "(Optional, VPC only) One or more VPC security groups associated with the cache cluster"
  default     = []
}

variable "elasticache_replication_group_parameter_group_name" {
  description = "Set parameter group name for elasticache replication group"
  default     = null
}

variable "elasticache_replication_group_maintenance_window" {
  description = "Specifies the weekly time range for when maintenance on the cache cluster is performed. The format is ddd:hh24:mi-ddd:hh24:mi (24H Clock UTC). The minimum maintenance window is a 60 minute period. Example: sun:05:00-sun:09:00"
  default     = null
}

variable "elasticache_replication_group_snapshot_window" {
  description = "The daily time range (in UTC) during which ElastiCache will begin taking a daily snapshot of the cache cluster. Format: hh24:mi-hh24:mi. The minimum snapshot window is a 60 minute period. Example: 05:00-09:00"
  default     = null
}

variable "elasticache_replication_group_snapshot_retention_limit" {
  description = "The number of days for which ElastiCache will retain automatic cache cluster snapshots before deleting them. For example, if you set SnapshotRetentionLimit to 5, then a snapshot that was taken today will be retained for 5 days before being deleted. If the value of SnapshotRetentionLimit is set to zero (0), backups are turned off. Please note that setting a snapshot_retention_limit is not supported on cache.t1.micro or cache.t2.* cache nodes"
  default     = null
}

variable "elasticache_replication_group_apply_immediately" {
  description = "(Optional) Specifies whether any database modifications are applied immediately, or during the next maintenance window. Default is false. See Amazon ElastiCache Documentation for more information. (Available since v0.6.0)"
  default     = null
}

variable "elasticache_replication_group_snapshot_arns" {
  description = "(Optional) A single-element string list containing an Amazon Resource Name (ARN) of a Redis RDB snapshot file stored in Amazon S3. Example: arn:aws:s3:::my_bucket/snapshot1.rdb"
  default     = null
}

variable "elasticache_replication_group_snapshot_name" {
  description = "(Optional) The name of a snapshot from which to restore data into the new node group. Changing the snapshot_name forces a new resource."
  default     = null
}

variable "elasticache_replication_group_auth_token" {
  description = "The password used to access a password protected server. Can be specified only if transit_encryption_enabled = true."
  default     = null
}

variable "elasticache_replication_group_notification_topic_arn" {
  description = "An Amazon Resource Name (ARN) of an SNS topic that ElastiCache notifications get sent to."
  default     = null
}

variable "elasticache_replication_group_cluster_mode" {
  description = "(Optional) Create a native redis cluster. automatic_failover_enabled must be set to true."
  default     = []
}

variable "elasticache_replication_group_kms_key_id" {
  description = "(Optional) The ARN of the key that you wish to use if encrypting at rest. If not supplied, uses service managed encryption. Can be specified only if at_rest_encryption_enabled = true."
  default     = null
}

variable "elasticache_replication_group_timeouts" {
  description = "Set timeouts for elasticache replication group"
  default     = {}
}

#---------------------------------------------------
# AWS elasticache global replication group
#---------------------------------------------------
variable "elasticache_global_replication_group" {
  description = "Enable elasticache global replication group usage"
  default     = false
}

variable "elasticache_global_replication_group_global_replication_group_id_suffix" {
  description = "(Required) The suffix name of a Global Datastore. If global_replication_group_id_suffix is changed, creates a new resource."
  default     = null
}

variable "elasticache_global_replication_group_primary_replication_group_id" {
  description = "The ID of the primary cluster that accepts writes and will replicate updates to the secondary cluster. If primary_replication_group_id is changed, creates a new resource."
  default     = null
}

variable "elasticache_global_replication_group_global_replication_group_description" {
  description = "(Optional) A user-created description for the global replication group."
  default     = null
}

#---------------------------------------------------
# AWS elasticache user
#---------------------------------------------------
variable "elasticache_user" {
  description = "Enable elasticache user usage"
  default     = false
}

variable "elasticache_user_access_string" {
  description = "(Required) Access permissions string used for this user. See Specifying Permissions Using an Access String for more details."
  default     = null
}

variable "elasticache_user_engine" {
  description = "(Required) The current supported value is REDIS."
  default     = null
}

variable "elasticache_user_user_id" {
  description = "(Required) The ID of the user."
  default     = null
}

variable "elasticache_user_user_name" {
  description = "(Required) The username of the user."
  default     = null
}

variable "elasticache_user_passwords" {
  description = "(Optional) Passwords used for this user. You can create up to two passwords for each user."
  default     = null
}

variable "elasticache_user_no_password_required" {
  description = "(Optional) Indicates a password is not required for this user."
  default     = null
}

#---------------------------------------------------
# AWS elasticache user group
#---------------------------------------------------
variable "elasticache_user_group" {
  description = "Enable user group usage"
  default     = false
}

variable "elasticache_user_group_engine" {
  description = "(Required) The current supported value is REDIS."
  default     = null
}

variable "elasticache_user_group_user_group_id" {
  description = "The ID of the user group."
  default     = ""
}

variable "elasticache_user_group_user_ids" {
  description = "(Optional) The list of user IDs that belong to the user group."
  default     = null
}