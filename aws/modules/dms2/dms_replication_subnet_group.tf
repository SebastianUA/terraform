#---------------------------------------------------
# AWS dms replication subnet group
#---------------------------------------------------
resource "aws_dms_replication_subnet_group" "dms_replication_subnet_group" {
  count = var.enable_dms_replication_subnet_group ? 1 : 0

  replication_subnet_group_id          = var.dms_replication_subnet_group_replication_subnet_group_id != "" ? var.dms_replication_subnet_group_replication_subnet_group_id : "${lower(var.name)}-dms-replication-subnet-group-${lower(var.environment)}"
  replication_subnet_group_description = var.dms_replication_subnet_group_replication_subnet_group_description != "" ? var.dms_replication_subnet_group_replication_subnet_group_description : "The dms replication subnet group"
  subnet_ids                           = var.dms_replication_subnet_group_subnet_ids

  tags = merge(
    {
      Name = var.dms_replication_subnet_group_replication_subnet_group_id != "" ? var.dms_replication_subnet_group_replication_subnet_group_id : "${lower(var.name)}-dms-replication-subnet-group-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}