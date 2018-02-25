#---------------------------------------------------
# Create AWS elasticache security group (SG)
#---------------------------------------------------
resource "aws_elasticache_security_group" "elasticache_sg" {
    # NOTE: ElastiCache Subnet Groups are only for use when working with an ElastiCache cluster inside of a VPC. If you are on EC2 Classic, see the ElastiCache Security Group resource.
    # NOTE: ElastiCache Security Groups are for use only when working with an ElastiCache cluster outside of a VPC. If you are using a VPC, see the ElastiCache Subnet Group resource.
    count                = "${length(var.security_group_names) !=0 && length(var.subnet_ids) ==0 ? 1 : 0}" 

    name                 = "${lower(var.name)}-${var.engine}-sg-${lower(var.environment)}"
    description          = "Elasticache security group (SG) which managed by ${var.orchestration}"  
    security_group_names = ["${var.security_group_names}"]
}
#---------------------------------------------------
# Create AWS elasticache subnet group
#---------------------------------------------------
resource "aws_elasticache_subnet_group" "elasticache_subnet_group" {
    # NOTE: ElastiCache Subnet Groups are only for use when working with an ElastiCache cluster inside of a VPC. If you are on EC2 Classic, see the ElastiCache Security Group resource.
    # NOTE: ElastiCache Security Groups are for use only when working with an ElastiCache cluster outside of a VPC. If you are using a VPC, see the ElastiCache Subnet Group resource.
    count       = "${length(var.subnet_ids) !=0 && length(var.security_group_names) ==0 ? 1 : 0}"

    name        = "${lower(var.name)}-${var.engine}-subnet-group-${lower(var.environment)}"
    description = "Elasticache subnet group which managed by ${var.orchestration}"
    subnet_ids  = ["${var.subnet_ids}"]
}
#---------------------------------------------------
# Create AWS elasticache parameter group
#---------------------------------------------------
resource "aws_elasticache_parameter_group" "elasticache_parameter_group" {
    count       = "${length(var.parameters_for_parameter_group) !=0 && var.create_custom_elasticache_parameter_group ? 1 : 0}"
                            
    name        = "${lower(var.name)}-${var.engine}-parameter-group-${lower(var.environment)}"
    description = "Elasticache parameter group which managed by ${var.orchestration}"
    family      = "${var.elasticache_parameter_group_family[var.engine]}"

    parameter = ["${var.parameters_for_parameter_group}"]
}
#---------------------------------------------------
# Create AWS elasticache cluster
#---------------------------------------------------
resource "aws_elasticache_cluster" "elasticache_cluster" {
    count                   = "${var.num_cache_nodes ==1 && var.number_cluster_replicas ==0 && var.create_single_cluster ? 1 : 0}"

    cluster_id              = "${lower(var.name)}-${lower(var.engine)}-${lower(var.environment)}"
    engine                  = "${var.engine}"
    node_type               = "${var.node_type}"
    port                    = "${var.default_ports[var.engine]}"
    num_cache_nodes         = "${var.num_cache_nodes}"
                            
    subnet_group_name       = "${var.subnet_group_name}"
    security_group_names    = ["${var.security_group_names_for_cluster}"]
    security_group_ids      = ["${var.security_group_ids}"]
    parameter_group_name    = "${var.parameter_group_name[var.engine] !="" ? var.parameter_group_name[var.engine] : aws_elasticache_parameter_group.elasticache_parameter_group.name}"
                         
    maintenance_window          = "${var.maintenance_window}"
    snapshot_window             = "${var.snapshot_window}"
    #snapshot_retention_limit    = "${var.snapshot_retention_limit }"
                    
    availability_zone       = "${var.availability_zone}"    
    notification_topic_arn  = "${var.notification_topic_arn}"

    tags {
        Name            = "${lower(var.name)}-${var.engine}-cluster-${lower(var.environment)}"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }
}

#---------------------------------------------------
# Create AWS elasticache replication group
#---------------------------------------------------
resource "aws_elasticache_replication_group" "elasticache_replication_group" {  
    # Redis Master with One Replica with 1 shard
    count                         = "${var.num_cache_nodes >1 && var.number_cluster_replicas ==1 && var.create_single_cluster !="true" ? 1 : 0}"    

    replication_group_id          = "${lower(var.name)}-${lower(var.engine)}-${lower(var.environment)}"
    replication_group_description = "The ${var.engine} master with 1 replica shard which managed by ${var.orchestration}"
    node_type                     = "${var.node_type}"
    number_cache_clusters         = "${var.num_cache_nodes}"
    port                          = "${var.default_ports[var.engine]}"
    engine                        = "${var.engine}"
    engine_version                = "${var.engine_version}"
                                                                                            
    availability_zones              = ["us-east-1a", "us-east-1c"]
    automatic_failover_enabled      = "${var.automatic_failover_enabled}"
    subnet_group_name               = "${var.subnet_group_name}"
    security_group_names            = ["${var.security_group_names_for_cluster}"]
    security_group_ids              = ["${var.security_group_ids}"]
    parameter_group_name            = "${var.parameter_group_name[var.engine] !="" ? var.parameter_group_name[var.engine] : aws_elasticache_parameter_group.elasticache_parameter_group.name}"
    at_rest_encryption_enabled      = "${var.at_rest_encryption_enabled}"
    transit_encryption_enabled      = "${var.transit_encryption_enabled}"
    #auth_token                      = "${var.auth_token}"
    
    auto_minor_version_upgrade  = "${var.auto_minor_version_upgrade}"
    snapshot_name               = "${var.snapshot_name}"
    maintenance_window          = "${var.maintenance_window}"
    snapshot_window             = "${var.snapshot_window}"
    snapshot_retention_limit    = "${var.snapshot_retention_limit}"
    apply_immediately           = "${var.apply_immediately}"
    
    notification_topic_arn  = "${var.notification_topic_arn}"

    tags {
        Name            = "${lower(var.name)}-${var.engine}-cluster-${lower(var.environment)}"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }
}

resource "aws_elasticache_replication_group" "elasticache_replication_group_2" {
    # Redis Master with One Replica for each nodes
    count                         = "${var.num_cache_nodes >1 && var.number_cluster_replicas ==2 && var.create_single_cluster !="true" ? 1 : 0}"

    replication_group_id          = "${lower(var.name)}-${lower(var.engine)}-${lower(var.environment)}"
    replication_group_description = "The ${var.engine} master with 2 replica shards which managed by ${var.orchestration}"
    node_type                     = "${var.node_type}"
    port                          = "${var.default_ports[var.engine]}"
    engine                        = "${var.engine}"
    engine_version                = "${var.engine_version}"

    automatic_failover_enabled      = "${var.automatic_failover_enabled}"
    subnet_group_name               = "${var.subnet_group_name}"
    security_group_names            = ["${var.security_group_names_for_cluster}"]
    security_group_ids              = ["${var.security_group_ids}"]
    parameter_group_name            = "${var.parameter_group_name[var.engine] !="" ? var.parameter_group_name[var.engine] : aws_elasticache_parameter_group.elasticache_parameter_group.name}"
    at_rest_encryption_enabled      = "${var.at_rest_encryption_enabled}"
    transit_encryption_enabled      = "${var.transit_encryption_enabled}"
    #auth_token                      = "${var.auth_token}"

    auto_minor_version_upgrade  = "${var.auto_minor_version_upgrade}"
    snapshot_name               = "${var.snapshot_name}"
    maintenance_window          = "${var.maintenance_window}"
    snapshot_window             = "${var.snapshot_window}"
    snapshot_retention_limit    = "${var.snapshot_retention_limit}"
    apply_immediately           = "${var.apply_immediately}"

    notification_topic_arn  = "${var.notification_topic_arn}"

    cluster_mode {
        replicas_per_node_group     = "${var.cluster_mode_replicas_per_node_group}"
        num_node_groups             = "${var.num_cache_nodes}"
    }

    lifecycle {
        create_before_destroy   = true,
    }

    tags {
        Name            = "${lower(var.name)}-${var.engine}-cluster-${lower(var.environment)}"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }
}
