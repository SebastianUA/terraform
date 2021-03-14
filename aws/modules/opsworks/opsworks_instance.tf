#---------------------------------------------------
# AWS opsworks instance
#---------------------------------------------------
resource "aws_opsworks_instance" "opsworks_instance" {
  count = var.enable_opsworks_instance ? 1 : 0

  stack_id      = var.opsworks_instance_stack_id != "" && ! var.enable_opsworks_stack ? var.opsworks_instance_stack_id : element(concat(aws_opsworks_stack.opsworks_stack.*.id, [""]), 0)
  layer_ids     = length(var.opsworks_instance_layer_ids) > 0 && ! var.enable_opsworks_custom_layer ? var.opsworks_instance_layer_ids : [element(concat(aws_opsworks_custom_layer.opsworks_custom_layer.*.id, [""]), 0)]
  instance_type = var.opsworks_instance_instance_type

  state                   = var.opsworks_instance_state
  os                      = var.opsworks_instance_os
  ami_id                  = var.opsworks_instance_ami_id
  install_updates_on_boot = var.opsworks_instance_install_updates_on_boot
  auto_scaling_type       = var.opsworks_instance_auto_scaling_type
  availability_zone       = var.opsworks_instance_availability_zone
  ebs_optimized           = var.opsworks_instance_ebs_optimized
  hostname                = var.opsworks_instance_hostname
  architecture            = var.opsworks_instance_architecture
  root_device_type        = var.opsworks_instance_root_device_type
  ssh_key_name            = var.opsworks_instance_ssh_key_name
  agent_version           = var.opsworks_instance_agent_version
  subnet_id               = var.opsworks_instance_subnet_id
  tenancy                 = var.opsworks_instance_tenancy
  virtualization_type     = var.opsworks_instance_virtualization_type

  dynamic "root_block_device" {
    for_each = var.opsworks_instance_root_block_device
    content {
      volume_type           = lookup(opsworks_instance_root_block_device.value, "volume_type", null)
      volume_size           = lookup(opsworks_instance_root_block_device.value, "volume_size", null)
      iops                  = lookup(opsworks_instance_root_block_device.value, "iops", null)
      delete_on_termination = lookup(opsworks_instance_root_block_device.value, "delete_on_termination", null)
    }
  }

  dynamic "ebs_block_device" {
    for_each = var.opsworks_instance_ebs_block_device
    content {
      device_name           = lookup(opsworks_instance_ebs_block_device.value, "device_name", null)
      snapshot_id           = lookup(opsworks_instance_ebs_block_device.value, "snapshot_id", null)
      volume_type           = lookup(opsworks_instance_ebs_block_device.value, "volume_type", null)
      volume_size           = lookup(opsworks_instance_ebs_block_device.value, "volume_size", null)
      iops                  = lookup(opsworks_instance_ebs_block_device.value, "iops", null)
      delete_on_termination = lookup(opsworks_instance_ebs_block_device.value, "delete_on_termination", null)
    }
  }

  dynamic "ephemeral_block_device" {
    for_each = var.opsworks_instance_ephemeral_block_device
    content {
      device_name  = lookup(opsworks_instance_ephemeral_block_device.value, "device_name", null)
      virtual_name = lookup(opsworks_instance_ephemeral_block_device.value, "virtual_name", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = var.opsworks_instance_timeouts
    content {
      create = lookup(timeouts.value, "create", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_opsworks_stack.opsworks_stack,
    aws_opsworks_custom_layer.opsworks_custom_layer
  ]
}
