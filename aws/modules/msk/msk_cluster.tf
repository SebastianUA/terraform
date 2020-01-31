#---------------------------------------------------
# Create aws msk cluster
#---------------------------------------------------
resource "aws_msk_cluster" "msk_cluster" {
    count                   = var.enable_msk_cluster ? 1 : 0

    cluster_name            = var.cluster_name != "" ? lower(var.cluster_name) : "${lower(var.name)}-msk-cluster-${lower(var.environment)}"
    kafka_version           = var.kafka_version
    number_of_broker_nodes  = var.number_of_broker_nodes

    dynamic "broker_node_group_info" {
        for_each = var.broker_node_group_info
        content {
            instance_type   = lookup(broker_node_group_info.value, "instance_type", null)
            ebs_volume_size = lookup(broker_node_group_info.value, "ebs_volume_size", null)
            client_subnets  = lookup(broker_node_group_info.value, "client_subnets", null)
            security_groups = lookup(broker_node_group_info.value, "security_groups", null)
            az_distribution = lookup(broker_node_group_info.value, "az_distribution", null)
        }
    }

    encryption_info {
        encryption_at_rest_kms_key_arn  = var.encryption_info_encryption_at_rest_kms_key_arn != "" ? var.encryption_info_encryption_at_rest_kms_key_arn : null
        encryption_in_transit {
            client_broker   = upper(var.encryption_in_transit_client_broker)
            in_cluster      = var.encryption_in_transit_in_cluster 
        }
    }

    client_authentication {
        tls {
            certificate_authority_arns  = length(var.client_authentication_certificate_authority_arns) > 0 ? var.client_authentication_certificate_authority_arns : null
        }    
    }

    dynamic "configuration_info" {
        for_each = var.configuration_info
        content {
            arn         = lookup(configuration_info.value, "arn", null)
            revision    = lookup(configuration_info.value, "revision", null)
        }    
    }

    enhanced_monitoring = upper(var.enhanced_monitoring)

    tags = merge(
        {
            "Name"          = var.cluster_name != "" ? lower(var.cluster_name) : "${lower(var.name)}-msk-cluster-${lower(var.environment)}"
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

    depends_on  = []

}
