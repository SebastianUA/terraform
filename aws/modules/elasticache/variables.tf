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

variable "security_group_names" {
    description = "List of EC2 security group names to be authorized for ingress to the cache security group"
    type        = "list"
    default     = []
}

variable "subnet_ids" {
    description = "List of VPC Subnet IDs for the cache subnet group"
    type        = "list"
    default     = []
}

variable "parameters_for_parameter_group" {
    description = "List of parameters for custom elasticache parameter group"
    type        = "list"
    default     = []
}

variable "create_custom_elasticache_parameter_group" {
    description = "If true, will create elasticache parameter group"
    default     = "true"
}

variable "engine" {
    description = "Name of the cache engine to be used for this cache cluster. Valid values for this parameter are memcached or redis"
    default     = "redis"
}

variable "engine_version" {
    description = "The version number of the cache engine to be used for the cache clusters in this replication group."
    default     = ""
}

variable "default_ports" {
    description = "Default database ports"
    type        = "map"
    default     = {
        redis       = "6379"
        memcached   = "11211"
    }
}

variable "elasticache_parameter_group_family" {
    description = "Set DB group family"
    type        = "map"
    default     = {
        redis       = "redis3.2"
        memcached   = "memcached1.4"
    }           
}

variable "create_single_cluster" {
    description = "Enable to create a cluster without any replicas. Default - true"
    default     = "true"
}

variable "node_type" {
    description = "The cluster node type. Ex: cache.t2.micro"
    default     = "cache.t2.micro"
}

variable "num_cache_nodes" {
    description = "The number of cache nodes that the cache cluster has.  Cannot create a Redis cluster with a NumCacheNodes parameter greater than 1."
    default     = "1"
}

variable "parameter_group_name" {
    description = "Name of the parameter group associated with this cache cluster. Ex: default.redis3.2, default.memcached1.4 etc"
    type        = "map"
    default     = {
        redis       = ""
        memcached   = ""
    }
}

variable "subnet_group_name" {
    description = "Name of the subnet group associated to the cache cluster."
    default     = ""
}

variable "security_group_names_for_cluster" {
    description = "List of security group names associated with this cache cluster."
    type        = "list"
    default     = []
}

variable "security_group_ids" {
    description = "List VPC security groups associated with the cache cluster."
    type        = "list"
    default     = []
}

variable "maintenance_window" {
    description = "Specifies the weekly time range for when maintenance on the cache cluster is performed. The format is ddd:hh24:mi-ddd:hh24:mi (24H Clock UTC). The minimum maintenance window is a 60 minute period. Example: sun:05:00-sun:09:00"
    default     = "sun:05:00-sun:09:00"
}

variable "snapshot_window" {
    description = "The daily time range (in UTC) during which ElastiCache will begin taking a daily snapshot of the cache cluster. Format: hh24:mi-hh24:mi. The minimum snapshot window is a 60 minute period. Example: 05:00-09:00"
    default     = "01:00-05:00"
}

variable "availability_zone" {
    description = "The Availability Zone for the cache cluster."
    default     = ""
}

variable "notification_topic_arn" {
    description = "An Amazon Resource Name (ARN) of an SNS topic that ElastiCache notifications get sent to."
    default     = ""
}

variable "snapshot_retention_limit" {
    description = "The number of days for which ElastiCache will retain automatic cache cluster snapshots before deleting them. For example, if you set SnapshotRetentionLimit to 5, then a snapshot that was taken today will be retained for 5 days before being deleted. If the value of SnapshotRetentionLimit is set to zero (0), backups are turned off. Please note that setting a snapshot_retention_limit is not supported on cache.t1.micro or cache.t2.* cache nodes"
    default     = "7"
}

variable "replication_group_id" {
    description = "The replication group to which this cache cluster belongs."
    default     = "replication-cluster-group"
}

variable "number_cluster_replicas" {
    description = "Number of cluster replicas which will create"
    default     = "0"
}

variable "automatic_failover_enabled" {
    description = "Specifies whether a read-only replica will be automatically promoted to read/write primary if the existing primary fails. Defaults to false."
    default     = "true"
}

variable "auto_minor_version_upgrade" {
    description = "Specifies whether a minor engine upgrades will be applied automatically to the underlying Cache Cluster instances during the maintenance window. Defaults to true."
    default     = "true"
}

variable "at_rest_encryption_enabled" {
    description = "Whether to enable encryption at rest."
    default     = "false"
}

variable "transit_encryption_enabled" {
    description = "Whether to enable encryption in transit."
    default     = "false"
}

variable "auth_token" {
    description = "The password used to access a password protected server. Can be specified only if transit_encryption_enabled = true."
    default     = "AUTHtoken666AUTHtoken666AUTHtoken666AUTHtoken666"
}

variable "snapshot_name" {
    description = "The name of a snapshot from which to restore data into the new node group. Changing the snapshot_name forces a new resource."
    default     = ""
}

variable "apply_immediately" {
    description = "Specifies whether any modifications are applied immediately, or during the next maintenance window. Default is false."
    default     = "false"
}

variable "cluster_mode_replicas_per_node_group" {
    description = "Specify the number of replica nodes in each node group. Valid values are 0 to 5. Changing this number will force a new resource."
    default     = "1"
}

