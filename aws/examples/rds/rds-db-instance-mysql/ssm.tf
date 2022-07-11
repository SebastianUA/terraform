# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Save RDS settings (DB, username, dbpassword) 
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
module "ssm_rds_single_mysql_dbname" {
  source = "git@github.com:SebastianUA/terraform.git//aws/modules/ssm?ref=v15.15.15"

  providers = {
    aws = aws.captainua_main
  }

  name        = "${local.name}-ssm"
  environment = local.environment

  enable_ssm_parameter      = true
  ssm_parameter_name        = "/${local.name}/rds/dbname"
  ssm_parameter_type        = "String"
  ssm_parameter_value       = local.db_name
  ssm_parameter_description = "RDS (${local.name}) db name"

  tags = local.tags

  depends_on = []
}

module "ssm_rds_single_mysql_dbusername" {
  source = "git@github.com:SebastianUA/terraform.git//aws/modules/ssm?ref=v15.15.15"

  providers = {
    aws = aws.captainua_main
  }

  name        = "${local.name}-ssm"
  environment = local.environment

  enable_ssm_parameter      = true
  ssm_parameter_name        = "/${local.name}/rds/dbusername"
  ssm_parameter_type        = "String"
  ssm_parameter_value       = local.db_username
  ssm_parameter_description = "RDS (${local.name}) db username"

  tags = local.tags

  depends_on = []
}

module "ssm_rds_single_mysql_dbpassword" {
  source = "git@github.com:SebastianUA/terraform.git//aws/modules/ssm?ref=v15.15.15"

  providers = {
    aws = aws.captainua_main
  }

  name        = "${local.name}-ssm"
  environment = local.environment

  enable_ssm_parameter      = true
  ssm_parameter_name        = "/${local.name}/rds/dbpassword"
  ssm_parameter_type        = "SecureString"
  ssm_parameter_value       = module.random_rds_single_mysql_password.password_result
  ssm_parameter_description = "RDS (${local.name}) db password"

  tags = local.tags

  depends_on = [
    module.random_rds_single_mysql_password
  ]
}