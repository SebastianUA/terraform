
#---------------------------------------------------
# AWS elasticache subnet group
#---------------------------------------------------
resource "aws_elasticache_subnet_group" "elasticache_subnet_group" {
  count = var.enable_elasticache_subnet_group ? 1 : 0

  name        = var.elasticache_subnet_group_name != "" ? var.elasticache_subnet_group_name : "${lower(var.name)}-subnet-group-${lower(var.environment)}"
  description = var.elasticache_subnet_group_description != "" ? var.elasticache_subnet_group_description : "Elasticache subnet group which managed by me"

  # NOTE: ElastiCache Subnet Groups are only for use when working with an ElastiCache cluster inside of a VPC. If you are on EC2 Classic, see the ElastiCache Security Group resource.
  # NOTE: ElastiCache Security Groups are for use only when working with an ElastiCache cluster outside of a VPC. If you are using a VPC, see the ElastiCache Subnet Group resource.
  subnet_ids = var.elasticache_subnet_group_subnet_ids

  tags = merge(
    {
      Name = var.elasticache_subnet_group_name != "" ? var.elasticache_subnet_group_name : "${lower(var.name)}-subnet-group-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
