#---------------------------------------------------
# AWS dms replication instance
#---------------------------------------------------
resource "aws_dms_replication_instance" "dms_replication_instance" {
  count = var.enable_dms_replication_instance ? 1 : 0

  replication_instance_class  = var.dms_replication_instance_replication_instance_class
  replication_instance_id     = var.dms_replication_instance_replication_instance_id != "" ? var.dms_replication_instance_replication_instance_id : "${lower(var.name)}-dms-replication-instance-${lower(var.environment)}"
  replication_subnet_group_id = var.dms_replication_instance_replication_subnet_group_id != "" ? var.dms_replication_instance_replication_subnet_group_id : (var.enable_dms_replication_subnet_group ? aws_dms_replication_subnet_group.dms_replication_subnet_group[0].id : null)

  allocated_storage            = var.dms_replication_instance_allocated_storage
  apply_immediately            = var.dms_replication_instance_apply_immediately
  auto_minor_version_upgrade   = var.dms_replication_instance_auto_minor_version_upgrade
  allow_major_version_upgrade  = var.dms_replication_instance_allow_major_version_upgrade
  availability_zone            = var.dms_replication_instance_availability_zone
  multi_az                     = var.dms_replication_instance_multi_az
  engine_version               = var.dms_replication_instance_engine_version
  kms_key_arn                  = var.dms_replication_instance_kms_key_arn
  preferred_maintenance_window = var.dms_replication_instance_preferred_maintenance_window
  publicly_accessible          = var.dms_replication_instance_publicly_accessible
  vpc_security_group_ids       = var.dms_replication_instance_vpc_security_group_ids

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.dms_replication_instance_timeouts)) > 0 ? [var.dms_replication_instance_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.dms_replication_instance_replication_instance_id != "" ? var.dms_replication_instance_replication_instance_id : "${lower(var.name)}-dms-replication-instance-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_dms_replication_subnet_group.dms_replication_subnet_group
  ]
}