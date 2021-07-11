#---------------------------------------------------
# AWS elasticsearch domain
#---------------------------------------------------
resource "aws_elasticsearch_domain" "elasticsearch_domain" {
  count = var.enable_elasticsearch_domain ? 1 : 0

  domain_name = var.elasticsearch_domain_name != "" ? var.elasticsearch_domain_name : "${lower(var.name)}-es-domain-${lower(var.environment)}"

  elasticsearch_version = var.elasticsearch_domain_elasticsearch_version
  advanced_options      = var.elasticsearch_domain_advanced_options
  access_policies       = var.elasticsearch_domain_access_policies

  dynamic "advanced_security_options" {
    iterator = advanced_security_options
    for_each = length(keys(var.elasticsearch_domain_advanced_security_options)) > 0 ? [var.elasticsearch_domain_advanced_security_options] : []

    content {
      enabled                        = lookup(advanced_security_options.value, "enabled", null)
      internal_user_database_enabled = lookup(advanced_security_options.value, "internal_user_database_enabled", null)

      dynamic "master_user_options" {
        iterator = master_user_options
        for_each = length(keys(lookup(advanced_security_options.value, "master_user_options", {}))) > 0 ? [lookup(advanced_security_options.value, "master_user_options", {})] : []

        content {
          master_user_arn      = lookup(master_user_options.value, "master_user_arn", null)
          master_user_name     = lookup(master_user_options.value, "master_user_name", null)
          master_user_password = lookup(master_user_options.value, "master_user_password", null)
        }
      }

    }
  }

  dynamic "ebs_options" {
    iterator = ebs_options
    for_each = length(keys(var.elasticsearch_domain_ebs_options)) > 0 ? [var.elasticsearch_domain_ebs_options] : []

    content {
      ebs_enabled = lookup(ebs_options.value, "ebs_enabled", null)

      volume_type = lookup(ebs_options.value, "volume_type", null)
      volume_size = lookup(ebs_options.value, "volume_size", null)
      iops        = lookup(ebs_options.value, "iops", null)
    }
  }

  dynamic "encrypt_at_rest" {
    iterator = encrypt_at_rest
    for_each = length(keys(var.elasticsearch_domain_encrypt_at_rest)) > 0 ? [var.elasticsearch_domain_encrypt_at_rest] : []

    content {
      enabled = lookup(encrypt_at_rest.value, "enabled", null)

      kms_key_id = lookup(encrypt_at_rest.value, "kms_key_id", null)
    }
  }

  dynamic "node_to_node_encryption" {
    iterator = node_to_node_encryption
    for_each = length(keys(var.elasticsearch_domain_node_to_node_encryption)) > 0 ? [var.elasticsearch_domain_node_to_node_encryption] : []

    content {
      enabled = lookup(node_to_node_encryption.value, "enabled", null)
    }
  }

  dynamic "cluster_config" {
    iterator = cluster_config
    for_each = var.elasticsearch_domain_cluster_config

    content {
      instance_type            = lookup(cluster_config.value, "instance_type", null)
      instance_count           = lookup(cluster_config.value, "instance_count", null)
      dedicated_master_enabled = lookup(cluster_config.value, "dedicated_master_enabled", null)
      dedicated_master_type    = lookup(cluster_config.value, "dedicated_master_type", null)
      dedicated_master_count   = lookup(cluster_config.value, "dedicated_master_count", null)
      zone_awareness_enabled   = lookup(cluster_config.value, "zone_awareness_enabled", null)
      warm_enabled             = lookup(cluster_config.value, "warm_enabled", null)
      warm_count               = lookup(cluster_config.value, "warm_count", null)
      warm_type                = lookup(cluster_config.value, "warm_type", null)

      dynamic "zone_awareness_config" {
        iterator = zone_awareness_config
        for_each = length(keys(lookup(cluster_config.value, "zone_awareness_config", {}))) > 0 ? [lookup(cluster_config.value, "zone_awareness_config", {})] : []

        content {
          availability_zone_count = lookup(zone_awareness_config.value, "availability_zone_count", null)
        }
      }
    }
  }

  dynamic "vpc_options" {
    iterator = vpc_options
    for_each = length(keys(var.elasticsearch_domain_vpc_options)) > 0 ? [var.elasticsearch_domain_vpc_options] : []

    content {
      subnet_ids = lookup(vpc_options.value, "subnet_ids", null)

      security_group_ids = lookup(vpc_options.value, "security_group_ids", null)
    }
  }

  dynamic "snapshot_options" {
    iterator = snapshot_options
    for_each = length(keys(var.elasticsearch_domain_snapshot_options)) > 0 ? [var.elasticsearch_domain_snapshot_options] : []

    content {
      automated_snapshot_start_hour = lookup(snapshot_options.value, "automated_snapshot_start_hour", null)
    }
  }

  dynamic "log_publishing_options" {
    iterator = log_publishing_options
    for_each = length(keys(var.elasticsearch_domain_log_publishing_options)) > 0 ? [var.elasticsearch_domain_log_publishing_options] : []

    content {
      cloudwatch_log_group_arn = lookup(log_publishing_options.value, "cloudwatch_log_group_arn", null)
      log_type                 = lookup(log_publishing_options.value, "log_type", null)
    }
  }

  dynamic "cognito_options" {
    iterator = cognito_options
    for_each = length(keys(var.elasticsearch_domain_cognito_options)) > 0 ? [var.elasticsearch_domain_cognito_options] : []

    content {
      user_pool_id     = lookup(cognito_options.value, "user_pool_id", null)
      identity_pool_id = lookup(cognito_options.value, "identity_pool_id", null)
      role_arn         = lookup(cognito_options.value, "role_arn", null)

      enabled = lookup(cognito_options.value, "enabled", null)
    }
  }

  dynamic "domain_endpoint_options" {
    iterator = domain_endpoint_options
    for_each = length(keys(var.elasticsearch_domain_domain_endpoint_options)) > 0 ? [var.elasticsearch_domain_domain_endpoint_options] : []

    content {
      enforce_https = lookup(domain_endpoint_options.value, "enforce_https", null)

      tls_security_policy = lookup(domain_endpoint_options.value, "tls_security_policy", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.elasticsearch_domain_timeouts)) > 0 ? [var.elasticsearch_domain_timeouts] : []

    content {
      update = lookup(timeouts.value, "update", null)
    }
  }

  tags = merge(
    {
      Name = var.elasticsearch_domain_name != "" ? var.elasticsearch_domain_name : "${lower(var.name)}-es-domain-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}