#---------------------------------------------------
# Create AWS DB event subscription
#---------------------------------------------------
resource "aws_db_event_subscription" "db_event_subscription" {
    count               = var.enable_db_event_subscription ? 1 : 0

    name                = var.db_event_subscription_name != "" && var.db_event_subscription_name_prefix == "" ? var.db_event_subscription_name : null
    name_prefix         = var.db_event_subscription_name_prefix != "" && var.db_event_subscription_name == "" ? var.db_event_subscription_name_prefix : null
    sns_topic           = var.db_event_subscription_sns_topic

    source_type         = var.db_event_subscription_source_type
    source_ids          = var.db_event_subscription_source_ids
    enabled             = var.db_event_subscription_enabled
    event_categories    = var.db_event_subscription_event_categories

    tags                = merge(
        {
            "Name"  = var.db_cluster_snapshot_identifier != "" ? lower(var.db_cluster_snapshot_identifier) : "${lower(var.name)}-db-cluster-snapshot-${lower(var.environment)}"
        },
        var.tags
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

    depends_on          = []
}
