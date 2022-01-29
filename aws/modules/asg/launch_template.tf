#---------------------------------------------------
# Launch AWS template
#---------------------------------------------------
data "template_file" "lt_user_data" {
  count = var.lt_user_data != null ? 1 : 0

  template = var.lt_user_data
}

resource "aws_launch_template" "lt" {
  count = var.enable_lt ? 1 : 0

  name        = var.lt_name != "" ? var.lt_name : (var.lt_name_prefix == null ? "${lower(var.name)}-lt-${lower(var.environment)}" : null)
  name_prefix = var.lt_name_prefix != null ? var.lt_name_prefix : (var.lt_name != "" ? null : var.lt_name_prefix)
  description = var.lt_description

  default_version        = var.lt_default_version
  update_default_version = var.lt_update_default_version

  image_id                             = var.lt_image_id != "" ? var.lt_image_id : lookup(var.ami, var.region)
  kernel_id                            = var.lt_kernel_id
  ram_disk_id                          = var.lt_ram_disk_id
  instance_initiated_shutdown_behavior = lower(var.lt_instance_initiated_shutdown_behavior)
  instance_type                        = var.lt_instance_type

  disable_api_termination = var.lt_disable_api_termination
  ebs_optimized           = var.lt_ebs_optimized
  security_group_names    = var.lt_security_group_names
  vpc_security_group_ids  = var.lt_vpc_security_group_ids
  key_name                = var.lt_key_name
  user_data               = var.lt_user_data != null ? data.template_file.lt_user_data[0].rendered : var.lt_user_data

  dynamic "block_device_mappings" {
    iterator = block_device_mappings
    for_each = var.lt_block_device_mappings

    content {
      device_name  = lookup(block_device_mappings.value, "device_name", null)
      no_device    = lookup(block_device_mappings.value, "no_device", null)
      virtual_name = lookup(block_device_mappings.value, "virtual_name", null)

      dynamic "ebs" {
        iterator = ebs
        for_each = lookup(block_device_mappings.value, "ebs", [])

        content {
          delete_on_termination = lookup(ebs.value, "delete_on_termination", null)
          iops                  = lookup(ebs.value, "iops", null)
          encrypted             = lookup(ebs.value, "encrypted", null)
          kms_key_id            = lookup(ebs.value, "kms_key_id", null)
          snapshot_id           = lookup(ebs.value, "snapshot_id", null)
          volume_size           = lookup(ebs.value, "volume_size", null)
          volume_type           = lookup(ebs.value, "volume_type", null)
        }
      }
    }
  }

  dynamic "capacity_reservation_specification" {
    iterator = capacity_reservation_specification
    for_each = var.lt_capacity_reservation_specification

    content {
      capacity_reservation_preference = lookup(capacity_reservation_specification.value, "capacity_reservation_preference", null)

      dynamic "capacity_reservation_target" {
        iterator = capacity_reservation_target
        for_each = lookup(capacity_reservation_specification.value, "capacity_reservation_target", [])

        content {
          capacity_reservation_id = lookup(capacity_reservation_target.value, "capacity_reservation_id", null)
        }
      }
    }
  }

  dynamic "cpu_options" {
    iterator = cpu_options
    for_each = var.lt_cpu_options

    content {
      core_count       = lookup(cpu_options.value, "core_count", null)
      threads_per_core = lookup(cpu_options.value, "threads_per_core", null)
    }
  }

  dynamic "credit_specification" {
    iterator = credit_specification
    for_each = var.lt_credit_specification

    content {
      cpu_credits = lookup(credit_specification.value, "cpu_credits", null)
    }
  }

  dynamic "elastic_gpu_specifications" {
    iterator = elastic_gpu_specifications
    for_each = var.lt_elastic_gpu_specifications

    content {
      type = lookup(elastic_gpu_specifications.value, "type", null)
    }
  }

  dynamic "elastic_inference_accelerator" {
    iterator = elastic_inference_accelerator
    for_each = var.lt_elastic_inference_accelerator

    content {
      type = lookup(elastic_inference_accelerator.value, "type", null)
    }
  }

  dynamic "iam_instance_profile" {
    iterator = iam_instance_profile
    for_each = var.lt_iam_instance_profile

    content {
      arn  = lookup(iam_instance_profile.value, "arn", null)
      name = lookup(iam_instance_profile.value, "name", null)
    }
  }

  dynamic "instance_market_options" {
    iterator = instance_market_options
    for_each = var.lt_instance_market_options

    content {
      market_type = lookup(instance_market_options.value, "market_type", null)

      dynamic "spot_options" {
        iterator = spot_options
        for_each = lookup(instance_market_options.value, "spot_options", [])

        content {
          block_duration_minutes         = lookup(spot_options.value, "block_duration_minutes", null)
          instance_interruption_behavior = lookup(spot_options.value, "instance_interruption_behavior", null)
          max_price                      = lookup(spot_options.value, "max_price", null)
          spot_instance_type             = lookup(spot_options.value, "spot_instance_type", null)
          valid_until                    = lookup(spot_options.value, "valid_until", null)
        }
      }
    }
  }

  dynamic "license_specification" {
    iterator = license_specification
    for_each = var.lt_license_specification

    content {
      license_configuration_arn = lookup(license_specification.value, "license_configuration_arn", null)
    }
  }

  dynamic "metadata_options" {
    iterator = metadata_options
    for_each = var.lt_metadata_options

    content {
      http_endpoint               = lookup(metadata_options.value, "http_endpoint", null)
      http_tokens                 = lookup(metadata_options.value, "http_tokens", null)
      http_put_response_hop_limit = lookup(metadata_options.value, "http_put_response_hop_limit", null)
    }
  }

  dynamic "monitoring" {
    iterator = monitoring
    for_each = var.lt_monitoring

    content {
      enabled = lookup(monitoring.value, "enabled", null)
    }
  }

  dynamic "network_interfaces" {
    iterator = network_interfaces
    for_each = var.lt_network_interfaces

    content {
      associate_public_ip_address = lookup(network_interfaces.value, "associate_public_ip_address", null)

      delete_on_termination = lookup(network_interfaces.value, "delete_on_termination", null)
      description           = lookup(network_interfaces.value, "description", null)
      device_index          = lookup(network_interfaces.value, "device_index", null)
      ipv6_addresses        = lookup(network_interfaces.value, "ipv6_addresses", null)
      ipv6_address_count    = lookup(network_interfaces.value, "ipv6_address_count", null)
      network_interface_id  = lookup(network_interfaces.value, "network_interface_id", null)
      private_ip_address    = lookup(network_interfaces.value, "private_ip_address", null)
      ipv4_address_count    = lookup(network_interfaces.value, "ipv4_address_count", null)
      ipv4_addresses        = lookup(network_interfaces.value, "ipv4_addresses", null)
      security_groups       = lookup(network_interfaces.value, "security_groups", null)
      subnet_id             = lookup(network_interfaces.value, "subnet_id", null)
    }
  }

  dynamic "placement" {
    iterator = placement
    for_each = var.lt_placement

    content {
      availability_zone = lookup(placement.value, "availability_zone", null)

      affinity         = lookup(placement.value, "affinity", null)
      group_name       = lookup(placement.value, "group_name", null)
      host_id          = lookup(placement.value, "host_id", null)
      spread_domain    = lookup(placement.value, "spread_domain", null)
      tenancy          = lookup(placement.value, "tenancy", null)
      partition_number = lookup(placement.value, "partition_number", null)
    }
  }

  dynamic "hibernation_options" {
    iterator = hibernation_options
    for_each = var.lt_hibernation_options

    content {
      configured = lookup(hibernation_options.value, "configured", null)
    }
  }

  dynamic "tag_specifications" {
    iterator = tag_specifications
    for_each = var.lt_tag_specifications

    content {
      resource_type = lookup(tag_specifications.value, "resource_type", null)
      tags          = lookup(tag_specifications.value, "tags", null)
    }
  }

  tags = merge(
    {
      Name = var.lt_name != "" ? var.lt_name : (var.lt_name_prefix == null ? "${lower(var.name)}-lt-${lower(var.environment)}" : var.lt_name_prefix)
    },
    var.lt_tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}