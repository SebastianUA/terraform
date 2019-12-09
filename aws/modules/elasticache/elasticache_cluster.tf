#---------------------------------------------------
# Create AWS elasticache cluster
#---------------------------------------------------
resource "aws_elasticache_cluster" "elasticache_cluster" {
    count                       = var.num_cache_nodes ==1 && var.number_cluster_replicas ==0 && var.create_single_cluster ? 1 : 0

    cluster_id                  = var.elasticache_cluster_name != "" ? var.elasticache_cluster_name : "${lower(var.name)}-${lower(var.engine)}-${lower(var.environment)}"
    engine                      = var.engine
    node_type                   = var.node_type
    port                        = var.elasticache_cluster_port != null ? var.elasticache_cluster_port : var.default_ports[var.engine]
    num_cache_nodes             = var.num_cache_nodes
                            
    subnet_group_name           = var.elasticache_subnet_group_name != "" ? var.elasticache_subnet_group_name :  element(aws_elasticache_subnet_group.elasticache_subnet_group.*.id, 0)
    
    security_group_names        = var.security_group_names_for_cluster
    security_group_ids          = var.security_group_ids
    parameter_group_name        = var.parameter_group_name[var.engine] !="" ? var.parameter_group_name[var.engine] : element(aws_elasticache_parameter_group.elasticache_parameter_group.*.name, 0)
                         
    maintenance_window          = var.maintenance_window
    snapshot_window             = var.snapshot_window
    snapshot_retention_limit    = var.snapshot_retention_limit
                    
    availability_zone           = var.availability_zone 
    notification_topic_arn      = var.notification_topic_arn

    tags = merge(
        {
            "Name"          = var.elasticache_cluster_name != "" ? var.elasticache_cluster_name : "${lower(var.name)}-${lower(var.engine)}-${lower(var.environment)}"
        },
        {
            "Environment"   = var.environment
        },
        {
            "Orchestration" = var.orchestration
        },
        {
            "Createdby"     = var.createdby
        },
        var.tags,
    )

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }
    
    depends_on = [
        aws_elasticache_subnet_group.elasticache_subnet_group,
        aws_elasticache_security_group.elasticache_security_group,
        aws_elasticache_parameter_group.elasticache_parameter_group
    ]
}