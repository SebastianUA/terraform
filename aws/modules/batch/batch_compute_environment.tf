#---------------------------------------------------
# AWS Batch compute environment
#---------------------------------------------------
resource "aws_batch_compute_environment" "batch_compute_environment" {
    count                               = var.enable_batch_compute_environment ? 1 : 0

    compute_environment_name            = var.batch_compute_environment_name != null && var.batch_compute_environment_name_prefix == null ? lower(var.batch_compute_environment_name) : null
    compute_environment_name_prefix     = var.batch_compute_environment_name_prefix
    service_role                        = var.batch_compute_environment_service_role
    type                                = upper(var.batch_compute_environment_type)

    state                               = upper(var.batch_compute_environment_state)

    dynamic "compute_resources" {
        iterator = compute_resources
        for_each = var.batch_compute_environment_compute_resources
        content {
            instance_role           = lookup(compute_resources.value, "instance_role", null)
            instance_type           = lookup(compute_resources.value, "instance_type", null)
            max_vcpus               = lookup(compute_resources.value, "max_vcpus", null)
            min_vcpus               = lookup(compute_resources.value, "min_vcpus", null)
            security_group_ids      = lookup(compute_resources.value, "security_group_ids", null)
            subnets                 = lookup(compute_resources.value, "subnets", null)
            type                    = lookup(compute_resources.value, "type", null)

            allocation_strategy     = lookup(compute_resources.value, "allocation_strategy", null)
            bid_percentage          = lookup(compute_resources.value, "bid_percentage", null)
            desired_vcpus           = lookup(compute_resources.value, "desired_vcpus", null)
            ec2_key_pair            = lookup(compute_resources.value, "ec2_key_pair", null)
            image_id                = lookup(compute_resources.value, "image_id", null)
            spot_iam_fleet_role     = lookup(compute_resources.value, "spot_iam_fleet_role", null)
            tags                    = lookup(compute_resources.value, "tags", null)

            launch_template {
                launch_template_id      = lookup(compute_resources.value, "launch_template_id", null)
                launch_template_name    = lookup(compute_resources.value, "launch_template_name", null)
                version                 = lookup(compute_resources.value, "version", null)
            }
        }
    }

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on                          = []
}
