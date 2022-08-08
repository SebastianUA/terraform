#---------------------------------------------------------------
# AWS SG
#---------------------------------------------------------------
module "sg_single_db_mysql" {
  source = "git@github.com:SebastianUA/terraform.git//aws/modules/sg?ref=dev"

  providers = {
    aws = aws.linux_notes_main
  }

  name        = local.name
  environment = local.environment

  # Enable subnet usage
  enable_security_group = true
  security_group_name   = "${local.name}-${local.environment}-dms-rds-mysql-sg"
  security_group_vpc_id = local.vpc_id

  security_group_ingress = [
    {
      from_port = -1
      to_port   = -1
      protocol  = "icmp"

      cidr_blocks = ["0.0.0.0/0"]
      description = "ICMP from VPC"
      self        = null
    },
    {
      from_port = 3306
      to_port   = 3306
      protocol  = "TCP"

      cidr_blocks = ["0.0.0.0/0"]
      description = "Mysql from VPC"
      self        = null
    }
  ]

  security_group_egress = [
    {
      from_port = 0
      to_port   = 0
      protocol  = -1

      cidr_blocks = ["0.0.0.0/0"]
      description = "All trafic to VPC"
      self        = null
    }
  ]

  tags = local.tags

  depends_on = []
}