#---------------------------------------------------
# AWS elasticache security group (SG)
#---------------------------------------------------
resource "aws_elasticache_security_group" "elasticache_security_group" {
  count = var.enable_elasticache_security_group ? 1 : 0

  name        = var.elasticache_security_group_name != "" ? var.elasticache_security_group_name : "${lower(var.name)}-elasticache-sg-${lower(var.environment)}"
  description = var.elasticache_security_group_description != "" ? var.elasticache_security_group_description : "Elasticache security group (SG) which managed by me"

  # NOTE: ElastiCache Subnet Groups are only for use when working with an ElastiCache cluster inside of a VPC. If you are on EC2 Classic, see the ElastiCache Security Group resource.
  # NOTE: ElastiCache Security Groups are for use only when working with an ElastiCache cluster outside of a VPC. If you are using a VPC, see the ElastiCache Subnet Group resource.
  security_group_names = var.elasticache_security_group_security_group_names

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
