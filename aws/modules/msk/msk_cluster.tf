#---------------------------------------------------
# AWS MSK cluster
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

      dynamic "encryption_in_transit" {
        iterator = encryption_in_transit
        for_each = length(keys(lookup(encryption_info.value, "encryption_in_transit", {}))) > 0 ? [lookup(encryption_info.value, "encryption_in_transit", {})] : []

        content {
          client_broker = lookup(encryption_in_transit.value, "client_broker", null)
          in_cluster    = lookup(encryption_in_transit.value, "in_cluster", null)
        }
      }
    }
  }

  dynamic "client_authentication" {
    iterator = client_authentication
    for_each = var.msk_cluster_client_authentication

    content {
      dynamic "tls" {
        iterator = tls
        for_each = length(keys(lookup(client_authentication.value, "tls", {}))) > 0 ? [lookup(client_authentication.value, "tls", {})] : []

        content {
          certificate_authority_arns = lookup(tls.value, "certificate_authority_arns", null)
        }
      }

      dynamic "sasl" {
        iterator = sasl
        for_each = length(keys(lookup(client_authentication.value, "sasl", {}))) > 0 ? [lookup(client_authentication.value, "sasl", {})] : []

        content {
          scram = lookup(sasl.value, "scram", null)
        }
      }
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
      dynamic "prometheus" {
        iterator = prometheus
        for_each = length(keys(lookup(open_monitoring.value, "prometheus", {}))) > 0 ? [lookup(open_monitoring.value, "prometheus", {})] : []

        content {
          dynamic "jmx_exporter" {
            iterator = jmx_exporter
            for_each = length(keys(lookup(prometheus.value, "jmx_exporter", {}))) > 0 ? [lookup(prometheus.value, "jmx_exporter", {})] : []

            content {
              enabled_in_broker = lookup(jmx_exporter.value, "enabled_in_broker", null)
            }
          }

          dynamic "node_exporter" {
            iterator = node_exporter
            for_each = length(keys(lookup(prometheus.value, "node_exporter", {}))) > 0 ? [lookup(prometheus.value, "node_exporter", {})] : []

            content {
              enabled_in_broker = lookup(node_exporter.value, "enabled_in_broker", null)
            }
          }
        }
      }
    }
  }

  dynamic "logging_info" {
    iterator = logging_info
    for_each = var.msk_cluster_logging_info

    content {
      dynamic "broker_logs" {
        iterator = broker_logs
        for_each = length(keys(lookup(logging_info.value, "broker_logs", {}))) > 0 ? [lookup(logging_info.value, "broker_logs", {})] : []

        content {
          dynamic "cloudwatch_logs" {
            iterator = cloudwatch_logs
            for_each = lookup(broker_logs.value, "cloudwatch_logs", [])

            content {
              enabled   = lookup(cloudwatch_logs.value, "enabled", null)
              log_group = lookup(cloudwatch_logs.value, "log_group", null)
            }
          }

          dynamic "firehose" {
            iterator = firehose
            for_each = lookup(broker_logs.value, "firehose", [])

            content {
              enabled         = lookup(firehose.value, "enabled", null)
              delivery_stream = lookup(firehose.value, "delivery_stream", null)
            }
          }

          dynamic "s3" {
            iterator = s3
            for_each = lookup(broker_logs.value, "s3", [])

            content {
              enabled = lookup(s3.value, "enabled", null)
              bucket  = lookup(s3.value, "bucket", null)
              prefix  = lookup(s3.value, "prefix", null)
            }
          }
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
