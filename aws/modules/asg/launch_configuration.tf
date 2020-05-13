#---------------------------------------------------
# Launch AWS configuration
#---------------------------------------------------
resource "aws_launch_configuration" "lc" {
    count                       = var.enable_lc && var.name_prefix =="" ? 1 : 0

    name                        = var.launch_configuration_name != "" ? var.launch_configuration_name : "${lower(var.name)}-lc-${lower(var.environment)}"
    image_id                    = lookup(var.ami, var.region)
    instance_type               = var.ec2_instance_type
    security_groups             = var.security_groups
    iam_instance_profile        = var.iam_instance_profile

    key_name                    = var.key_name
    user_data                   = data.template_file.user_data.rendered

    #associate_public_ip_address = var.enable_associate_public_ip_address
    associate_public_ip_address = !var.enable_asg_azs ? var.enable_associate_public_ip_address : null
    enable_monitoring           = var.enable_monitoring
    placement_tenancy           = var.placement_tenancy

    ebs_optimized               = var.ebs_optimized

    dynamic "ebs_block_device" {
        for_each = var.ebs_block_device
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
        for_each = var.ephemeral_block_device
        content {
            device_name  = ephemeral_block_device.value.device_name
            virtual_name = ephemeral_block_device.value.virtual_name
        }
    }

    dynamic "root_block_device" {
        for_each = var.root_block_device
        content {
            delete_on_termination = lookup(root_block_device.value, "delete_on_termination", null)
            iops                  = lookup(root_block_device.value, "iops", null)
            volume_size           = lookup(root_block_device.value, "volume_size", null)
            volume_type           = lookup(root_block_device.value, "volume_type", null)
            encrypted             = lookup(root_block_device.value, "encrypted", null)
        }
    }

    lifecycle {
        create_before_destroy   = false
        ignore_changes          = []
    }

    depends_on                  = []
}

resource "aws_launch_configuration" "lc_spot" {
    count                       = var.enable_lc_spot && var.name_prefix =="" ? 1 : 0

    name                        = var.launch_configuration_name != "" ? var.launch_configuration_name : "${lower(var.name)}-lc_spot-${lower(var.environment)}"
    image_id                    = lookup(var.ami, var.region)
    instance_type               = var.ec2_instance_type
    security_groups             = var.security_groups
    iam_instance_profile        = var.iam_instance_profile

    key_name                    = var.key_name
    user_data                   = data.template_file.user_data.rendered

    #associate_public_ip_address = var.enable_associate_public_ip_address
    associate_public_ip_address = !var.enable_asg_azs ? var.enable_associate_public_ip_address : null
    enable_monitoring           = var.enable_monitoring
    spot_price                  = var.spot_price

    ebs_optimized               = var.ebs_optimized

    dynamic "ebs_block_device" {
        for_each = var.ebs_block_device
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
        for_each = var.ephemeral_block_device
        content {
            device_name  = ephemeral_block_device.value.device_name
            virtual_name = ephemeral_block_device.value.virtual_name
        }
    }

    dynamic "root_block_device" {
        for_each = var.root_block_device
        content {
            delete_on_termination = lookup(root_block_device.value, "delete_on_termination", null)
            iops                  = lookup(root_block_device.value, "iops", null)
            volume_size           = lookup(root_block_device.value, "volume_size", null)
            volume_type           = lookup(root_block_device.value, "volume_type", null)
            encrypted             = lookup(root_block_device.value, "encrypted", null)
        }
    }

    lifecycle {
        create_before_destroy   = false
        ignore_changes          = []
    }

    depends_on                  = []
}

resource "aws_launch_configuration" "lc_prefix" {
    count                       = var.enable_lc && var.name_prefix !="" ? 1 : 0

    name_prefix                 = var.name_prefix
    image_id                    = lookup(var.ami, var.region)
    instance_type               = var.ec2_instance_type
    security_groups             = var.security_groups
    iam_instance_profile        = var.iam_instance_profile

    key_name                    = var.key_name
    user_data                   = data.template_file.user_data.rendered

    associate_public_ip_address = !var.enable_asg_azs ? var.enable_associate_public_ip_address : null

    enable_monitoring           = var.enable_monitoring
    placement_tenancy           = var.placement_tenancy

    ebs_optimized               = var.ebs_optimized

    dynamic "ebs_block_device" {
        for_each = var.ebs_block_device
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
        for_each = var.ephemeral_block_device
        content {
            device_name  = ephemeral_block_device.value.device_name
            virtual_name = ephemeral_block_device.value.virtual_name
        }
    }

    dynamic "root_block_device" {
        for_each = var.root_block_device
        content {
            delete_on_termination = lookup(root_block_device.value, "delete_on_termination", null)
            iops                  = lookup(root_block_device.value, "iops", null)
            volume_size           = lookup(root_block_device.value, "volume_size", null)
            volume_type           = lookup(root_block_device.value, "volume_type", null)
            encrypted             = lookup(root_block_device.value, "encrypted", null)
        }
    }

    lifecycle {
        create_before_destroy   = false
        ignore_changes          = []
    }

    depends_on                  = []
}

resource "aws_launch_configuration" "lc_spot_prefix" {
    count                       = var.enable_lc_spot && var.name_prefix !="" ? 1 : 0

    name_prefix                 = var.name_prefix
    image_id                    = lookup(var.ami, var.region)
    instance_type               = var.ec2_instance_type
    security_groups             = var.security_groups
    iam_instance_profile        = var.iam_instance_profile

    key_name                    = var.key_name
    user_data                   = data.template_file.user_data.rendered

    associate_public_ip_address = !var.enable_asg_azs ? var.enable_associate_public_ip_address : null
    enable_monitoring           = var.enable_monitoring
    spot_price                  = var.spot_price

    ebs_optimized               = var.ebs_optimized

    dynamic "ebs_block_device" {
        for_each = var.ebs_block_device
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
        for_each = var.ephemeral_block_device
        content {
            device_name  = ephemeral_block_device.value.device_name
            virtual_name = ephemeral_block_device.value.virtual_name
        }
    }

    dynamic "root_block_device" {
        for_each = var.root_block_device
        content {
            delete_on_termination = lookup(root_block_device.value, "delete_on_termination", null)
            iops                  = lookup(root_block_device.value, "iops", null)
            volume_size           = lookup(root_block_device.value, "volume_size", null)
            volume_type           = lookup(root_block_device.value, "volume_type", null)
            encrypted             = lookup(root_block_device.value, "encrypted", null)
        }
    }

    lifecycle {
        create_before_destroy   = false
        ignore_changes          = []
    }

    depends_on                  = []
}

data "template_file" "user_data" {
    template = var.user_data
}
