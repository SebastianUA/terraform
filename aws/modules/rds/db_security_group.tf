#---------------------------------------------------
# AWS DB security group
#---------------------------------------------------
resource "aws_db_security_group" "db_security_group" {
  count = var.enable_db_security_group ? 1 : 0

  name        = var.db_security_group_name != "" ? lower(var.db_security_group_name) : "${lower(var.name)}-db-sg-${lower(var.environment)}"
  description = var.db_security_group_description != "" ? lower(var.db_security_group_description) : null

  dynamic "ingress" {
    iterator = ingress
    for_each = var.db_security_group_ingress

    content {
      cidr                    = lookup(ingress.value, "cidr", null)
      security_group_name     = lookup(ingress.value, "security_group_name", null)
      security_group_id       = lookup(ingress.value, "security_group_id", null)
      security_group_owner_id = lookup(ingress.value, "security_group_owner_id", null)
    }
  }

  tags = merge(
    {
      Name = var.db_security_group_name != "" ? lower(var.db_security_group_name) : "${lower(var.name)}-db-sg-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []

}
