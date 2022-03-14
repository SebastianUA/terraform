#---------------------------------------------------
# AWS elasticache user group
#---------------------------------------------------
resource "aws_elasticache_user_group" "elasticache_user_group" {
  count = var.elasticache_user_group ? 1 : 0

  engine        = var.elasticache_user_group_engine
  user_group_id = var.elasticache_user_group_user_group_id != "" ? var.elasticache_user_group_user_group_id : "${lower(var.name)}-${var.elasticache_replication_group_engine != "" ? var.elasticache_replication_group_engine : var.default_engine}-user-group-${lower(var.environment)}"

  user_ids = merge(var.elasticache_user_group_user_ids, aws_elasticache_user.elasticache_user[count.index].user_id)

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_elasticache_user.elasticache_user
  ]
}