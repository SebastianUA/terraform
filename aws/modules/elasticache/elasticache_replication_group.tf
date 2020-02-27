#---------------------------------------------------
# Create AWS elasticache replication group
#---------------------------------------------------
resource "aws_elasticache_replication_group" "elasticache_replication_group" {
    count                           = var.elasticache_replication_group ? 1 : 0

    replication_group_id            = var.replication_group_id != "" ? var.replication_group_id : "${lower(var.name)}-${lower(var.engine)}-${lower(var.environment)}"
    replication_group_description   = var.replication_group_description != "" ? var.replication_group_description : "The ${var.engine} master with 2 replica shards which managed by ${var.orchestration}"
    number_cache_clusters           = var.number_cache_clusters
    node_type                       = var.node_type
    port                            = var.elasticache_cluster_port != null ? var.elasticache_cluster_port : var.default_ports[var.engine]
    engine                          = var.engine
    engine_version                  = var.engine_version != "" ? var.engine_version : var.engine_version_default[var.engine]

    automatic_failover_enabled      = var.automatic_failover_enabled
    availability_zones              = var.availability_zones
    subnet_group_name               = var.subnet_group_name
    security_group_names            = var.security_group_names
    security_group_ids              = var.security_group_ids
    parameter_group_name            = var.parameter_group_name[var.engine] !="" ? var.parameter_group_name[var.engine] : element(aws_elasticache_parameter_group.elasticache_parameter_group.*.name, 0)
    at_rest_encryption_enabled      = var.at_rest_encryption_enabled
    kms_key_id                      = var.kms_key_id
    transit_encryption_enabled      = var.transit_encryption_enabled
    auth_token                      = var.auth_token

    auto_minor_version_upgrade      = var.auto_minor_version_upgrade
    snapshot_name                   = var.snapshot_name
    maintenance_window              = var.maintenance_window
    snapshot_window                 = var.snapshot_window
    snapshot_retention_limit        = var.snapshot_retention_limit
    apply_immediately               = var.apply_immediately

    snapshot_arns                   = var.snapshot_arns
    snapshot_name                   = var.snapshot_name != "" ? var.snapshot_name : null
    notification_topic_arn          = var.notification_topic_arn

    dynamic "cluster_mode" {
        for_each = var.cluster_mode
        content {
            replicas_per_node_group     = lookup(cluster_mode.value, "replicas_per_node_group", null)
            num_node_groups             = lookup(cluster_mode.value, "num_node_groups", null)
        }
    }

    tags = merge(
        {
            "Name"          = var.replication_group_id != "" ? var.replication_group_id : "${lower(var.name)}-${lower(var.engine)}-${lower(var.environment)}"
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

    timeouts {
        create  = var.timeouts_create
        update  = var.timeouts_update
        delete  = var.timeouts_delete
    }

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on = [
        aws_elasticache_parameter_group.elasticache_parameter_group
    ]
}
