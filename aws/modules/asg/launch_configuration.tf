#---------------------------------------------------
# Launch AWS configuration
#---------------------------------------------------
data "template_file" "lc_user_data" {
  count = var.lc_user_data != null ? 1 : 0

  template = var.lc_user_data
}

resource "aws_launch_configuration" "lc" {
  count = var.enable_lc ? 1 : 0

  name                 = var.lc_name != "" ? var.lc_name : (var.lc_name_prefix == null ? "${lower(var.name)}-lc-${lower(var.environment)}" : null)
  name_prefix          = var.lc_name_prefix != null ? var.lc_name_prefix : (var.lc_name != "" ? null : var.lc_name_prefix)
  image_id             = var.lc_image_id != "" ? var.lc_image_id : lookup(var.ami, var.region)
  instance_type        = var.lc_instance_type
  security_groups      = var.lc_security_groups
  iam_instance_profile = var.lc_iam_instance_profile

  key_name  = var.lc_key_name
  user_data = var.lc_user_data != null ? data.template_file.lc_user_data[0].rendered : var.lc_user_data

  associate_public_ip_address = var.lc_associate_public_ip_address
  enable_monitoring           = var.lc_enable_monitoring
  placement_tenancy           = var.lc_placement_tenancy
  spot_price                  = var.lc_spot_price
  ebs_optimized               = var.lc_ebs_optimized

  dynamic "ebs_block_device" {
    iterator = ebs_block_device
    for_each = var.lc_ebs_block_device

    content {
      delete_on_termination = lookup(ebs_block_device.value, "delete_on_termination", null)
      device_name           = ebs_block_device.value.device_name
      encrypted             = lookup(ebs_block_device.value, "encrypted", null)
      iops                  = lookup(ebs_block_device.value, "iops", null)
      no_device             = lookup(ebs_block_device.value, "no_device", null)
      snapshot_id           = lookup(ebs_block_device.value, "snapshot_id", null)
      volume_size           = lookup(ebs_block_device.value, "volume_size", null)
      volume_type           = lookup(ebs_block_device.value, "volume_type", null)
    }
  }

  dynamic "ephemeral_block_device" {
    iterator = ephemeral_block_device
    for_each = var.lc_ephemeral_block_device

    content {
      device_name  = ephemeral_block_device.value.device_name
      virtual_name = ephemeral_block_device.value.virtual_name
    }
  }

  dynamic "root_block_device" {
    iterator = root_block_device
    for_each = length(keys(var.lc_root_block_device)) > 0 ? [var.lc_root_block_device] : []

    content {
      delete_on_termination = lookup(root_block_device.value, "delete_on_termination", null)
      iops                  = lookup(root_block_device.value, "iops", null)
      volume_size           = lookup(root_block_device.value, "volume_size", null)
      volume_type           = lookup(root_block_device.value, "volume_type", null)
      encrypted             = lookup(root_block_device.value, "encrypted", null)
    }
  }

  lifecycle {
    create_before_destroy = false
    ignore_changes        = []
  }

  depends_on = []
}
