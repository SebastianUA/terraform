# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# AWS RDS DB subnet group
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
output "rds_single_mysql_aws_db_subnet_group_id" {
  value = module.rds_single_mysql.aws_db_subnet_group_id
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# AWS RDS DB parameter group
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
output "rds_single_mysql_db_parameter_group_id" {
  value = module.rds_single_mysql.db_parameter_group_id
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# AWS RDS DB instance
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
output "rds_single_mysql_db_instance_id" {
  value = module.rds_single_mysql.db_instance_id
}

output "rds_single_mysql_db_instance_arn" {
  value = module.rds_single_mysql.db_instance_arn
}

output "rds_single_mysql_db_instance_addresses" {
  value = module.rds_single_mysql.db_instance_addresses
}

output "rds_single_mysql_db_instance_endpoint" {
  value = module.rds_single_mysql.db_instance_endpoint
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Route53
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
output "route53_rds_single_mysql_cname_route53_record_name" {
  value = module.route53_rds_single_mysql_cname.route53_record_name
}

output "route53_rds_single_mysql_cname_route53_record_fqdn" {
  value = module.route53_rds_single_mysql_cname.route53_record_fqdn
}