#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST-elasticache"
}

variable "region" {
  description = "The region where to deploy this code (e.g. us-east-1)."
  default     = "us-east-1"
} 

variable "environment" {
    description = "Environment for service"
    default     = "STAGE"
}

variable "orchestration" {
    description = "Type of orchestration"
    default     = "Terraform"
}

variable "createdby" {
    description = "Created by"
    default     = "Vitaliy Natarov"
}

variable "tags" {
    description = "A list of tag blocks. Each element should have keys named key, value, and propagate_at_launch."
    type        = map(string)
    default     = {}
}

#-----------------------------------------------------------
# AWS elasticache subnet group
#-----------------------------------------------------------
variable "enable_elasticache_subnet_group" {
  description   = "Enable elasticache_subnet_group usage"
  default       = false
}

variable "elasticache_subnet_group_name" {
  description   = "(Required) Name for the cache subnet group. Elasticache converts this name to lowercase."
  default       = ""
}

variable "elasticache_subnet_group_description" {
  description   = "(Optional) Description for the cache subnet group. Defaults to 'Managed by Terraform'."
  default       = ""
}

variable "subnet_ids" {
    description = "List of VPC Subnet IDs for the cache subnet group"
    default     = []
}

#-----------------------------------------------------------
# AWS elasticache security group
#-----------------------------------------------------------
variable "enable_elasticache_security_group" {
  description   = "Enable elasticache_security_group"
  default       = false
}

variable "elasticache_security_group_name" {
  description   = "Name for the cache security group. This value is stored as a lowercase string."
  default       = ""
}

variable "elasticache_security_group_description" {
  description   = "(Optional) description for the cache security group. Defaults to 'Managed by Terraform'."
  default       = ""
}

#-----------------------------------------------------------
# parameters_for_parameter_group 
#-----------------------------------------------------------
variable "enable_elasticache_parameter_group" {
    description = "If true, will create elasticache parameter group"
    default     = true
}

variable "elasticache_parameter_group_name" {
  description   = "The name of the ElastiCache parameter group."
  default       = ""
}

variable "elasticache_parameter_group_description" {
  description   = "(Optional) The description of the ElastiCache parameter group. Defaults to 'Managed by Terraform'."
  default       = ""
}

variable "parameter" {
    description = "List of parameters for custom elasticache parameter group"
    type = list(object({
        name  = string
        value = string
    }))
    default     = []
}

variable "elasticache_parameter_group_family" {
    description = "Set DB group family"
    default     = {
        redis       = "redis4.0"
        memcached   = "memcached1.4"
    }           
}

#---------------------------------------------------
# Create AWS elasticache cluster
#---------------------------------------------------
variable "enable_elasticache_cluster" {
  description   = "Enable elasticache_cluster usage"
  default       = false
}

variable "elasticache_cluster_name" {
  description   = "(Required) Group identifier. ElastiCache converts this name to lowercase"
  default       = ""
}

variable "replication_group_id" {
    description = "The replication group to which this cache cluster belongs."
    default     = null
}

variable "engine" {
    description = "Name of the cache engine to be used for this cache cluster. Valid values for this parameter are memcached or redis"
    default     = "redis"
}

variable "engine_version" {
    description = "(Optional) Version number of the cache engine to be used. See Describe Cache Engine Versions in the AWS Documentation center for supported versions"
    default     = ""
}

variable "engine_version_default" {
    description = "(Optional) Version number of the cache engine to be used. The values for default"
    default     = {
        redis       = "4.0.10"
        memcached   = "1.4.33"
    }
}

variable "node_type" {
    description = "The cluster node type. Ex: cache.t2.micro"
    default     = "cache.t2.micro"
}

variable "elasticache_cluster_port" {
  description   = "(Optional) The port number on which each of the cache nodes will accept connections. For Memcache the default is 11211, and for Redis the default port is 6379. Cannot be provided with replication_group_id."
  default       = null
}

variable "default_ports" {
    description = "Default elasticache ports"
    default     = {
        redis       = 6379
        memcached   = 11211
    }
}

variable "num_cache_nodes" {
    description = "The number of cache nodes that the cache cluster has.  Cannot create a Redis cluster with a NumCacheNodes parameter greater than 1."
    default     = 1
}

variable "subnet_group_name" {
  description   = "(Optional, VPC only) Name of the subnet group to be used for the cache cluster."
  default       = ""
}

variable "security_group_names" {
  description = "(Optional, EC2 Classic only) List of security group names to associate with this cache cluster"
  default     = []
}

variable "security_group_ids" {
    description = "(Optional, VPC only) One or more VPC security groups associated with the cache cluster"
    default     = []
}

variable "parameter_group_name" {
    description = "Name of the parameter group associated with this cache cluster. Ex: default.redis4.0, default.memcached1.4 etc"
    default     = {
        redis       = ""
        memcached   = ""
    }
}

variable "apply_immediately" {
  description   = "(Optional) Specifies whether any database modifications are applied immediately, or during the next maintenance window. Default is false. See Amazon ElastiCache Documentation for more information. (Available since v0.6.0)"
  default       = false
}

variable "maintenance_window" {
    description = "Specifies the weekly time range for when maintenance on the cache cluster is performed. The format is ddd:hh24:mi-ddd:hh24:mi (24H Clock UTC). The minimum maintenance window is a 60 minute period. Example: sun:05:00-sun:09:00"
    default     = "sun:05:00-sun:09:00"
}

variable "snapshot_window" {
    description = "The daily time range (in UTC) during which ElastiCache will begin taking a daily snapshot of the cache cluster. Format: hh24:mi-hh24:mi. The minimum snapshot window is a 60 minute period. Example: 05:00-09:00"
    default     = null
}

variable "snapshot_retention_limit" {
    description = "The number of days for which ElastiCache will retain automatic cache cluster snapshots before deleting them. For example, if you set SnapshotRetentionLimit to 5, then a snapshot that was taken today will be retained for 5 days before being deleted. If the value of SnapshotRetentionLimit is set to zero (0), backups are turned off. Please note that setting a snapshot_retention_limit is not supported on cache.t1.micro or cache.t2.* cache nodes"
    default     = null
}

variable "snapshot_arns" {
  description   = "(Optional) A single-element string list containing an Amazon Resource Name (ARN) of a Redis RDB snapshot file stored in Amazon S3. Example: arn:aws:s3:::my_bucket/snapshot1.rdb"
  default       = null
}

variable "snapshot_name" {
  description   = "(Optional) The name of a snapshot from which to restore data into the new node group. Changing the snapshot_name forces a new resource."
  default       = ""
}

variable "notification_topic_arn" {
    description = "An Amazon Resource Name (ARN) of an SNS topic that ElastiCache notifications get sent to."
    default     = ""
}

variable "availability_zone" {
    description = "The Availability Zone for the cache cluster."
    default     = ""
}

variable "az_mode" {
  description   = "(Optional, Memcached only) Specifies whether the nodes in this Memcached node group are created in a single Availability Zone or created across multiple Availability Zones in the cluster's region. Valid values for this parameter are single-az or cross-az, default is single-az. If you want to choose cross-az, num_cache_nodes must be greater than 1"
  default       = null
}

variable "preferred_availability_zones" {
  description   = "(Optional, Memcached only) A list of the Availability Zones in which cache nodes are created. If you are creating your cluster in an Amazon VPC you can only locate nodes in Availability Zones that are associated with the subnets in the selected subnet group. The number of Availability Zones listed must equal the value of num_cache_nodes. If you want all the nodes in the same Availability Zone, use availability_zone instead, or repeat the Availability Zone multiple times in the list. Default: System chosen Availability Zones. Detecting drift of existing node availability zone is not currently supported. Updating this argument by itself to migrate existing node availability zones is not currently supported and will show a perpetual difference."
  default       = null
}

#---------------------------------------------------
# AWS elasticache replication group
#---------------------------------------------------
variable "replication_group_description" {
  description   = "Description for replication_group"
  default       = ""
}

variable "availability_zones" {
  description   = "(Optional) A list of EC2 availability zones in which the replication group's cache clusters will be created. The order of the availability zones in the list is not important."
  default       = []
}


variable "number_cluster_replicas" {
    description = "Number of cluster replicas which will create"
    default     = 0
}

variable "automatic_failover_enabled" {
    description = "Specifies whether a read-only replica will be automatically promoted to read/write primary if the existing primary fails. Defaults to false."
    default     = true
}

variable "auto_minor_version_upgrade" {
    description = "Specifies whether a minor engine upgrades will be applied automatically to the underlying Cache Cluster instances during the maintenance window. Defaults to true."
    default     = true
}

variable "at_rest_encryption_enabled" {
    description = "Whether to enable encryption at rest."
    default     = false
}

variable "transit_encryption_enabled" {
    description = "Whether to enable encryption in transit."
    default     = false
}

variable "auth_token" {
    description = "The password used to access a password protected server. Can be specified only if transit_encryption_enabled = true."
    default     = "AUTHtoken666AUTHtoken666AUTHtoken666AUTHtoken666"
}

variable "cluster_mode" {
  description   = "(Optional) Create a native redis cluster. automatic_failover_enabled must be set to true."
  default       = []
}

#variable "cluster_mode_replicas_per_node_group" {
#    description = "Specify the number of replica nodes in each node group. Valid values are 0 to 5. Changing this number will force a new resource."
#    default     = 1
#}