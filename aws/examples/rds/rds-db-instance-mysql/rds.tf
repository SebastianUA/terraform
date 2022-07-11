#---------------------------------------------------------------
# AWS RDS
#---------------------------------------------------------------
module "rds_single_mysql" {
  source = "git@github.com:SebastianUA/terraform.git//aws/modules/rds?ref=dev"

  providers = {
    aws = aws.captainua_main
  }

  name        = local.name
  region      = local.region
  environment = local.environment

  # Enable subnet usage
  enable_db_subnet_group = true
  db_subnet_group_name   = "${local.name}-rds-cluster-subnet-group"
  db_subnet_group_subnet_ids = [
    "subnet-0743f537475e08095",
    "subnet-06d7e42d65a93cd3f",
    "subnet-0f57ced93eb09f4ce",
    "subnet-0e5ca1f82c261368c",
    "subnet-0ec38a5d0cca8e1db",
    "subnet-0946a2c76349e1191"
  ]

  # Enable db parameter group
  enable_db_parameter_group = true
  db_parameter_group_name   = "${local.name}-rds-cluster-parameter-group"
  db_parameter_group_parameters = [
    {
      name  = "character_set_server"
      value = "utf8"
    },
    {
      name  = "character_set_client"
      value = "utf8"
    },
    {
      name  = "binlog_format"
      value = "ROW"
    },
    {
      name  = "binlog_row_image"
      value = "FULL"
    }
  ]
  db_parameter_group_family = ""

  # Enable db option group
  enable_db_option_group               = false
  db_option_group_name                 = "default:mysql-5-7"
  db_option_group_engine_name          = "mysql"
  db_option_group_major_engine_version = "5.7.38"
  db_option_group_options              = []

  # Enable db instance
  enable_db_instance         = true
  number_of_instances        = 1
  db_instance_identifier     = "${local.name}-${local.environment}-rds-mysql"
  db_instance_engine         = "mysql"
  db_instance_engine_version = "5.7.38"
  db_instance_instance_class = "db.m5.large"
  db_instance_vpc_security_group_ids = [
    local.rds_security_group
  ]
  db_instance_performance_insights_enabled = true
  db_instance_skip_final_snapshot          = true

  db_instance_multi_az          = false
  db_instance_availability_zone = null

  db_instance_allocated_storage     = 100
  db_instance_max_allocated_storage = 200
  db_instance_storage_type          = "gp2" # "io1"
  db_instance_iops                  = null

  db_instance_storage_encrypted = true
  db_instance_kms_key_id        = module.kms_single_mysql.kms_key_id

  db_instance_db_name     = local.db_name
  db_instance_db_username = local.db_username
  db_instance_db_password = module.random_rds_single_mysql_password.password_result

  # Enable db instance role association
  enable_db_instance_role_association       = false
  db_instance_role_association_feature_name = ""
  db_instance_role_association_role_arn     = ""

  tags = local.tags

  depends_on = [
    module.kms_single_mysql,
    module.random_rds_single_mysql_password
  ]
}