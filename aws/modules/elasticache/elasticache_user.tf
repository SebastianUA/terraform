#---------------------------------------------------
# AWS elasticache user
#---------------------------------------------------
resource "aws_elasticache_user" "elasticache_user" {
  count = var.elasticache_user ? 1 : 0

  access_string = var.elasticache_user_access_string
  engine        = var.elasticache_user_engine
  user_id       = var.elasticache_user_user_id
  user_name     = var.elasticache_user_user_name

  passwords            = var.elasticache_user_passwords
  no_password_required = var.elasticache_user_no_password_required

  tags = merge(
    {
      Name = var.elasticache_user_user_name != "" ? var.elasticache_user_user_name : "${lower(var.name)}-${var.elasticache_replication_group_engine != "" ? var.elasticache_replication_group_engine : var.default_engine}-elasticache-user-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
