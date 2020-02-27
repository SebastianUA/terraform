#---------------------------------------------------
# AWS config configuration aggregator
#---------------------------------------------------
resource "aws_config_configuration_aggregator" "config_configuration_aggregator" {
    count                   = var.enable_config_configuration_aggregator ? 1 : 0

    name                    = var.config_configuration_aggregator_name != "" ? lower(var.config_configuration_aggregator_name) : "${lower(var.name)}-config-aggregator-${lower(var.environment)}"

    dynamic "account_aggregation_source" {
        for_each = var.account_aggregation_source
        content {
            account_ids = lookup(account_aggregation_source.value, "account_ids", null)
            regions     = lookup(account_aggregation_source.value, "regions", null)
            all_regions = lookup(account_aggregation_source.value, "all_regions", null)
        }
    }

    dynamic "organization_aggregation_source" {
        for_each = var.organization_aggregation_source
        content {
            all_regions = lookup(organization_aggregation_source.value, "all_regions", null)
            regions     = lookup(organization_aggregation_source.value, "regions", null)
            role_arn    = lookup(organization_aggregation_source.value, "role_arn", null)
        }
    }

    tags = merge(
        {
            "Name"          = var.config_configuration_aggregator_name != "" ? lower(var.config_configuration_aggregator_name) : "${lower(var.name)}-config-aggregator-${lower(var.environment)}"
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

    depends_on              = []
}
