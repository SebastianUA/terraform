# Work with AWS elasticache via terraform

A terraform module for making elasticache.

## Usage
--------

Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "> 0.9.0"
}
provider "aws" {
    region                  = "us-east-1"
    shared_credentials_file = "${pathexpand("~/.aws/credentials")}"
    profile                 = "default"
}
module "vpc" {
    source                              = "../../modules/vpc"
    name                                = "TEST-VPC"
    environment                         = "PROD"
    # VPC
    instance_tenancy                    = "default"
    enable_dns_support                  = "true"
    enable_dns_hostnames                = "true"
    assign_generated_ipv6_cidr_block    = "false"
    enable_classiclink                  = "false"

    vpc_cidr                            = "172.31.0.0/16"
    private_subnet_cidrs                = ["172.31.64.0/20"]
    public_subnet_cidrs                 = ["172.31.80.0/20"]
    availability_zones                  = ["us-east-1a", "us-east-1b"]
    allowed_ports                       = ["6379", "11211"]

    allow_cidrs_for_allowed_ports       = [{
        "6379"      = ["0.0.0.0/0"]
        "11211"     = ["0.0.0.0/0"]
    }]

    #Internet-GateWay
    enable_internet_gateway             = "true"
    #NAT
    enable_nat_gateway                  = "false"
    single_nat_gateway                  = "true"
    #VPN
    enable_vpn_gateway                  = "false"
    #DHCP
    enable_dhcp_options                 = "false"
    # EIP
    enable_eip                          = "false"
}
module "elasticache" {
    source                          = "../../modules/elasticache"
    name                            = "TEST"
    region                          = "us-east-1"
    environment                     = "PROD"
    
    # NOTE: ElastiCache Subnet Groups are only for use when working with an ElastiCache cluster inside of a VPC. If you are on EC2 Classic, see the ElastiCache Security Group resource.
    # NOTE: ElastiCache Security Groups are for use only when working with an ElastiCache cluster outside of a VPC. If you are using a VPC, see the ElastiCache Subnet Group resource.
    # I HAVE GOT ISSUE WHEN USED "ElastiCache Security Groups". SO I PREFERED ElastiCache Subnet Groups
    #aws_elasticache_security_group.elasticache_sg: Error creating CacheSecurityGroup: InvalidParameterValue: Use of cache security groups is not permitted in this API version for your account. 
    security_group_names    = []
    subnet_ids              = ["${module.vpc.vpc-privatesubnet-ids}", "${module.vpc.vpc-publicsubnet-ids}"]
        
    create_custom_elasticache_parameter_group   = true
    parameters_for_parameter_group              = [
    {
        name  = "activerehashing"
        value = "yes"
    },
    {
        name  = "min-slaves-to-write"
        value = "2"
    },
    ]
    engine                                      = "redis" #"memcached"

    # Not single cluster
    #create_single_cluster   = false
    #num_cache_nodes         = 2
    #number_cluster_replicas = 1
    #node_type               = "cache.m3.medium"    

    # cluster with 2 nodes and 2 shards 
    create_single_cluster   = false
    number_cluster_replicas = 2
    num_cache_nodes         = 2
    node_type               = "cache.m3.medium"
    parameter_group_name    = [{
        redis   = "default.redis3.2.cluster.on"
    }]
    
}

```

Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = "TEST"`).
- `region` - The region where to deploy this code (e.g. us-east-1) (`default = "us-east-1"`).
- `environment` - Environment for service (`default = "STAGE"`).
- `orchestration` - Type of orchestration (`default = "Terraform"`).
- `security_group_names` - List of EC2 security group names to be authorized for ingress to the cache security group (`default     = []`).
- `subnet_ids` - List of VPC Subnet IDs for the cache subnet group (`default     = []`).
- `parameters_for_parameter_group` - List of parameters for custom elasticache parameter group (`default     = []`).
- `create_custom_elasticache_parameter_group` - If true, will create elasticache parameter group (`default     = "true"`). 
- `engine` - Name of the cache engine to be used for this cache cluster. Valid values for this parameter are memcached or redis (`default     = "redis"`).
- `engine_version` - The version number of the cache engine to be used for the cache clusters in this replication group (`default     = ""`).
- `default_ports` - Default database ports (`default     = {
        redis       = "6379"
        memcached   = "11211"
    }`).
- `elasticache_parameter_group_family` - Set DB group family (`default     = {
        redis       = "redis3.2"
        memcached   = "memcached1.4"
    } `).
- `create_single_cluster` - Enable to create a cluster without any replicas. Default - true (`default     = "true"`).
- `node_type` - The cluster node type. Ex: cache.t2.micro (`default     = "cache.t2.micro"`).
- `num_cache_nodes` - The number of cache nodes that the cache cluster has.  Cannot create a Redis cluster with a NumCacheNodes parameter greater than 1 (`default     = "1"`).
- `parameter_group_name` - Name of the parameter group associated with this cache cluster. Ex: default.redis3.2, default.memcached1.4 etc (`default     = {
        redis       = ""
        memcached   = ""
    }`).
- `subnet_group_name` - Name of the subnet group associated to the cache cluste (`default     = ""`).
- `security_group_names_for_cluster` - List of security group names associated with this cache cluster (`default     = []`).
- `security_group_ids` - List VPC security groups associated with the cache cluste  (`default     = []`).
- `maintenance_window` - Specifies the weekly time range for when maintenance on the cache cluster is performed. The format is ddd:hh24:mi-ddd:hh24:mi (24H Clock UTC). The minimum maintenance window is a 60 minute period. Example: sun:05:00-sun:09:00 (`default     = "sun:05:00-sun:09:00"`).
- `snapshot_window` - The daily time range (in UTC) during which ElastiCache will begin taking a daily snapshot of the cache cluster. Format: hh24:mi-hh24:mi. The minimum snapshot window is a 60 minute period. Example: 05:00-09:00 (`default     = "01:00-05:00"`).
- `availability_zone` - The Availability Zone for the cache cluster (`default     = ""`).
- `notification_topic_arn` - An Amazon Resource Name (ARN) of an SNS topic that ElastiCache notifications get sent to (`default     = ""`).
- `snapshot_retention_limit` - The number of days for which ElastiCache will retain automatic cache cluster snapshots before deleting them. For example, if you set SnapshotRetentionLimit to 5, then a snapshot that was taken today will be retained for 5 days before being deleted. If the value of SnapshotRetentionLimit is set to zero (0), backups are turned off. Please note that setting a snapshot_retention_limit is not supported on cache.t1.micro or cache.t2.* cache nodes (`default     = "7"`).
- `replication_group_id` - The replication group to which this cache cluster belongs (`default     = "replication-cluster-group"`).
- `number_cluster_replicas` - Number of cluster replicas which will create (`default     = "0"`).
- `automatic_failover_enabled` - Specifies whether a read-only replica will be automatically promoted to read/write primary if the existing primary fails. Defaults to false (`default     = "true"`).
- `auto_minor_version_upgrade` - Specifies whether a minor engine upgrades will be applied automatically to the underlying Cache Cluster instances during the maintenance window. Defaults to true (`default     = "true"`).
- `at_rest_encryption_enabled` - Whether to enable encryption at res (`default     = "false"`).
- `transit_encryption_enabled` - Whether to enable encryption in transit (`default     = "false"`).
- `auth_token` - The password used to access a password protected server. Can be specified only if transit_encryption_enabled = true (`default     = "AUTHtoken666AUTHtoken666AUTHtoken666AUTHtoken666"`). I don't use this param in my code.
- `snapshot_name` - The name of a snapshot from which to restore data into the new node group. Changing the snapshot_name forces a new resource (`default     = ""`).
- `apply_immediately` - Specifies whether any modifications are applied immediately, or during the next maintenance window. Default is false (`default     = "false"`).
- `cluster_mode_replicas_per_node_group` - Specify the number of replica nodes in each node group. Valid values are 0 to 5. Changing this number will force a new resource (`default     = "1"`).

Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See LICENSE for full details.
