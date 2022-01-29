#---------------------------------------------------
# AWS Instance
#---------------------------------------------------
resource "aws_instance" "instance" {
  count = var.enable_instance ? 1 : 0

  ami           = var.instance_ami != "" ? var.instance_ami : lookup(var.ami, var.region)
  instance_type = var.instance_type

  availability_zone          = var.instance_availability_zone
  placement_group            = var.instance_placement_group
  placement_partition_number = var.instance_placement_partition_number
  tenancy                    = var.instance_tenancy

  ebs_optimized = var.instance_ebs_optimized

  source_dest_check = var.instance_source_dest_check
  monitoring        = var.instance_monitoring

  subnet_id                   = var.instance_subnet_id
  associate_public_ip_address = var.instance_associate_public_ip_address
  private_ip                  = var.instance_private_ip

  ipv6_address_count = var.instance_ipv6_address_count
  ipv6_addresses     = var.instance_ipv6_addresses

  vpc_security_group_ids = var.instance_vpc_security_group_ids
  security_groups        = var.instance_security_groups
  iam_instance_profile   = var.instance_iam_instance_profile
  key_name               = var.instance_key_name

  user_data         = var.instance_user_data
  user_data_base64  = var.instance_user_data_base64
  get_password_data = var.instance_get_password_data

  disable_api_termination              = var.instance_disable_api_termination
  instance_initiated_shutdown_behavior = var.instance_initiated_shutdown_behavior

  host_id              = var.instance_host_id
  cpu_core_count       = var.instance_cpu_core_count
  cpu_threads_per_core = var.instance_cpu_threads_per_core

  hibernation           = var.instance_hibernation
  secondary_private_ips = var.instance_secondary_private_ips

  dynamic "launch_template" {
    iterator = launch_template
    for_each = length(keys(var.instance_launch_template)) > 0 ? [var.instance_launch_template] : []

    content {
      name    = lookup(launch_template.value, "name", null)
      id      = lookup(launch_template.value, "id", null)
      version = lookup(launch_template.value, "version", null)
    }
  }

  dynamic "capacity_reservation_specification" {
    iterator = capacity_reservation_specification
    for_each = var.instance_capacity_reservation_specification

    content {
      capacity_reservation_preference = lookup(capacity_reservation_specification.value, "capacity_reservation_preference", null)

      dynamic "capacity_reservation_target" {
        iterator = capacity_reservation_target
        for_each = length(keys(lookup(capacity_reservation_specification.value, "capacity_reservation_target", {}))) > 0 ? [lookup(capacity_reservation_specification.value, "capacity_reservation_target", {})] : []

        content {
          capacity_reservation_id = lookup(capacity_reservation_target.value, "capacity_reservation_id", null)
        }
      }
    }
  }

  dynamic "credit_specification" {
    iterator = credit_specification
    for_each = var.instance_credit_specification

    content {
      cpu_credits = lookup(credit_specification.value, "cpu_credits", null)
    }
  }

  dynamic "enclave_options" {
    iterator = enclave_options
    for_each = length(keys(var.instance_enclave_options)) > 0 ? [var.instance_enclave_options] : []

    content {
      enabled = lookup(enclave_options.value, "enabled", null)
    }
  }

  dynamic "metadata_options" {
    iterator = metadata_options
    for_each = length(keys(var.instance_metadata_options)) > 0 ? [var.instance_metadata_options] : []

    content {
      http_endpoint               = lookup(metadata_options.value, "http_endpoint", null)
      http_put_response_hop_limit = lookup(metadata_options.value, "http_put_response_hop_limit", null)
      http_tokens                 = lookup(metadata_options.value, "http_tokens", null)
    }
  }

  dynamic "ebs_block_device" {
    iterator = ebs_block_device
    for_each = var.instance_ebs_block_device

    content {
      delete_on_termination = lookup(ebs_block_device.value, "delete_on_termination", null)
      device_name           = lookup(ebs_block_device.value, "device_name", null)
      encrypted             = lookup(ebs_block_device.value, "encrypted", null)
      iops                  = lookup(ebs_block_device.value, "iops", null)
      snapshot_id           = lookup(ebs_block_device.value, "snapshot_id", null)
      volume_size           = lookup(ebs_block_device.value, "volume_size", null)
      volume_type           = lookup(ebs_block_device.value, "volume_type", null)
      kms_key_id            = lookup(ebs_block_device.value, "kms_key_id", null)

      throughput = lookup(ebs_block_device.value, "throughput", null)
      tags       = lookup(ebs_block_device.value, "tags", null)
    }
  }

  dynamic "ephemeral_block_device" {
    iterator = ephemeral_block_device
    for_each = var.instance_ephemeral_block_device

    content {
      device_name  = lookup(root_block_device.value, "device_name", null)
      virtual_name = lookup(root_block_device.value, "virtual_name", null)
      no_device    = lookup(root_block_device.value, "no_device", null)
    }
  }

  dynamic "root_block_device" {
    iterator = root_block_device
    for_each = var.instance_root_block_device

    content {
      delete_on_termination = lookup(root_block_device.value, "delete_on_termination", null)
      iops                  = lookup(root_block_device.value, "iops", null)
      volume_size           = lookup(root_block_device.value, "volume_size", null)
      volume_type           = lookup(root_block_device.value, "volume_type", null)
      encrypted             = lookup(root_block_device.value, "encrypted", null)

      kms_key_id = lookup(root_block_device.value, "kms_key_id", null)
      throughput = lookup(root_block_device.value, "throughput", null)

      tags = lookup(root_block_device.value, "tags", null)
    }
  }

  dynamic "network_interface" {
    iterator = network_interface
    for_each = var.instance_network_interface

    content {
      device_index         = lookup(network_interface.value, "device_index", null)
      network_interface_id = lookup(network_interface.value, "network_interface_id", null)

      delete_on_termination = lookup(network_interface.value, "delete_on_termination", null)
    }
  }

  volume_tags = merge(
    {
      "Name" = var.instance_name != "" ? var.instance_name : "${lower(var.name)}-ec2-${lower(var.environment)}"
    },
    var.instance_volume_tags
  )

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.instance_timeouts)) > 0 ? [var.instance_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.instance_name != "" ? var.instance_name : "${lower(var.name)}-ec2-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
