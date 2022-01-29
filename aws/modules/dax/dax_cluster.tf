#---------------------------------------------------
# AWS dax cluster
#---------------------------------------------------
resource "aws_dax_cluster" "dax_cluster" {
  count = var.enable_dax_cluster ? 1 : 0

  cluster_name       = var.dax_cluster_name != "" ? lower(var.dax_cluster_name) : "${lower(var.name)}-dax-cluster-${lower(var.environment)}"
  iam_role_arn       = var.dax_cluster_iam_role_arn
  node_type          = var.dax_cluster_node_type
  replication_factor = var.dax_cluster_replication_factor

  availability_zones     = var.dax_cluster_availability_zones
  description            = var.dax_cluster_description
  notification_topic_arn = var.dax_cluster_notification_topic_arn
  parameter_group_name   = var.dax_cluster_parameter_group_name != "" && !var.enable_dax_parameter_group ? var.dax_cluster_parameter_group_name : element(concat(aws_dax_parameter_group.dax_parameter_group.*.id, [""]), 0)
  maintenance_window     = var.dax_cluster_maintenance_window
  security_group_ids     = var.dax_cluster_security_group_ids
  subnet_group_name      = var.dax_cluster_subnet_group_name != "" && !var.enable_dax_subnet_group ? var.dax_cluster_subnet_group_name : element(concat(aws_dax_subnet_group.dax_subnet_group.*.id, [""]), 0)

  dynamic "server_side_encryption" {
    iterator = serversideenc
    for_each = var.dax_cluster_server_side_encryption

    content {
      enabled = lookup(serversideenc.value, "enabled", false)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.dax_cluster_timeouts)) > 0 ? [var.dax_cluster_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.dax_cluster_name != "" ? lower(var.dax_cluster_name) : "${lower(var.name)}-dax-cluster-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_dax_parameter_group.dax_parameter_group,
    aws_dax_subnet_group.dax_subnet_group
  ]
}
