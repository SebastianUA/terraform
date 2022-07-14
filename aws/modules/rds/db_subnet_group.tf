#---------------------------------------------------
# AWS DB subnet group
#---------------------------------------------------
resource "aws_db_subnet_group" "db_subnet_group" {
  count = var.enable_db_subnet_group ? 1 : 0

  name        = var.db_subnet_group_name != "" && var.db_subnet_group_name_prefix == null ? lower(var.db_subnet_group_name) : null
  name_prefix = var.db_subnet_group_name_prefix != null && var.db_subnet_group_name == "" ? lower(var.db_subnet_group_name_prefix) : null
  description = var.db_subnet_group_description
  subnet_ids  = var.db_subnet_group_subnet_ids

  tags = merge(
    {
      Name = var.db_subnet_group_name != "" ? lower(var.db_subnet_group_name) : lower(var.db_subnet_group_name_prefix)
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []

}
