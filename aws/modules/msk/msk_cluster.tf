#---------------------------------------------------
# Create aws msk cluster
#---------------------------------------------------
resource "aws_msk_cluster" "msk_cluster" {
  count = var.enable_msk_cluster ? 1 : 0

  cluster_name           = var.msk_cluster_name != "" ? lower(var.msk_cluster_name) : "${lower(var.name)}-msk-cluster-${lower(var.environment)}"
  kafka_version          = var.msk_cluster_kafka_version
  number_of_broker_nodes = var.msk_cluster_number_of_broker_nodes

  dynamic "broker_node_group_info" {
    iterator = broker_node_group_info
    for_each = var.msk_cluster_broker_node_group_info
    content {
      instance_type   = lookup(broker_node_group_info.value, "instance_type", null)
      ebs_volume_size = lookup(broker_node_group_info.value, "ebs_volume_size", null)
      client_subnets  = lookup(broker_node_group_info.value, "client_subnets", null)
      security_groups = lookup(broker_node_group_info.value, "security_groups", null)
      az_distribution = lookup(broker_node_group_info.value, "az_distribution", null)
    }
  }

  enhanced_monitoring = var.msk_cluster_enhanced_monitoring != null ? upper(var.msk_cluster_enhanced_monitoring) : null

  dynamic "encryption_info" {
    iterator = encryption_info
    for_each = var.msk_cluster_encryption_info
    content {
      encryption_at_rest_kms_key_arn = lookup(encryption_info.value, "encryption_at_rest_kms_key_arn", null)
      encryption_in_transit {
        client_broker = lookup(encryption_info.value, "client_broker", null)
        in_cluster    = lookup(encryption_info.value, "in_cluster", null)
      }
    }
  }

  dynamic "client_authentication" {
    iterator = client_authentication
    for_each = var.msk_cluster_client_authentication
    content {
      tls {
        certificate_authority_arns = lookup(client_authentication.value, "certificate_authority_arns", null)
      }

      // sasl {
      //   scram = lookup(client_authentication.value, "scram", null)
      // }
    }
  }

  dynamic "configuration_info" {
    iterator = configuration_info
    for_each = var.msk_cluster_configuration_info
    content {
      arn      = lookup(configuration_info.value, "arn", null)
      revision = lookup(configuration_info.value, "revision", null)
    }
  }

  dynamic "open_monitoring" {
    iterator = open_monitoring
    for_each = var.msk_cluster_open_monitoring
    content {
      prometheus {
        jmx_exporter {
          enabled_in_broker = lookup(open_monitoring.value, "prometheus_jmx_exporter_enabled_in_broker", null)
        }
        node_exporter {
          enabled_in_broker = lookup(open_monitoring.value, "prometheus_node_exporter_enabled_in_broker", null)
        }
      }
    }
  }

  logging_info {

    broker_logs {

      dynamic "cloudwatch_logs" {
        iterator = cloudwatch_logs
        for_each = var.msk_cluster_logging_info_broker_logs_cloudwatch_logs
        content {
          enabled   = null
          log_group = null
        }
      }

      dynamic "firehose" {
        iterator = firehose
        for_each = var.msk_cluster_logging_info_broker_logs_firehose
        content {
          enabled         = null
          delivery_stream = null
        }
      }

      dynamic "s3" {
        iterator = s3
        for_each = var.msk_cluster_logging_info_broker_logs_s3
        content {
          enabled = null
          bucket  = null
          prefix  = null
        }
      }
    }
  }

  tags = merge(
    {
      Name = var.msk_cluster_name != "" ? lower(var.msk_cluster_name) : "${lower(var.name)}-msk-cluster-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []

}
